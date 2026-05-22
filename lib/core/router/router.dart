import 'package:go_router/go_router.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/login/page.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/page.dart';
import 'package:techbot/features/document/ui/cubit/cubit.dart';
import 'package:techbot/features/document/ui/page.dart';
import 'package:techbot/features/home/ui/cubit/cubit.dart';
import 'package:techbot/features/home/ui/page.dart';
import 'package:techbot/features/splash/ui/cubit/cubit.dart';
import 'package:techbot/features/splash/ui/page.dart';
import 'package:techbot/features/view_subject/ui/cubit/cubit.dart';
import 'package:techbot/features/view_subject/ui/page.dart';

class Routes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  static const String home = 'home';
  static const String viewSubject = 'view_subject';
  static const String document = 'document';

  static const String splashPath = '/$splash';
  static const String loginPath = '/$login';
  static const String registerPath = '/$register';
  static const String homePath = '/$home';
  static const String viewSubjectPath = '/$viewSubject';
  static const String documentPath = '/$document';
}

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: Routes.splashPath,
    routes: [
      GoRoute(
        name: Routes.splash,
        path: Routes.splashPath,
        builder: (context, state) => SplashScreen(cubit: getIt<SplashCubit>()),
      ),
      GoRoute(
        name: Routes.login,
        path: Routes.loginPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PageLogin(
            loginCubit: getIt<LoginCubit>(),
            showBiometric: extra?['showBiometric'] as bool? ?? false,
          );
        },
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
      GoRoute(
        name: Routes.document,
        path: Routes.documentPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DocumentPage(
            documentId: extra['documentId'] as int,
            title: extra['title'] as String,
            cubit: getIt<DocumentCubit>(),
          );
        },
      ),
    ],
  );
}
