import 'package:local_auth/local_auth.dart';
import 'package:authenticator/services/secured_storage.dart';

class AuthService {
  static final AuthService _instance = AuthService._(
    auth: LocalAuthentication(),
    secureStorage: SecureStorage.instance(),
  );
  final LocalAuthentication _auth;
  final SecureStorage _secureStorage;

  AuthService._(
      {required LocalAuthentication auth, required SecureStorage secureStorage})
      : _auth = auth,
        _secureStorage = secureStorage;

  factory AuthService.instance() => _instance;

  Future<bool> isDeviceSupported() => _auth.isDeviceSupported();

  Future<bool> canCheckBiometrics() => _auth.canCheckBiometrics;

  Future<List<BiometricType>> getAvailableBiometrics() =>
      _auth.getAvailableBiometrics();

  Future<bool> authenticate({
    required String localizedReason,
    required AuthenticationOptions options,
  }) =>
      _auth.authenticate(
        localizedReason: localizedReason,
        options: options,
      );

  Future<bool> authPassword({required String entered}) async {
    String? password = await _secureStorage.getPassWord();
    return password != null && password == entered;
  }

  Future<bool> authPin({required String entered}) async {
    String? pin = await _secureStorage.getPin();
    return pin != null && pin == entered;
  }

  Future<bool> stopAuthentication() => _auth.stopAuthentication();
}
