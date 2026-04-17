part of 'cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState(this.model);

  final Model model;

  @override
  List<Object> get props => [model];
}

final class RegisterInitial extends RegisterState {
  const RegisterInitial(super.model);
}

final class UpdateInput extends RegisterState {
  const UpdateInput(super.model);
}

final class ChangeVisibility extends RegisterState {
  const ChangeVisibility(super.model);
}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess(super.model, this.authModel);

  final AuthModel authModel;

  @override
  List<Object> get props => [model, authModel];
}

final class RegisterError extends RegisterState {
  const RegisterError(super.model);
}

final class RegisterLoading extends RegisterState {
  const RegisterLoading(super.model);
}

class Model {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final bool isConfirmPasswordVisible;
  final String confirmPassword;
  final bool isPasswordVisible;

  const Model({
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.isConfirmPasswordVisible = false,
    this.confirmPassword = '',
    this.isPasswordVisible = false,
  });

  Model copyWith({
    String? name,
    String? lastName,
    String? email,
    String? password,
    bool? isConfirmPasswordVisible,
    String? confirmPassword,
    bool? isPasswordVisible,
  }) {
    return Model(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  List<Object?> get props => [
    name,
    lastName,
    email,
    password,
    isConfirmPasswordVisible,
    confirmPassword,
    isPasswordVisible,
  ];
}
