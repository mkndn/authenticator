import 'package:authenticator/common/classes/enums.dart';
import 'package:hive/hive.dart';

part 'totp_data.g.dart';

@HiveType(typeId: 0)
class TotpData {
  @HiveField(0)
  final String id;
  @HiveField(1)
  Algorithm algorithm;
  @HiveField(2)
  int digits;
  @HiveField(3)
  String period;
  @HiveField(4)
  String? issuer;
  @HiveField(5)
  String? label;
  @HiveField(6)
  String? secret;

  TotpData({
    required this.id,
    this.label,
    this.secret,
    this.algorithm = Algorithm.sha1Hash,
    this.digits = 6,
    this.period = '30',
    this.issuer,
  });

  @override
  bool operator ==(other) {
    return (other is TotpData) &&
        label == other.label &&
        secret == other.secret &&
        algorithm == other.algorithm &&
        digits == other.digits &&
        period == other.period &&
        issuer == other.issuer;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      secret.hashCode ^
      algorithm.hashCode ^
      digits.hashCode ^
      period.hashCode ^
      issuer.hashCode;

  factory TotpData.fromJson(Map<String, dynamic> json) {
    return TotpData(
      id: json['id'],
      label: json['label'],
      secret: json['secret'],
      algorithm: Algorithm.from(json['algorithm']),
      digits: json['digits'],
      period: json['period'],
      issuer: json['issuer'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'label': label,
        'secret': secret,
        'algorithm': algorithm.name,
        'digits': digits,
        'period': period,
        'issuer': issuer,
      };
}
