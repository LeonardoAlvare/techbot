import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:techbot/core/router/router.dart';
import 'package:techbot/features/splash/ui/cubit/cubit.dart';

class SplashScreen extends StatelessWidget {
  final SplashCubit cubit;
  const SplashScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..checkSession(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
            context.goNamed(Routes.home);
          } else if (state is SplashBiometricAvailable) {
            context.goNamed(Routes.login, extra: {'showBiometric': true});
          } else if (state is SplashUnauthenticated) {
            context.goNamed(Routes.login, extra: {'showBiometric': false});
          }
        },
        child: const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
