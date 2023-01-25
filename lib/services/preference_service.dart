import 'package:authenticator/classes/settings.dart';
import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/services/secured_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static final PreferenceService _instance = PreferenceService._();
  late final Future<SharedPreferences> _prefs;
  late final SecureStorage _secureStorage;

  PreferenceService._() {
    _prefs = SharedPreferences.getInstance();
    _secureStorage = SecureStorage.instance();
  }

  factory PreferenceService.instance() => _instance;

  Future<SettingsModel> loadAllPreferences() async {
    SettingsModel settings = SettingsModel();
    settings.display.tapToReveal = await getTapToReveal() ?? true;
    settings.display.accentColorIndex = await getAccentColor() ?? 1;
    settings.display.autoBrightness = await getAutoBrightness() ?? false;
    settings.security.fingerPrint = await getFingerprint() ?? false;
    settings.security.hasPassword = await getPassword() ?? false;
    settings.security.hasPin = await getPin() ?? false;
    return settings;
  }

  Future<SettingsModel> loadDisplayPreferences() async {
    SettingsModel settings = SettingsModel();
    settings.display.tapToReveal = await getTapToReveal() ?? true;
    settings.display.accentColorIndex = await getAccentColor() ?? 1;
    settings.display.autoBrightness = await getAutoBrightness() ?? false;
    return settings;
  }

  Future<SettingsModel> loadSecurityPreferences() async {
    SettingsModel settings = SettingsModel();
    settings.security.fingerPrint = await getFingerprint() ?? false;
    settings.security.hasPassword = await getPassword() ?? false;
    settings.security.hasPin = await getPin() ?? false;
    return settings;
  }

  Future<bool> setTapToReveal(bool value) async =>
      (await _prefs).setBool(PreferenceOptions.tapToReveal.name, value);

  Future<bool?> getTapToReveal() async =>
      (await _prefs).getBool(PreferenceOptions.tapToReveal.name);

  Future<bool> setAccentColor(int value) async =>
      (await _prefs).setInt(PreferenceOptions.accentColor.name, value);

  Future<int?> getAccentColor() async =>
      (await _prefs).getInt(PreferenceOptions.accentColor.name);

  Future<bool> setAutoBrightness(bool value) async =>
      (await _prefs).setBool(PreferenceOptions.autoBrightness.name, value);

  Future<bool?> getAutoBrightness() async =>
      (await _prefs).getBool(PreferenceOptions.autoBrightness.name);

  Future<bool> setFingerprint(bool status) async =>
      (await _prefs).setBool(PreferenceOptions.fingerprint.name, status);

  Future<bool?> getFingerprint() async =>
      (await _prefs).getBool(PreferenceOptions.fingerprint.name);

  Future<bool> setPassword(bool value) async =>
      (await _prefs).setBool(PreferenceOptions.password.name, value);

  Future<bool?> getPassword() async => await _secureStorage.hasPassword();

  Future<void> removePassword() async {
    await _secureStorage.removePassWord();
    await setPassword(false);
  }

  Future<bool> setPin(bool value) async =>
      (await _prefs).setBool(PreferenceOptions.pin.name, value);

  Future<bool?> getPin() async => await _secureStorage.hasPin();

  Future<void> removePin() async {
    await _secureStorage.removePin();
    setPin(false);
  }

  Future<void> reset() async => (await _prefs).clear();
}
