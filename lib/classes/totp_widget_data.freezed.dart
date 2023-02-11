// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'totp_widget_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TotpWidgetData _$TotpWidgetDataFromJson(Map<String, dynamic> json) {
  return _TotpWidgetData.fromJson(json);
}

/// @nodoc
mixin _$TotpWidgetData {
  List<TotpData> get data => throw _privateConstructorUsedError;
  int get totalAccounts => throw _privateConstructorUsedError;
  String get bgColor => throw _privateConstructorUsedError;
  String get textColor => throw _privateConstructorUsedError;
  bool get isUpdateFlow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TotpWidgetDataCopyWith<TotpWidgetData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotpWidgetDataCopyWith<$Res> {
  factory $TotpWidgetDataCopyWith(
          TotpWidgetData value, $Res Function(TotpWidgetData) then) =
      _$TotpWidgetDataCopyWithImpl<$Res, TotpWidgetData>;
  @useResult
  $Res call(
      {List<TotpData> data,
      int totalAccounts,
      String bgColor,
      String textColor,
      bool isUpdateFlow});
}

/// @nodoc
class _$TotpWidgetDataCopyWithImpl<$Res, $Val extends TotpWidgetData>
    implements $TotpWidgetDataCopyWith<$Res> {
  _$TotpWidgetDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalAccounts = null,
    Object? bgColor = null,
    Object? textColor = null,
    Object? isUpdateFlow = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TotpData>,
      totalAccounts: null == totalAccounts
          ? _value.totalAccounts
          : totalAccounts // ignore: cast_nullable_to_non_nullable
              as int,
      bgColor: null == bgColor
          ? _value.bgColor
          : bgColor // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      isUpdateFlow: null == isUpdateFlow
          ? _value.isUpdateFlow
          : isUpdateFlow // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TotpWidgetDataCopyWith<$Res>
    implements $TotpWidgetDataCopyWith<$Res> {
  factory _$$_TotpWidgetDataCopyWith(
          _$_TotpWidgetData value, $Res Function(_$_TotpWidgetData) then) =
      __$$_TotpWidgetDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TotpData> data,
      int totalAccounts,
      String bgColor,
      String textColor,
      bool isUpdateFlow});
}

/// @nodoc
class __$$_TotpWidgetDataCopyWithImpl<$Res>
    extends _$TotpWidgetDataCopyWithImpl<$Res, _$_TotpWidgetData>
    implements _$$_TotpWidgetDataCopyWith<$Res> {
  __$$_TotpWidgetDataCopyWithImpl(
      _$_TotpWidgetData _value, $Res Function(_$_TotpWidgetData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalAccounts = null,
    Object? bgColor = null,
    Object? textColor = null,
    Object? isUpdateFlow = null,
  }) {
    return _then(_$_TotpWidgetData(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TotpData>,
      totalAccounts: null == totalAccounts
          ? _value.totalAccounts
          : totalAccounts // ignore: cast_nullable_to_non_nullable
              as int,
      bgColor: null == bgColor
          ? _value.bgColor
          : bgColor // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      isUpdateFlow: null == isUpdateFlow
          ? _value.isUpdateFlow
          : isUpdateFlow // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TotpWidgetData implements _TotpWidgetData {
  const _$_TotpWidgetData(
      {required final List<TotpData> data,
      required this.totalAccounts,
      required this.bgColor,
      required this.textColor,
      required this.isUpdateFlow})
      : _data = data;

  factory _$_TotpWidgetData.fromJson(Map<String, dynamic> json) =>
      _$$_TotpWidgetDataFromJson(json);

  final List<TotpData> _data;
  @override
  List<TotpData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int totalAccounts;
  @override
  final String bgColor;
  @override
  final String textColor;
  @override
  final bool isUpdateFlow;

  @override
  String toString() {
    return 'TotpWidgetData(data: $data, totalAccounts: $totalAccounts, bgColor: $bgColor, textColor: $textColor, isUpdateFlow: $isUpdateFlow)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TotpWidgetData &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.totalAccounts, totalAccounts) ||
                other.totalAccounts == totalAccounts) &&
            (identical(other.bgColor, bgColor) || other.bgColor == bgColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.isUpdateFlow, isUpdateFlow) ||
                other.isUpdateFlow == isUpdateFlow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      totalAccounts,
      bgColor,
      textColor,
      isUpdateFlow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TotpWidgetDataCopyWith<_$_TotpWidgetData> get copyWith =>
      __$$_TotpWidgetDataCopyWithImpl<_$_TotpWidgetData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TotpWidgetDataToJson(
      this,
    );
  }
}

abstract class _TotpWidgetData implements TotpWidgetData {
  const factory _TotpWidgetData(
      {required final List<TotpData> data,
      required final int totalAccounts,
      required final String bgColor,
      required final String textColor,
      required final bool isUpdateFlow}) = _$_TotpWidgetData;

  factory _TotpWidgetData.fromJson(Map<String, dynamic> json) =
      _$_TotpWidgetData.fromJson;

  @override
  List<TotpData> get data;
  @override
  int get totalAccounts;
  @override
  String get bgColor;
  @override
  String get textColor;
  @override
  bool get isUpdateFlow;
  @override
  @JsonKey(ignore: true)
  _$$_TotpWidgetDataCopyWith<_$_TotpWidgetData> get copyWith =>
      throw _privateConstructorUsedError;
}
