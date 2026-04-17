import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      await repository.login(
        email: state.model.email,
        password: state.model.password,
      );
      emit(LoginSuccess(state.model));
    } catch (e) {
      emit(LoginError(state.model));
    }
  }
}
