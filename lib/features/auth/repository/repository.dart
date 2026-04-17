import 'package:techbot/features/auth/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login({required String email, required String password});
  Future<AuthModel> register({
    required String name,
    required String lastName,
    required String email,
    required String password,
  });
}
