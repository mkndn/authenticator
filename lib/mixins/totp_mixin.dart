import 'package:authenticator/classes/totp_data.dart';
import 'package:authenticator/common/classes/enums.dart';

mixin TotpMixin {
  Map<TotpField, RegExp> regexMap = <TotpField, RegExp>{
    TotpField.label: RegExp(r'totp\/([a-zA-Z0-9,@,\-,_,.,:]+)'),
    TotpField.algorithm: RegExp(r'algorithm=([a-zA-Z0-9]+)'),
    TotpField.secret: RegExp(r'secret=([a-zA-Z0-9]+)'),
    TotpField.issuer: RegExp(r'issuer=([a-zA-Z0-9]+)'),
    TotpField.digits: RegExp(r'digits=([a-zA-Z0-9]+)'),
    TotpField.period: RegExp(r'period=([a-zA-Z0-9]+)'),
  };

  bool extract(String content, TotpData data) {
    final Map<TotpField, String> results = {};

    for (var entry in regexMap.entries) {
      RegExpMatch? match = entry.value.firstMatch(content);
      if (match != null &&
          match.group(1) != null &&
          match.group(1)!.isNotEmpty) {
        results.putIfAbsent(entry.key, () => match.group(1)!);
      }
    }

    if (!results.containsKey(TotpField.label) ||
        !results.containsKey(TotpField.secret)) {
      return false;
    }

    data.label = results[TotpField.label];
    data.secret = results[TotpField.secret];
    data.algorithm = results[TotpField.algorithm] != null
        ? Algorithm.from(results[TotpField.algorithm]!)
        : data.algorithm;
    data.issuer = results[TotpField.issuer];
    data.digits = results[TotpField.digits] ?? data.digits;
    data.period = results[TotpField.period] ?? data.period;
    return true;
  }

  String totpUrl(TotpData data) {
    assert(data.label != null, 'Totp label is required');
    assert(data.secret != null, 'Totp secret is required');
    String url =
        'otpauth://totp/${data.label}?secret=${data.secret}&algorithm=${data.algorithm.crypto}&digits=${data.digits}&period=${data.period}';
    return data.issuer != null ? '$url&issuer=${data.issuer}' : url;
  }
}
