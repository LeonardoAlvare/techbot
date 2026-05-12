import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:techbot/core/service/auth_interceptor.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/features/auth/repository/repository.dart';
import 'package:techbot/features/auth/repository/repository_imp.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';
import 'package:techbot/features/home/repository/repository.dart';
import 'package:techbot/features/home/repository/repository_imp.dart';
import 'package:techbot/features/home/ui/cubit/cubit.dart';
import 'package:techbot/features/view_subject/repository/repository.dart';
import 'package:techbot/features/view_subject/repository/repository_imp.dart';
import 'package:techbot/features/view_subject/ui/cubit/cubit.dart';

final getIt = GetIt.instance;
Future<void> setupDi() async {
  // CookieJar para manejar cookies
  final cookieJar = CookieJar();
  getIt.registerLazySingleton<CookieJar>(() => cookieJar);

  getIt.registerLazySingleton<AuthSession>(() => AuthSession());

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Agregar CookieManager para interceptar y guardar cookies
    dio.interceptors.add(CookieManager(cookieJar));

    return dio;
  });

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(getIt<Dio>()),
    );
  }

  getIt<Dio>().interceptors.add(
    AuthInterceptor(
      authSession: getIt<AuthSession>(),
      authRepository: getIt<AuthRepository>(),
      cookieJar: cookieJar,
      dio: getIt<Dio>(),
    ),
  );

  //? Repository

  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImp(getIt<Dio>()),
    );
  }

  if (!getIt.isRegistered<ViewSubjectRepository>()) {
    getIt.registerLazySingleton<ViewSubjectRepository>(
      () => ViewSubjectRepositoryImp(getIt<Dio>()),
    );
  }

  //? Cubit
  if (!getIt.isRegistered<LoginCubit>()) {
    getIt.registerFactory<LoginCubit>(
      () => LoginCubit(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<RegisterCubit>()) {
    getIt.registerFactory<RegisterCubit>(
      () => RegisterCubit(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepository>()));
  }

  if (!getIt.isRegistered<ViewSubjectCubit>()) {
    getIt.registerFactory<ViewSubjectCubit>(
      () => ViewSubjectCubit(getIt<ViewSubjectRepository>()),
    );
  }
}
