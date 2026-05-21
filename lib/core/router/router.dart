import 'package:go_router/go_router.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/login/page.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/page.dart';
import 'package:techbot/features/document/children/flashcard/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/flashcard/ui/page.dart';
import 'package:techbot/features/document/children/quiz/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/quiz/ui/page.dart';
import 'package:techbot/features/document/children/summary/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/summary/ui/page.dart';
import 'package:techbot/features/document/children/view_documet/ui/cubit/cubit.dart';
import 'package:techbot/features/document/children/view_documet/ui/page.dart';
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
  static const String viewDocument = 'view_document';
  static const String summary = 'summary';
  static const String flashcard = 'flashcard';
  static const String quiz = 'quiz';

  static const String splashPath = '/$splash';
  static const String loginPath = '/$login';
  static const String registerPath = '/$register';
  static const String homePath = '/$home';
  static const String viewSubjectPath = '/$viewSubject';
  static const String viewDocumentPath = '/$viewDocument';
  static const String summaryPath = '/$summary';
  static const String flashcardPath = '/$flashcard';
  static const String quizPath = '/$quiz';
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
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          final extra = state.extra as Map<String, dynamic>?;

          final title = extra?['title'] as String;

          final documentId = extra?['documentId'] as int;

          return DocumentPage(
            navigationShell: child,
            title: title,
            documentId: documentId,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: Routes.viewDocument,
                path: Routes.viewDocumentPath,
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;

                  return ViewDocumentPage(
                    cubit: getIt<ViewDocumentCubit>(),
                    documentId: extra?['documentId'] as int,
                  );
                },
              ),
              GoRoute(
                name: Routes.summary,
                path: Routes.summaryPath,
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;

                  return SummaryPage(
                    cubit: getIt<SummaryCubit>(),
                    documentId: extra?['documentId'] as int,
                  );
                },
              ),
              GoRoute(
                name: Routes.flashcard,
                path: Routes.flashcardPath,
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;

                  return FlashcardPage(
                    cubit: getIt<FlashcardCubit>(),
                    documentId: extra?['documentId'] as int,
                  );
                },
              ),
              GoRoute(
                name: Routes.quiz,
                path: Routes.quizPath,
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>?;

                  return QuizPage(
                    cubit: getIt<QuizCubit>(),
                    documentId: extra?['documentId'] as int,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
