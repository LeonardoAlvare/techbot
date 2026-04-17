import 'package:dio/dio.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/features/auth/models/auth_model.dart';
import 'package:techbot/features/auth/repository/repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final Dio dio;

  AuthRepositoryImp(this.dio);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '${ApiUrl.baseUrl}/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthModel.fromJson(response.data);
  }

  @override
  Future<AuthModel> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '${ApiUrl.baseUrl}/auth/register',
      data: {
        'name': name,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    );

    return AuthModel.fromJson(response.data);
  }
}
