import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';
import 'package:flutter/foundation.dart';
import 'package:authenticator/common/enums.dart';

class TOTP {
  TOTP._();
  static String generateTOTPCode(String key, int time,
      {int length = 6, Algorithm algorithm = Algorithm.sha1Hash}) {
    time = (((time ~/ 1000).round()) ~/ 30).floor();
    //time = (time ~/30).floor();
    return _generateCode(key, time, length, algorithm);
  }

  static String _generateCode(
      String secret, int time, int length, Algorithm algorithm) {
    length = (length <= 8 && length > 0) ? length : 6;

    var secretList = base32.decode(secret);
    var timebytes = _int2bytes(time);

    var hmac = Hmac(algorithm.hash, secretList);
    var hash = hmac.convert(timebytes).bytes;

    int offset = hash[hash.length - 1] & 0xf;

    int binary = ((hash[offset] & 0x7f) << 24) |
        ((hash[offset + 1] & 0xff) << 16) |
        ((hash[offset + 2] & 0xff) << 8) |
        (hash[offset + 3] & 0xff);

    String result = (binary % pow(10, length)).toString();
    return _leftpad(result, length);
  }

  static String randomSecret() {
    var rand = Random.secure();
    var bytes = List<int>.empty(growable: true);

    for (int i = 0; i < 130; i++) {
      bytes.add(rand.nextInt(256));
    }

    return base32.encode(Uint8List.fromList(bytes));
  }

  // ignore: unused_element
  static String _dec2hex(int s) {
    var st = s.round().toRadixString(16);
    return (st.length % 2 == 0) ? st : '0$st';
  }

  static String _leftpad(String value, int targetLength) {
    var padded = value;
    while (padded.length < targetLength) {
      padded = "0$padded";
    }
    return padded;
  }

  // ignore: unused_element
  static List _hex2bytes(hex) {
    List bytes = List.filled(hex.length ~/ 2, []);
    for (int i = 0; i < hex.length; i += 2) {
      var hexBit = "0x${hex[i]}${hex[i + 1]}";
      int parsed = int.parse(hexBit);
      bytes[i ~/ 2] = parsed;
    }
    return bytes;
  }

  static List<int> _int2bytes(int long) {
    // we want to represent the input as a 8-bytes array
    var byteArray = [0, 0, 0, 0, 0, 0, 0, 0];
    for (var index = byteArray.length - 1; index >= 0; index--) {
      var byte = long & 0xff;
      byteArray[index] = byte;
      long = (long - byte) ~/ 256;
    }
    return byteArray;
  }

  // ignore: unused_element
  static int _bytes2int(List<int> byteArray) {
    var value = 0;
    for (var i = byteArray.length - 1; i >= 0; i--) {
      value = (value * 256) + byteArray[i];
    }
    return value;
  }
}
