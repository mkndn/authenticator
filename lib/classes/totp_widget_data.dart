import 'package:authenticator/classes/totp_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'totp_widget_data.freezed.dart';
part 'totp_widget_data.g.dart';

@freezed
class TotpWidgetData with _$TotpWidgetData {
  const factory TotpWidgetData({
    required List<TotpData> data,
    required int totalAccounts,
    required String bgColor,
    required String textColor,
    required bool isUpdateFlow,
  }) = _TotpWidgetData;

  factory TotpWidgetData.fromJson(Map<String, dynamic> json) =>
      _$TotpWidgetDataFromJson(json);
}
