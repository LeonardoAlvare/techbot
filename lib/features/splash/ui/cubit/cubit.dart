// lib/features/auth/ui/splash/cubit/cubit.dart
import 'package:cookie_jar/cookie_jar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/features/auth/repository/repository.dart';

part 'state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository, this._cookieJar) : super(SplashInitial());

  final AuthRepository _authRepository;
  final CookieJar _cookieJar;

  Future<void> checkSession() async {
    try {
      final uri = Uri.parse(ApiUrl.baseUrl);
      final cookies = await _cookieJar.loadForRequest(uri);

      final refreshCookie = cookies.firstWhere(
        (c) => c.name == 'refreshToken',
        orElse: () => Cookie('refreshToken', ''),
      );

      if (refreshCookie.value.isEmpty) {
        emit(SplashUnauthenticated());
        return;
      }

      final authModel = await _authRepository.refresh(refreshCookie.value);
      getIt<AuthSession>().setToken(authModel.accessToken);

      emit(SplashAuthenticated());
    } catch (_) {
      emit(SplashUnauthenticated());
    }
  }
}
