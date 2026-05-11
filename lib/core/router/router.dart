import 'package:go_router/go_router.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/login/page.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/page.dart';
import 'package:techbot/features/home/ui/cubit/cubit.dart';
import 'package:techbot/features/home/ui/page.dart';
import 'package:techbot/features/view_subject/ui/cubit/cubit.dart';
import 'package:techbot/features/view_subject/ui/page.dart';

class Routes {
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String viewSubject = 'view_subject';

  static const String loginPath = '/$login';
  static const String registerPath = '/$register';
  static const String homePath = '/$home';
  static const String viewSubjectPath = '/$viewSubject';
}

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: Routes.loginPath,
    routes: [
      GoRoute(
        name: Routes.login,
        path: Routes.loginPath,
        builder: (context, state) => PageLogin(loginCubit: getIt<LoginCubit>()),
      ),
      GoRoute(
        name: Routes.register,
        path: Routes.registerPath,
        builder: (context, state) =>
            PageRegister(cubit: getIt<RegisterCubit>()),
      ),
      GoRoute(
        name: Routes.home,
        path: Routes.homePath,
        builder: (context, state) => HomePage(cubit: getIt<HomeCubit>()),
      ),
      GoRoute(
        name: Routes.viewSubject,
        path: Routes.viewSubjectPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ViewSubjectPage(
            cubit: getIt<ViewSubjectCubit>(),
            idSubject: extra['idSubject'] as int,
            nameSubject: extra['nameSubject'] as String,
          );
        },
      ),
    ],
  );
}
