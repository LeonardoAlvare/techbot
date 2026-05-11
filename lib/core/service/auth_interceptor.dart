import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/features/auth/repository/repository.dart';

class AuthInterceptor extends Interceptor {
  final AuthSession authSession;
  final AuthRepository authRepository;
  final CookieJar cookieJar;
  final Dio dio;

  AuthInterceptor({
    required this.authSession,
    required this.authRepository,
    required this.cookieJar,
    required this.dio,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = authSession.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _getRefreshTokenFromCookies();

        if (refreshToken == null) {
          authSession.clear();
          return handler.next(err);
        }

        final authModel = await authRepository.refresh(refreshToken);
        authSession.setToken(authModel.accessToken);

        final retryResponse = await _retry(err.requestOptions);
        return handler.resolve(retryResponse);
      } catch (_) {
        authSession.clear();
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  Future<String?> _getRefreshTokenFromCookies() async {
    final uri = Uri.parse(ApiUrl.baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    final cookie = cookies.firstWhere(
      (c) => c.name == 'refreshToken',
      orElse: () => Cookie('refreshToken', ''),
    );
    return cookie.value.isEmpty ? null : cookie.value;
  }

  Future<Response> _retry(RequestOptions requestOptions) {
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: {
          ...requestOptions.headers,
          'Authorization': 'Bearer ${authSession.accessToken}',
        },
      ),
    );
  }
}
