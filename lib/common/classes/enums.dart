import 'package:authenticator/common/classes/extensions.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

enum Algorithm {
  sha512Hash("SHA512", sha512),
  sha256Hash("SHA256", sha256),
  sha1Hash("SHA1", sha1);

  const Algorithm(this.crypto, this.hash);

  final String crypto;
  final Hash hash;

  static bool isValid(String algo) =>
      Algorithm.values.any((element) => element.crypto == algo.toUpperCase());

  static Algorithm from(String cryptoValue) => Algorithm.values
      .firstWhere((element) => element.crypto == cryptoValue.toUpperCase());
}

enum PreferenceOptions {
  tapToReveal,
  accentColor,
  autoBrightness,
  fingerprint,
  password,
  pin,
  autoBackup,
  autoBackupPath;
}

enum MenuOptions {
  scan('Scan QRCode'),
  revealEnable('Enable Tap to reveal'),
  revealDisable('Disable Tap to reveal');

  const MenuOptions(this.optionName);

  final String optionName;
}

enum NavRailOptions {
  home('Home'),
  add('Add'),
  settings('Settings');

  const NavRailOptions(this.title);

  final String title;
}

enum SecretAddMode {
  url,
  secret;
}

enum TotpField { label, secret, algorithm, period, digits, issuer }

enum FilePickerMode { file, folder }

enum SupportState {
  unknown,
  supported,
  unsupported,
}

enum VerticalDirection { top, bottom }

enum LoginOptions { fingerprint, password, pin }

enum SettingsSectionOption {
  display('Display'),
  importExport('Import & Export'),
  security('Security'),
  data('Data');

  const SettingsSectionOption(this.title);

  final String title;
}

enum HoverMode { contained, around }

enum DisplaySettings {
  tapToReveal('Tap to reveal'),
  accentColor('Accent color'),
  autoBrightness('Automatic Brightness');

  const DisplaySettings(this.title);
  final String title;

  static List<String> get titles =>
      DisplaySettings.values.map((e) => e.title).toList();
}

enum SecuritySettings {
  fingerprint('Fingerprint'),
  pin('PIN'),
  password('Password');

  const SecuritySettings(this.title);
  final String title;

  static List<String> get titles =>
      SecuritySettings.values.map((e) => e.title).toList();
}

enum ImportExportSettings {
  import('Import'),
  export('Export');

  const ImportExportSettings(this.title);
  final String title;

  static List<String> get titles =>
      ImportExportSettings.values.map((e) => e.title).toList();
}

enum DataSettings {
  clearCache('Clear Cache'),
  clearData('Clear Data');

  const DataSettings(this.title);
  final String title;

  static List<String> get titles =>
      DataSettings.values.map((e) => e.title).toList();
}

enum AppRoute {
  login(Icons.person_2, '/login', 'Login'),
  home(Icons.home, '/home', 'Authenticator'),
  addEntry(Icons.add, 'add', 'Add Account'),
  editEntry(Icons.edit, 'edit', 'Edit Account'),
  scan(Icons.camera_alt_rounded, 'scan', 'Scan QR Code'),
  settings(Icons.settings, 'settings', 'Settings'),
  display(Icons.display_settings, 'display', 'Display'),
  security(Icons.security_outlined, 'security', 'Security'),
  importExport(Icons.import_export, 'importExport', 'Import & Export'),
  data(Icons.dataset_outlined, 'data', 'Data');

  const AppRoute(this.icon, this.path, this.title);

  final String path;
  final String title;
  final IconData icon;
}

enum AccentColor {
  materialYou(1, 'Material You', '#2196F3'),
  purple(2, 'Deep Purple', '#6750A4'),
  purple2(3, 'Just Purple', '#b84fff'),
  stawberry(4, 'Stawberry Smoothie', '#ff342b'),
  orange(5, 'Orange Squash', '#ff7a19'),
  green(6, 'Green Grass', '#689300'),
  green2(7, 'Simply Green', '#00978d'),
  blue(8, 'Blue Mania', '#3e7dff'),
  pink(9, 'Pinky Pink', '#fe008a');

  const AccentColor(this.id, this.title, this.hex);
  final int id;
  final String title;
  final String hex;

  Color get color => hex.toColor();

  int get cv => color.value;

  static AccentColor fromId(int id) =>
      values.firstWhere((element) => element.id == id);

  static Color colorFromId(int id) => AccentColor.fromId(id).color;
}
