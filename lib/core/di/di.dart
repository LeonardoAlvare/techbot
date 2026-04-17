import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:techbot/features/auth/repository/repository.dart';
import 'package:techbot/features/auth/repository/repository_imp.dart';
import 'package:techbot/features/auth/ui/login/cubit/cubit.dart';
import 'package:techbot/features/auth/ui/register/cubit/cubit.dart';

final getIt = GetIt.instance;
Future<void> setupDi() async {
  // CookieJar para manejar cookies
  final cookieJar = CookieJar();
  getIt.registerLazySingleton<CookieJar>(() => cookieJar);

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

  //? Repository
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(getIt<Dio>()),
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
}
