import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techbot/core/theme/colors.dart';
import 'package:techbot/core/widgets/buttons/buttons.dart';
import 'package:techbot/core/widgets/inputs.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/widgets/background.dart';
import 'package:techbot/features/auth/ui/widgets/result_alert.dart';

class PageRegister extends StatelessWidget {
  final RegisterCubit cubit;
  const PageRegister({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(body: _Body()),
    );
  }
}

class _Body extends StatelessWidget {
  _Body();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showResultAlert(
            context,
            icon: Icons.check_rounded,
            iconColor: Color(0xFF22C55E),
            title: '¡Bienvenido!',
            subtitle: 'Has registrado correctamente.',
          );
        }
        if (state is RegisterError) {
          showResultAlert(
            context,
            icon: Icons.error_rounded,
            iconColor: Color(0xFFE53935),
            title: '¡Ups!',
            subtitle: 'Error al registrar.',
          );
        }
      },
      builder: (context, state) {
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
                      child: Form(
                        key: _formKey,
                        child: Column(
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
                                  Icons.person_add_outlined,
                                  color: CustomColors.primary,
                                  size: 40,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            // Título
                            Text(
                              'Crear Cuenta',
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
                              'Únete a nosotros y conecta con el futuro',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Label nombre
                            const Text(
                              'Nombre completo',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            CustomInput(
                              hintText: 'Nombre completo',
                              prefixIcon: Icons.badge_outlined,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                context.read<RegisterCubit>().setName(value);
                              },
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'El nombre es obligatorio';
                                }
                                if (v.trim().length < 3) {
                                  return 'Mínimo 3 caracteres';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Label apellido
                            const Text(
                              'Apellido',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            CustomInput(
                              hintText: 'Apellido',
                              prefixIcon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                context.read<RegisterCubit>().setLastName(
                                  value,
                                );
                              },
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'El apellido es obligatorio';
                                }
                                if (v.trim().length < 3) {
                                  return 'Mínimo 3 caracteres';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Label correo
                            const Text(
                              'Correo electrónico',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            CustomInput(
                              hintText: 'Correo electrónico',
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) =>
                                  context.read<RegisterCubit>().setEmail(value),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Correo obligatorio';
                                }
                                final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                if (!regex.hasMatch(v)) {
                                  return 'Correo inválido';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Label contraseña
                            const Text(
                              'Contraseña',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            CustomInput(
                              hintText: 'Contraseña',
                              prefixIcon: Icons.lock_outline,
                              obscureText: !state.model.isPasswordVisible,
                              onChanged: (value) => context
                                  .read<RegisterCubit>()
                                  .setPassword(value),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Contraseña obligatoria';
                                }
                                if (v.length < 8) return 'Mínimo 8 caracteres';
                                return null;
                              },
                              onChangeVisible: () {
                                context
                                    .read<RegisterCubit>()
                                    .togglePasswordVisibility();
                              },
                            ),

                            const SizedBox(height: 24),

                            // Botón crear cuenta
                            PrimaryButton(
                              text: 'CREAR CUENTA',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<RegisterCubit>().register();
                                }
                              },
                              height: 54,
                              width: double.infinity,
                              borderRadius: 24,
                              backgroundColor: CustomColors.primary,
                              foregroundColor: Colors.white,
                            ),

                            const SizedBox(height: 20),

                            // Iniciar sesión
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Ya tienes una cuenta? ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                CTextButton(
                                  text: 'Inicia sesión',
                                  onTap: () {
                                    context.push('/login');
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
            ),
          ],
        );
      },
    );
  }
}
