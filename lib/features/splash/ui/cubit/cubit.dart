// lib/features/auth/ui/splash/cubit/cubit.dart
import 'package:cookie_jar/cookie_jar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techbot/core/const/api_url.dart';
import 'package:techbot/core/di/di.dart';
import 'package:techbot/core/service/auth_session.dart';
import 'package:techbot/core/service/biometric_service.dart';
import 'package:techbot/features/auth/repository/repository.dart';

part 'state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._authRepository, this._cookieJar, this._biometricService)
    : super(SplashInitial());

  final AuthRepository _authRepository;
  final CookieJar _cookieJar;
  final BiometricService _biometricService;

  Future<void> checkSession() async {
    try {
      final uri = Uri.parse(ApiUrl.baseUrl);
      final cookies = await _cookieJar.loadForRequest(uri);
      final refreshCookie = cookies.firstWhere(
        (c) => c.name == 'refreshToken',
        orElse: () => Cookie('refreshToken', ''),
      );

      // Hay sesión activa → renovar token y entrar directo
      if (refreshCookie.value.isNotEmpty) {
        final authModel = await _authRepository.refresh(refreshCookie.value);
        getIt<AuthSession>().setToken(authModel.accessToken);
        emit(SplashAuthenticated());
        return;
      }
    } catch (_) {}

    // Sin sesión → verificar si hay biometría disponible y credenciales guardadas
    final biometricAvailable = await _biometricService.isAvailable();
    final hasCredentials = await _biometricService.hasCredentials();

    if (biometricAvailable && hasCredentials) {
      emit(SplashBiometricAvailable());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}
