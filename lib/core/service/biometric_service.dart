import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static const _emailKey = 'biometric_email';
  static const _passwordKey = 'biometric_password';

  Future<bool> isAvailable() async {
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    final biometrics = await _localAuth.getAvailableBiometrics();
    final result = isDeviceSupported && biometrics.isNotEmpty;
    return result;
  }

  Future<bool> hasCredentials() async {
    final email = await _secureStorage.read(key: _emailKey);
    final result = email != null && email.isNotEmpty;
    return result;
  }

  Future<void> saveCredentials(String email, String password) async {
    await _secureStorage.write(key: _emailKey, value: email);
    await _secureStorage.write(key: _passwordKey, value: password);
  }

  Future<({String email, String password})?> getCredentials() async {
    final email = await _secureStorage.read(key: _emailKey);
    final password = await _secureStorage.read(key: _passwordKey);
    if (email == null || password == null) return null;
    return (email: email, password: password);
  }

  Future<bool> authenticate() async {
    final result = await _localAuth.authenticate(
      localizedReason: 'Confirma tu identidad para ingresar',
    );
    return result;
  }

  Future<void> clearCredentials() async {
    await _secureStorage.delete(key: _emailKey);
    await _secureStorage.delete(key: _passwordKey);
  }
}
