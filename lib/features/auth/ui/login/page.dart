import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/core/widgets/inputs.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/widgets/background.dart';
import 'package:techbot/features/auth/ui/widgets/result_alert.dart';

class PageLogin extends StatelessWidget {
  final LoginCubit loginCubit;

  const PageLogin({super.key, required this.loginCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: loginCubit,
      child: Scaffold(body: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showResultAlert(
            context,
            icon: Icons.check_rounded,
            iconColor: Color(0xFF22C55E),
            title: '¡Bienvenido!',
            subtitle: 'Has iniciado sesión correctamente.',
          );
        }
        if (state is LoginError) {
          showResultAlert(
            context,
            icon: Icons.error_rounded,
            iconColor: Color(0xFFE53935),
            title: '¡Ups!',
            subtitle: 'Error al iniciar sesión.',
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            const BackgroundAuth(),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 36,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Avatar
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: CustomColors.lavender,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.person,
                                color: CustomColors.primary,
                                size: 40,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // Título
                          Text(
                            'Iniciar Sesión',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: CustomColors.primary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // Subtítulo
                          Text(
                            'Bienvenido de nuevo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // Label email
                          const Text(
                            'Correo electrónico',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 8),

                          // Input email
                          CustomInput(
                            hintText: 'ejemplo@correo.com',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              context.read<LoginCubit>().setEmail(value);
                              print(value);
                            },
                          ),

                          const SizedBox(height: 16),

                          // Label contraseña
                          const Text(
                            'Contraseña',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          const SizedBox(height: 8),

                          // Input contraseña
                          CustomInput(
                            hintText: 'Ingresa tu contraseña',
                            prefixIcon: Icons.lock_outline,
                            obscureText: !state.model.isPasswordVisible,
                            onChanged: (value) {
                              context.read<LoginCubit>().setPassword(value);
                              print(value);
                            },
                            onChangeVisible: () {
                              context
                                  .read<LoginCubit>()
                                  .togglePasswordVisibility();
                            },
                          ),

                          const SizedBox(height: 24),

                          // Botón login
                          PrimaryButton(
                            text: 'INICIAR SESIÓN',
                            onPressed: () {
                              context.read<LoginCubit>().login();
                            },
                            height: 54,
                            width: double.infinity,
                            borderRadius: 24,
                            backgroundColor: CustomColors.primary,
                            foregroundColor: Colors.white,
                          ),

                          const SizedBox(height: 20),

                          // Registrarse
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '¿No tienes una cuenta? ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              CTextButton(
                                text: 'Regístrate',
                                onTap: () {
                                  context.push('/register');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
