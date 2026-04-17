part of 'cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState(this.model);

  final Model model;

  @override
  List<Object> get props => [model];
}

final class LoginInitial extends LoginState {
  const LoginInitial(super.model);
}

final class LoginLoading extends LoginState {
  const LoginLoading(super.model);
}

final class LoginSuccess extends LoginState {
  final AuthModel authModel;
  const LoginSuccess(super.model, this.authModel);

  @override
  List<Object> get props => [model, authModel];
}

final class LoginError extends LoginState {
  const LoginError(super.model);
}

final class UpdateInput extends LoginState {
  const UpdateInput(super.model);
}

final class ChangeVisibility extends LoginState {
  const ChangeVisibility(super.model);
}

class Model extends Equatable {
  final String email;
  final String password;
  final bool isPasswordVisible;

  const Model({
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
  });

  Model copyWith({String? email, String? password, bool? isPasswordVisible}) {
    return Model(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object> get props => [email, password, isPasswordVisible];
}
