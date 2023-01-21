// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppState _$$_AppStateFromJson(Map<String, dynamic> json) => _$_AppState(
      settingsLoaded: json['settingsLoaded'] as bool? ?? false,
      authenticated: json['authenticated'] as bool? ?? false,
      isAuthenticating: json['isAuthenticating'] as bool? ?? false,
      hasCredentials: json['hasCredentials'] as bool? ?? false,
      selectedTabIndexNoMobile: json['selectedTabIndexNoMobile'] as int? ?? 0,
      availableBiometricsOptions:
          (json['availableBiometricsOptions'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
    );

Map<String, dynamic> _$$_AppStateToJson(_$_AppState instance) =>
    <String, dynamic>{
      'settingsLoaded': instance.settingsLoaded,
      'authenticated': instance.authenticated,
      'isAuthenticating': instance.isAuthenticating,
      'hasCredentials': instance.hasCredentials,
      'selectedTabIndexNoMobile': instance.selectedTabIndexNoMobile,
      'availableBiometricsOptions': instance.availableBiometricsOptions,
    };
