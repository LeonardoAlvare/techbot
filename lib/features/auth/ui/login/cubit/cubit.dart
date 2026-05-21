import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/core/service/biometric_service.dart';
import 'package:techbot/features/auth/models/auth_model.dart';
import 'package:techbot/features/auth/repository/repository.dart';

part 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.repository) : super(LoginInitial(Model()));

  final AuthRepository repository;

  void setEmail(String email) {
    emit(UpdateInput(state.model.copyWith(email: email)));
  }

  void setPassword(String password) {
    emit(UpdateInput(state.model.copyWith(password: password)));
  }

  void togglePasswordVisibility() {
    emit(
      ChangeVisibility(
        state.model.copyWith(isPasswordVisible: !state.model.isPasswordVisible),
      ),
    );
  }

  Future<void> login() async {
    emit(LoginLoading(state.model));

    try {
      final authModel = await repository.login(
        email: state.model.email,
        password: state.model.password,
      );
      getIt<AuthSession>().setToken(authModel.accessToken);

      final biometricService = getIt<BiometricService>();
      if (await biometricService.isAvailable()) {
        await biometricService.saveCredentials(
          state.model.email,
          state.model.password,
        );
      }
      emit(LoginSuccess(state.model, authModel));
    } catch (e) {
      emit(LoginError(state.model, e.toString()));
    }
  }

  Future<void> loginWithBiometric() async {
    emit(LoginLoading(state.model));
    try {
      final biometricService = getIt<BiometricService>();

      final authenticated = await biometricService.authenticate();
      if (!authenticated) {
        emit(LoginError(state.model, 'Autenticación biométrica cancelada'));
        return;
      }

      final credentials = await biometricService.getCredentials();
      if (credentials == null) {
        emit(LoginError(state.model, 'No hay credenciales guardadas'));
        return;
      }

      final authModel = await repository.login(
        email: credentials.email,
        password: credentials.password,
      );
      getIt<AuthSession>().setToken(authModel.accessToken);
      emit(LoginSuccess(state.model, authModel));
    } catch (e) {
      emit(LoginError(state.model, e.toString()));
    }
  }
}
