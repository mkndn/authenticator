// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totp_widget_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TotpWidgetData _$$_TotpWidgetDataFromJson(Map<String, dynamic> json) =>
    _$_TotpWidgetData(
      data: (json['data'] as List<dynamic>)
          .map((e) => TotpData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAccounts: json['totalAccounts'] as int,
      bgColor: json['bgColor'] as String,
      textColor: json['textColor'] as String,
      isUpdateFlow: json['isUpdateFlow'] as bool,
    );

Map<String, dynamic> _$$_TotpWidgetDataToJson(_$_TotpWidgetData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalAccounts': instance.totalAccounts,
      'bgColor': instance.bgColor,
      'textColor': instance.textColor,
      'isUpdateFlow': instance.isUpdateFlow,
    };
