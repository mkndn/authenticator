import 'package:authenticator/common/enums.dart';
import 'package:authenticator/classes/settings.dart';
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
    settings.display.primaryColor = await getPrimaryColor();
    settings.security.fingerPrint = await getFingerprint() ?? false;
    settings.security.hasPassword = await getPassword() ?? false;
    settings.security.hasPin = await getPin() ?? false;
    return settings;
  }

  Future<SettingsModel> loadDisplayPreferences() async {
    SettingsModel settings = SettingsModel();
    settings.display.tapToReveal = await getTapToReveal() ?? true;
    settings.display.primaryColor = await getPrimaryColor();
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

  Future<bool> setProgressColor(String value) async =>
      (await _prefs).setString(PreferenceOptions.progressColor.name, value);

  Future<String?> getProgressColor() async =>
      (await _prefs).getString(PreferenceOptions.progressColor.name);

  Future<bool> setDividerColor(String value) async =>
      (await _prefs).setString(PreferenceOptions.dividerColor.name, value);

  Future<String?> getDividerColor() async =>
      (await _prefs).getString(PreferenceOptions.dividerColor.name);

  Future<bool> setAccentColor(String value) async =>
      (await _prefs).setString(PreferenceOptions.accentColor.name, value);

  Future<String?> getAccentColor() async =>
      (await _prefs).getString(PreferenceOptions.accentColor.name);

  Future<bool> setHeaderColor(String value) async =>
      (await _prefs).setString(PreferenceOptions.headerColor.name, value);

  Future<String?> getHeaderColor() async =>
      (await _prefs).getString(PreferenceOptions.headerColor.name);

  Future<bool> setPrimaryColor(String value) async =>
      (await _prefs).setString(PreferenceOptions.primaryColor.name, value);

  Future<String?> getPrimaryColor() async =>
      (await _prefs).getString(PreferenceOptions.primaryColor.name);

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
