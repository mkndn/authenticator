// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsState _$$_SettingsStateFromJson(Map<String, dynamic> json) =>
    _$_SettingsState(
      display: DisplayState.fromJson(json['display'] as Map<String, dynamic>),
      security:
          SecurityState.fromJson(json['security'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) =>
    <String, dynamic>{
      'display': instance.display,
      'security': instance.security,
    };

_$_DisplayState _$$_DisplayStateFromJson(Map<String, dynamic> json) =>
    _$_DisplayState(
      tapToReveal: json['tapToReveal'] as bool? ?? true,
      primaryColor: json['primaryColor'] as String?,
      autoBrightness: json['autoBrightness'] as bool? ?? false,
    );

Map<String, dynamic> _$$_DisplayStateToJson(_$_DisplayState instance) =>
    <String, dynamic>{
      'tapToReveal': instance.tapToReveal,
      'primaryColor': instance.primaryColor,
      'autoBrightness': instance.autoBrightness,
    };

_$_SecurityState _$$_SecurityStateFromJson(Map<String, dynamic> json) =>
    _$_SecurityState(
      hasPassword: json['hasPassword'] as bool? ?? false,
      hasPin: json['hasPin'] as bool? ?? false,
      fingerPrint: json['fingerPrint'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SecurityStateToJson(_$_SecurityState instance) =>
    <String, dynamic>{
      'hasPassword': instance.hasPassword,
      'hasPin': instance.hasPin,
      'fingerPrint': instance.fingerPrint,
    };
