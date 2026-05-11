import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/features/auth/models/auth_model.dart';
import 'package:techbot/features/auth/repository/repository.dart';

part 'state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repository) : super(RegisterInitial(Model()));

  final AuthRepository repository;

  void setName(String name) {
    emit(UpdateInput(state.model.copyWith(name: name)));
  }

  void setLastName(String lastName) {
    emit(UpdateInput(state.model.copyWith(lastName: lastName)));
  }

  void setEmail(String email) {
    emit(UpdateInput(state.model.copyWith(email: email)));
  }

  void setPassword(String password) {
    emit(UpdateInput(state.model.copyWith(password: password)));
  }

  void setIsPasswordVisible(bool isPasswordVisible) {
    emit(
      UpdateInput(state.model.copyWith(isPasswordVisible: isPasswordVisible)),
    );
  }

  void setConfirmPassword(String confirmPassword) {
    emit(UpdateInput(state.model.copyWith(confirmPassword: confirmPassword)));
  }

  void togglePasswordVisibility() {
    emit(
      ChangeVisibility(
        state.model.copyWith(isPasswordVisible: !state.model.isPasswordVisible),
      ),
    );
  }

  Future<void> register() async {
    emit(RegisterLoading(state.model));
    try {
      final authModel = await repository.register(
        name: state.model.name,
        lastName: state.model.lastName,
        email: state.model.email,
        password: state.model.password,
      );
      getIt<AuthSession>().setToken(authModel.accessToken);
      emit(RegisterSuccess(state.model, authModel));
    } catch (e) {
      emit(RegisterError(state.model));
    }
  }
}
