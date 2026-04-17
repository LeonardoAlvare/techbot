import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/auth/models/auth_model.dart';
import 'package:techbot/features/auth/repository/repository.dart';

// TODO: Delete logs
class AuthRepositoryImp implements AuthRepository {
  final Dio dio;

  AuthRepositoryImp(this.dio);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final url = '${ApiUrl.baseUrl}/auth/login';
    final payload = {'email': email, 'password': password};

    try {
      log('--- LOGIN REQUEST START ---');
      log('URL: $url');
      log('Payload: $payload');

      final response = await dio.post(url, data: payload);

      log('--- LOGIN RESPONSE SUCCESS ---');
      log('Status Code: ${response.statusCode}');
      log('Data: ${response.data}');

      final authModel = AuthModel.fromJson(response.data);
      log('--- ACCESS TOKEN ---');
      log(authModel.accessToken);

      log('--- COOKIES (Set-Cookie Header) ---');
      final cookies = response.headers['set-cookie'];
      log(cookies?.toString() ?? 'No cookies found in headers');

      return authModel;
    } on DioException catch (e) {
      log('--- LOGIN REQUEST ERROR (DioException) ---');
      log('Status Code: ${e.response?.statusCode}');
      log('Error Data: ${e.response?.data}');
      log('Message: ${e.message}');
      log('Error Type: ${e.type}');
      rethrow;
    } catch (e) {
      log('--- LOGIN REQUEST ERROR (General) ---');
      log('Error: $e');
      rethrow;
    }
  }

  @override
  Future<AuthModel> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = '${ApiUrl.baseUrl}/auth/register';
    final payload = {
      'name': name,
      'lastName': lastName,
      'email': email,
      'password': password,
    };

    try {
      log('--- REGISTER REQUEST START ---');
      log('URL: $url');
      log('Payload: $payload');

      final response = await dio.post(url, data: payload);

      log('--- REGISTER RESPONSE SUCCESS ---');
      log('Status Code: ${response.statusCode}');
      log('Data: ${response.data}');

      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      log('--- REGISTER REQUEST ERROR (DioException) ---');
      log('Status Code: ${e.response?.statusCode}');
      log('Error Data: ${e.response?.data}');
      log('Message: ${e.message}');
      log('Error Type: ${e.type}');
      rethrow;
    } catch (e) {
      log('--- REGISTER REQUEST ERROR (General) ---');
      log('Error: $e');
      rethrow;
    }
  }
}
