import 'package:go_router/go_router.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/login/page.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/page.dart';

class Routes {
  static const String login = 'login';
  static const String register = 'register';

  static const String loginPath = '/$login';
  static const String registerPath = '/$register';
}

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: Routes.loginPath,
    routes: [
      GoRoute(
        path: Routes.loginPath,
        builder: (context, state) => PageLogin(loginCubit: getIt<LoginCubit>()),
      ),
      GoRoute(
        path: Routes.registerPath,
        builder: (context, state) =>
            PageRegister(cubit: getIt<RegisterCubit>()),
      ),
    ],
  );
}
