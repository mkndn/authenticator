import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const SecureStorage _instance =
      SecureStorage._(storage: FlutterSecureStorage());
  // Create storage
  final FlutterSecureStorage _storage;

  const SecureStorage._({required FlutterSecureStorage storage})
      : _storage = storage;

  factory SecureStorage.instance() => _instance;

  final String _keyPin = 'pin';
  final String _keyPassWord = 'password';

  Future<void> setPin(String pin) async {
    await _storage.write(key: _keyPin, value: pin);
  }

  Future<String>? getPin() async {
    return await _storage.read(key: _keyPin).then((value) => value ?? "");
  }

  Future<void> removePin() async {
    return _storage.delete(key: _keyPin);
  }

  Future<void> setPassWord(String password) async {
    await _storage.write(key: _keyPassWord, value: password);
  }

  Future<String>? getPassWord() async {
    return _storage.read(key: _keyPassWord).then((value) => value ?? "");
  }

  Future<void> removePassWord() async {
    return _storage.delete(key: _keyPassWord);
  }

  Future<bool> hasPin() async {
    String? pin = await getPin();
    return pin != null && pin.isNotEmpty;
  }

  Future<bool> hasPassword() async {
    String? password = await getPassWord();
    return password != null && password.isNotEmpty;
  }

  Future<bool> isValidPin(String enteredPin) async {
    String? pin = await getPin();
    return pin == null || pin == enteredPin;
  }

  Future<bool> isValidPassword(String enteredPassword) async {
    String? password = await getPassWord();
    return password == null || password == enteredPassword;
  }
}
