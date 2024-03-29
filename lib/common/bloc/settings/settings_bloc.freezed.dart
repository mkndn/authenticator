// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SettingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEventCopyWith<$Res> {
  factory $SettingsEventCopyWith(
          SettingsEvent value, $Res Function(SettingsEvent) then) =
      _$SettingsEventCopyWithImpl<$Res, SettingsEvent>;
}

/// @nodoc
class _$SettingsEventCopyWithImpl<$Res, $Val extends SettingsEvent>
    implements $SettingsEventCopyWith<$Res> {
  _$SettingsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UpdateFingerPrintStateCopyWith<$Res> {
  factory _$$UpdateFingerPrintStateCopyWith(_$UpdateFingerPrintState value,
          $Res Function(_$UpdateFingerPrintState) then) =
      __$$UpdateFingerPrintStateCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$UpdateFingerPrintStateCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateFingerPrintState>
    implements _$$UpdateFingerPrintStateCopyWith<$Res> {
  __$$UpdateFingerPrintStateCopyWithImpl(_$UpdateFingerPrintState _value,
      $Res Function(_$UpdateFingerPrintState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$UpdateFingerPrintState(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdateFingerPrintState implements UpdateFingerPrintState {
  const _$UpdateFingerPrintState(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'SettingsEvent.updateFingerPrintState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateFingerPrintState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateFingerPrintStateCopyWith<_$UpdateFingerPrintState> get copyWith =>
      __$$UpdateFingerPrintStateCopyWithImpl<_$UpdateFingerPrintState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return updateFingerPrintState(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return updateFingerPrintState?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateFingerPrintState != null) {
      return updateFingerPrintState(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return updateFingerPrintState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return updateFingerPrintState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateFingerPrintState != null) {
      return updateFingerPrintState(this);
    }
    return orElse();
  }
}

abstract class UpdateFingerPrintState implements SettingsEvent {
  const factory UpdateFingerPrintState(final bool status) =
      _$UpdateFingerPrintState;

  bool get status;
  @JsonKey(ignore: true)
  _$$UpdateFingerPrintStateCopyWith<_$UpdateFingerPrintState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePasswordStateCopyWith<$Res> {
  factory _$$UpdatePasswordStateCopyWith(_$UpdatePasswordState value,
          $Res Function(_$UpdatePasswordState) then) =
      __$$UpdatePasswordStateCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$UpdatePasswordStateCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdatePasswordState>
    implements _$$UpdatePasswordStateCopyWith<$Res> {
  __$$UpdatePasswordStateCopyWithImpl(
      _$UpdatePasswordState _value, $Res Function(_$UpdatePasswordState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$UpdatePasswordState(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdatePasswordState implements UpdatePasswordState {
  const _$UpdatePasswordState(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'SettingsEvent.updatePasswordState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePasswordState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePasswordStateCopyWith<_$UpdatePasswordState> get copyWith =>
      __$$UpdatePasswordStateCopyWithImpl<_$UpdatePasswordState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return updatePasswordState(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return updatePasswordState?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updatePasswordState != null) {
      return updatePasswordState(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return updatePasswordState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return updatePasswordState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updatePasswordState != null) {
      return updatePasswordState(this);
    }
    return orElse();
  }
}

abstract class UpdatePasswordState implements SettingsEvent {
  const factory UpdatePasswordState(final bool status) = _$UpdatePasswordState;

  bool get status;
  @JsonKey(ignore: true)
  _$$UpdatePasswordStateCopyWith<_$UpdatePasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdatePinStateCopyWith<$Res> {
  factory _$$UpdatePinStateCopyWith(
          _$UpdatePinState value, $Res Function(_$UpdatePinState) then) =
      __$$UpdatePinStateCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$UpdatePinStateCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdatePinState>
    implements _$$UpdatePinStateCopyWith<$Res> {
  __$$UpdatePinStateCopyWithImpl(
      _$UpdatePinState _value, $Res Function(_$UpdatePinState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$UpdatePinState(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdatePinState implements UpdatePinState {
  const _$UpdatePinState(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'SettingsEvent.updatePinState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdatePinState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdatePinStateCopyWith<_$UpdatePinState> get copyWith =>
      __$$UpdatePinStateCopyWithImpl<_$UpdatePinState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return updatePinState(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return updatePinState?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updatePinState != null) {
      return updatePinState(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return updatePinState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return updatePinState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updatePinState != null) {
      return updatePinState(this);
    }
    return orElse();
  }
}

abstract class UpdatePinState implements SettingsEvent {
  const factory UpdatePinState(final bool status) = _$UpdatePinState;

  bool get status;
  @JsonKey(ignore: true)
  _$$UpdatePinStateCopyWith<_$UpdatePinState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTapToRevealStateCopyWith<$Res> {
  factory _$$UpdateTapToRevealStateCopyWith(_$UpdateTapToRevealState value,
          $Res Function(_$UpdateTapToRevealState) then) =
      __$$UpdateTapToRevealStateCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$UpdateTapToRevealStateCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateTapToRevealState>
    implements _$$UpdateTapToRevealStateCopyWith<$Res> {
  __$$UpdateTapToRevealStateCopyWithImpl(_$UpdateTapToRevealState _value,
      $Res Function(_$UpdateTapToRevealState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$UpdateTapToRevealState(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UpdateTapToRevealState implements UpdateTapToRevealState {
  const _$UpdateTapToRevealState(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'SettingsEvent.updateTapToRevealState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTapToRevealState &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTapToRevealStateCopyWith<_$UpdateTapToRevealState> get copyWith =>
      __$$UpdateTapToRevealStateCopyWithImpl<_$UpdateTapToRevealState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return updateTapToRevealState(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return updateTapToRevealState?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateTapToRevealState != null) {
      return updateTapToRevealState(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return updateTapToRevealState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return updateTapToRevealState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateTapToRevealState != null) {
      return updateTapToRevealState(this);
    }
    return orElse();
  }
}

abstract class UpdateTapToRevealState implements SettingsEvent {
  const factory UpdateTapToRevealState(final bool status) =
      _$UpdateTapToRevealState;

  bool get status;
  @JsonKey(ignore: true)
  _$$UpdateTapToRevealStateCopyWith<_$UpdateTapToRevealState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateAccentColorCopyWith<$Res> {
  factory _$$UpdateAccentColorCopyWith(
          _$UpdateAccentColor value, $Res Function(_$UpdateAccentColor) then) =
      __$$UpdateAccentColorCopyWithImpl<$Res>;
  @useResult
  $Res call({int colorIndex});
}

/// @nodoc
class __$$UpdateAccentColorCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$UpdateAccentColor>
    implements _$$UpdateAccentColorCopyWith<$Res> {
  __$$UpdateAccentColorCopyWithImpl(
      _$UpdateAccentColor _value, $Res Function(_$UpdateAccentColor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorIndex = null,
  }) {
    return _then(_$UpdateAccentColor(
      null == colorIndex
          ? _value.colorIndex
          : colorIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$UpdateAccentColor implements UpdateAccentColor {
  const _$UpdateAccentColor(this.colorIndex);

  @override
  final int colorIndex;

  @override
  String toString() {
    return 'SettingsEvent.updateAccentColor(colorIndex: $colorIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateAccentColor &&
            (identical(other.colorIndex, colorIndex) ||
                other.colorIndex == colorIndex));
  }

  @override
  int get hashCode => Object.hash(runtimeType, colorIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateAccentColorCopyWith<_$UpdateAccentColor> get copyWith =>
      __$$UpdateAccentColorCopyWithImpl<_$UpdateAccentColor>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return updateAccentColor(colorIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return updateAccentColor?.call(colorIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateAccentColor != null) {
      return updateAccentColor(colorIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return updateAccentColor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return updateAccentColor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (updateAccentColor != null) {
      return updateAccentColor(this);
    }
    return orElse();
  }
}

abstract class UpdateAccentColor implements SettingsEvent {
  const factory UpdateAccentColor(final int colorIndex) = _$UpdateAccentColor;

  int get colorIndex;
  @JsonKey(ignore: true)
  _$$UpdateAccentColorCopyWith<_$UpdateAccentColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetAutoBrightnessCopyWith<$Res> {
  factory _$$SetAutoBrightnessCopyWith(
          _$SetAutoBrightness value, $Res Function(_$SetAutoBrightness) then) =
      __$$SetAutoBrightnessCopyWithImpl<$Res>;
  @useResult
  $Res call({bool status});
}

/// @nodoc
class __$$SetAutoBrightnessCopyWithImpl<$Res>
    extends _$SettingsEventCopyWithImpl<$Res, _$SetAutoBrightness>
    implements _$$SetAutoBrightnessCopyWith<$Res> {
  __$$SetAutoBrightnessCopyWithImpl(
      _$SetAutoBrightness _value, $Res Function(_$SetAutoBrightness) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$SetAutoBrightness(
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SetAutoBrightness implements SetAutoBrightness {
  const _$SetAutoBrightness(this.status);

  @override
  final bool status;

  @override
  String toString() {
    return 'SettingsEvent.setAutoBrightness(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetAutoBrightness &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetAutoBrightnessCopyWith<_$SetAutoBrightness> get copyWith =>
      __$$SetAutoBrightnessCopyWithImpl<_$SetAutoBrightness>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool status) updateFingerPrintState,
    required TResult Function(bool status) updatePasswordState,
    required TResult Function(bool status) updatePinState,
    required TResult Function(bool status) updateTapToRevealState,
    required TResult Function(int colorIndex) updateAccentColor,
    required TResult Function(bool status) setAutoBrightness,
  }) {
    return setAutoBrightness(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool status)? updateFingerPrintState,
    TResult? Function(bool status)? updatePasswordState,
    TResult? Function(bool status)? updatePinState,
    TResult? Function(bool status)? updateTapToRevealState,
    TResult? Function(int colorIndex)? updateAccentColor,
    TResult? Function(bool status)? setAutoBrightness,
  }) {
    return setAutoBrightness?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool status)? updateFingerPrintState,
    TResult Function(bool status)? updatePasswordState,
    TResult Function(bool status)? updatePinState,
    TResult Function(bool status)? updateTapToRevealState,
    TResult Function(int colorIndex)? updateAccentColor,
    TResult Function(bool status)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (setAutoBrightness != null) {
      return setAutoBrightness(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UpdateFingerPrintState value)
        updateFingerPrintState,
    required TResult Function(UpdatePasswordState value) updatePasswordState,
    required TResult Function(UpdatePinState value) updatePinState,
    required TResult Function(UpdateTapToRevealState value)
        updateTapToRevealState,
    required TResult Function(UpdateAccentColor value) updateAccentColor,
    required TResult Function(SetAutoBrightness value) setAutoBrightness,
  }) {
    return setAutoBrightness(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult? Function(UpdatePasswordState value)? updatePasswordState,
    TResult? Function(UpdatePinState value)? updatePinState,
    TResult? Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult? Function(UpdateAccentColor value)? updateAccentColor,
    TResult? Function(SetAutoBrightness value)? setAutoBrightness,
  }) {
    return setAutoBrightness?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UpdateFingerPrintState value)? updateFingerPrintState,
    TResult Function(UpdatePasswordState value)? updatePasswordState,
    TResult Function(UpdatePinState value)? updatePinState,
    TResult Function(UpdateTapToRevealState value)? updateTapToRevealState,
    TResult Function(UpdateAccentColor value)? updateAccentColor,
    TResult Function(SetAutoBrightness value)? setAutoBrightness,
    required TResult orElse(),
  }) {
    if (setAutoBrightness != null) {
      return setAutoBrightness(this);
    }
    return orElse();
  }
}

abstract class SetAutoBrightness implements SettingsEvent {
  const factory SetAutoBrightness(final bool status) = _$SetAutoBrightness;

  bool get status;
  @JsonKey(ignore: true)
  _$$SetAutoBrightnessCopyWith<_$SetAutoBrightness> get copyWith =>
      throw _privateConstructorUsedError;
}

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return _SettingsState.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  DisplayState get display => throw _privateConstructorUsedError;
  SecurityState get security => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call({DisplayState display, SecurityState security});

  $DisplayStateCopyWith<$Res> get display;
  $SecurityStateCopyWith<$Res> get security;
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display = null,
    Object? security = null,
  }) {
    return _then(_value.copyWith(
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as DisplayState,
      security: null == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as SecurityState,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DisplayStateCopyWith<$Res> get display {
    return $DisplayStateCopyWith<$Res>(_value.display, (value) {
      return _then(_value.copyWith(display: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SecurityStateCopyWith<$Res> get security {
    return $SecurityStateCopyWith<$Res>(_value.security, (value) {
      return _then(_value.copyWith(security: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$_SettingsStateCopyWith(
          _$_SettingsState value, $Res Function(_$_SettingsState) then) =
      __$$_SettingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DisplayState display, SecurityState security});

  @override
  $DisplayStateCopyWith<$Res> get display;
  @override
  $SecurityStateCopyWith<$Res> get security;
}

/// @nodoc
class __$$_SettingsStateCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$_SettingsState>
    implements _$$_SettingsStateCopyWith<$Res> {
  __$$_SettingsStateCopyWithImpl(
      _$_SettingsState _value, $Res Function(_$_SettingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? display = null,
    Object? security = null,
  }) {
    return _then(_$_SettingsState(
      display: null == display
          ? _value.display
          : display // ignore: cast_nullable_to_non_nullable
              as DisplayState,
      security: null == security
          ? _value.security
          : security // ignore: cast_nullable_to_non_nullable
              as SecurityState,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SettingsState implements _SettingsState {
  const _$_SettingsState({required this.display, required this.security});

  factory _$_SettingsState.fromJson(Map<String, dynamic> json) =>
      _$$_SettingsStateFromJson(json);

  @override
  final DisplayState display;
  @override
  final SecurityState security;

  @override
  String toString() {
    return 'SettingsState(display: $display, security: $security)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SettingsState &&
            (identical(other.display, display) || other.display == display) &&
            (identical(other.security, security) ||
                other.security == security));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, display, security);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      __$$_SettingsStateCopyWithImpl<_$_SettingsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingsStateToJson(
      this,
    );
  }
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState(
      {required final DisplayState display,
      required final SecurityState security}) = _$_SettingsState;

  factory _SettingsState.fromJson(Map<String, dynamic> json) =
      _$_SettingsState.fromJson;

  @override
  DisplayState get display;
  @override
  SecurityState get security;
  @override
  @JsonKey(ignore: true)
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

DisplayState _$DisplayStateFromJson(Map<String, dynamic> json) {
  return _DisplayState.fromJson(json);
}

/// @nodoc
mixin _$DisplayState {
  bool get tapToReveal => throw _privateConstructorUsedError;
  dynamic get accentColorIndex => throw _privateConstructorUsedError;
  bool get autoBrightness => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DisplayStateCopyWith<DisplayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DisplayStateCopyWith<$Res> {
  factory $DisplayStateCopyWith(
          DisplayState value, $Res Function(DisplayState) then) =
      _$DisplayStateCopyWithImpl<$Res, DisplayState>;
  @useResult
  $Res call({bool tapToReveal, dynamic accentColorIndex, bool autoBrightness});
}

/// @nodoc
class _$DisplayStateCopyWithImpl<$Res, $Val extends DisplayState>
    implements $DisplayStateCopyWith<$Res> {
  _$DisplayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tapToReveal = null,
    Object? accentColorIndex = freezed,
    Object? autoBrightness = null,
  }) {
    return _then(_value.copyWith(
      tapToReveal: null == tapToReveal
          ? _value.tapToReveal
          : tapToReveal // ignore: cast_nullable_to_non_nullable
              as bool,
      accentColorIndex: freezed == accentColorIndex
          ? _value.accentColorIndex
          : accentColorIndex // ignore: cast_nullable_to_non_nullable
              as dynamic,
      autoBrightness: null == autoBrightness
          ? _value.autoBrightness
          : autoBrightness // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DisplayStateCopyWith<$Res>
    implements $DisplayStateCopyWith<$Res> {
  factory _$$_DisplayStateCopyWith(
          _$_DisplayState value, $Res Function(_$_DisplayState) then) =
      __$$_DisplayStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool tapToReveal, dynamic accentColorIndex, bool autoBrightness});
}

/// @nodoc
class __$$_DisplayStateCopyWithImpl<$Res>
    extends _$DisplayStateCopyWithImpl<$Res, _$_DisplayState>
    implements _$$_DisplayStateCopyWith<$Res> {
  __$$_DisplayStateCopyWithImpl(
      _$_DisplayState _value, $Res Function(_$_DisplayState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tapToReveal = null,
    Object? accentColorIndex = freezed,
    Object? autoBrightness = null,
  }) {
    return _then(_$_DisplayState(
      tapToReveal: null == tapToReveal
          ? _value.tapToReveal
          : tapToReveal // ignore: cast_nullable_to_non_nullable
              as bool,
      accentColorIndex: freezed == accentColorIndex
          ? _value.accentColorIndex!
          : accentColorIndex,
      autoBrightness: null == autoBrightness
          ? _value.autoBrightness
          : autoBrightness // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DisplayState implements _DisplayState {
  const _$_DisplayState(
      {this.tapToReveal = true,
      this.accentColorIndex = 1,
      this.autoBrightness = false});

  factory _$_DisplayState.fromJson(Map<String, dynamic> json) =>
      _$$_DisplayStateFromJson(json);

  @override
  @JsonKey()
  final bool tapToReveal;
  @override
  @JsonKey()
  final dynamic accentColorIndex;
  @override
  @JsonKey()
  final bool autoBrightness;

  @override
  String toString() {
    return 'DisplayState(tapToReveal: $tapToReveal, accentColorIndex: $accentColorIndex, autoBrightness: $autoBrightness)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DisplayState &&
            (identical(other.tapToReveal, tapToReveal) ||
                other.tapToReveal == tapToReveal) &&
            const DeepCollectionEquality()
                .equals(other.accentColorIndex, accentColorIndex) &&
            (identical(other.autoBrightness, autoBrightness) ||
                other.autoBrightness == autoBrightness));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tapToReveal,
      const DeepCollectionEquality().hash(accentColorIndex), autoBrightness);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DisplayStateCopyWith<_$_DisplayState> get copyWith =>
      __$$_DisplayStateCopyWithImpl<_$_DisplayState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DisplayStateToJson(
      this,
    );
  }
}

abstract class _DisplayState implements DisplayState {
  const factory _DisplayState(
      {final bool tapToReveal,
      final dynamic accentColorIndex,
      final bool autoBrightness}) = _$_DisplayState;

  factory _DisplayState.fromJson(Map<String, dynamic> json) =
      _$_DisplayState.fromJson;

  @override
  bool get tapToReveal;
  @override
  dynamic get accentColorIndex;
  @override
  bool get autoBrightness;
  @override
  @JsonKey(ignore: true)
  _$$_DisplayStateCopyWith<_$_DisplayState> get copyWith =>
      throw _privateConstructorUsedError;
}

SecurityState _$SecurityStateFromJson(Map<String, dynamic> json) {
  return _SecurityState.fromJson(json);
}

/// @nodoc
mixin _$SecurityState {
  bool get hasPassword => throw _privateConstructorUsedError;
  bool get hasPin => throw _privateConstructorUsedError;
  bool get fingerPrint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecurityStateCopyWith<SecurityState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityStateCopyWith<$Res> {
  factory $SecurityStateCopyWith(
          SecurityState value, $Res Function(SecurityState) then) =
      _$SecurityStateCopyWithImpl<$Res, SecurityState>;
  @useResult
  $Res call({bool hasPassword, bool hasPin, bool fingerPrint});
}

/// @nodoc
class _$SecurityStateCopyWithImpl<$Res, $Val extends SecurityState>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPassword = null,
    Object? hasPin = null,
    Object? fingerPrint = null,
  }) {
    return _then(_value.copyWith(
      hasPassword: null == hasPassword
          ? _value.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPin: null == hasPin
          ? _value.hasPin
          : hasPin // ignore: cast_nullable_to_non_nullable
              as bool,
      fingerPrint: null == fingerPrint
          ? _value.fingerPrint
          : fingerPrint // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SecurityStateCopyWith<$Res>
    implements $SecurityStateCopyWith<$Res> {
  factory _$$_SecurityStateCopyWith(
          _$_SecurityState value, $Res Function(_$_SecurityState) then) =
      __$$_SecurityStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasPassword, bool hasPin, bool fingerPrint});
}

/// @nodoc
class __$$_SecurityStateCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$_SecurityState>
    implements _$$_SecurityStateCopyWith<$Res> {
  __$$_SecurityStateCopyWithImpl(
      _$_SecurityState _value, $Res Function(_$_SecurityState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasPassword = null,
    Object? hasPin = null,
    Object? fingerPrint = null,
  }) {
    return _then(_$_SecurityState(
      hasPassword: null == hasPassword
          ? _value.hasPassword
          : hasPassword // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPin: null == hasPin
          ? _value.hasPin
          : hasPin // ignore: cast_nullable_to_non_nullable
              as bool,
      fingerPrint: null == fingerPrint
          ? _value.fingerPrint
          : fingerPrint // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SecurityState implements _SecurityState {
  const _$_SecurityState(
      {this.hasPassword = false,
      this.hasPin = false,
      this.fingerPrint = false});

  factory _$_SecurityState.fromJson(Map<String, dynamic> json) =>
      _$$_SecurityStateFromJson(json);

  @override
  @JsonKey()
  final bool hasPassword;
  @override
  @JsonKey()
  final bool hasPin;
  @override
  @JsonKey()
  final bool fingerPrint;

  @override
  String toString() {
    return 'SecurityState(hasPassword: $hasPassword, hasPin: $hasPin, fingerPrint: $fingerPrint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SecurityState &&
            (identical(other.hasPassword, hasPassword) ||
                other.hasPassword == hasPassword) &&
            (identical(other.hasPin, hasPin) || other.hasPin == hasPin) &&
            (identical(other.fingerPrint, fingerPrint) ||
                other.fingerPrint == fingerPrint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hasPassword, hasPin, fingerPrint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SecurityStateCopyWith<_$_SecurityState> get copyWith =>
      __$$_SecurityStateCopyWithImpl<_$_SecurityState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SecurityStateToJson(
      this,
    );
  }
}

abstract class _SecurityState implements SecurityState {
  const factory _SecurityState(
      {final bool hasPassword,
      final bool hasPin,
      final bool fingerPrint}) = _$_SecurityState;

  factory _SecurityState.fromJson(Map<String, dynamic> json) =
      _$_SecurityState.fromJson;

  @override
  bool get hasPassword;
  @override
  bool get hasPin;
  @override
  bool get fingerPrint;
  @override
  @JsonKey(ignore: true)
  _$$_SecurityStateCopyWith<_$_SecurityState> get copyWith =>
      throw _privateConstructorUsedError;
}
