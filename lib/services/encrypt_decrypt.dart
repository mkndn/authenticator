import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:authenticator/common/typedefs.dart';

class EncryptDecrypt {
  static const EncryptDecrypt _instance = EncryptDecrypt._();

  const EncryptDecrypt._();

  factory EncryptDecrypt.instance() => _instance;

  String encryptContent(String passkey, List<JsonMap> jsonMapList) {
    final key = Key.fromUtf8(passkey);
    final iv = IV.fromLength(16);

    final String jsonContent = jsonEncode(jsonMapList);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(jsonContent, iv: iv).base64;
  }

  Future<List<JsonMap>> decryptContent(
      String passkey, String encryptedContent) async {
    final key = Key.fromUtf8(passkey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));

    String jsonContent = encrypter.decrypt64(encryptedContent, iv: iv);

    List<dynamic> contentList = jsonDecode(jsonContent);
    return contentList.map((e) => e as Map<String, dynamic>).toList();
  }
}
