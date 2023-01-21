import 'dart:convert';
import 'dart:io';
import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/common/typedefs.dart';
import 'package:authenticator/services/encrypt_decrypt.dart';

class ImportExport {
  static final ImportExport _instance =
      ImportExport._(encryptDecrypt: EncryptDecrypt.instance());
  final EncryptDecrypt _encryptDecrypt;

  const ImportExport._({
    required EncryptDecrypt encryptDecrypt,
  }) : _encryptDecrypt = encryptDecrypt;

  factory ImportExport.instance() => _instance;

  Future<List<TotpData>> importData(String path, String? passkey) async {
    final importFile = File(path);
    if (await importFile.exists() && await importFile.length() > 0) {
      final bytes = await importFile.readAsBytes();
      List<JsonMap> content = passkey != null
          ? await _encryptDecrypt.decryptContent(
              passkey, String.fromCharCodes(bytes))
          : jsonDecode(String.fromCharCodes(bytes));
      return content.map((e) => TotpData.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> exportData(
      String exportFilePath, String? passkey, List<TotpData> data) async {
    final File exportFile = File('$exportFilePath/mk_totp_export.enkrypt');
    List<JsonMap> content = data.map((e) => e.toJson()).toList();
    String encryptedContent = passkey != null
        ? _encryptDecrypt.encryptContent(passkey, content)
        : jsonEncode(content);
    exportFile.writeAsString(encryptedContent);
  }
}
