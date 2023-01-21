// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProgressEvent {
  double get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double value) setProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double value)? setProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double value)? setProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetProgress value) setProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetProgress value)? setProgress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetProgress value)? setProgress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgressEventCopyWith<ProgressEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressEventCopyWith<$Res> {
  factory $ProgressEventCopyWith(
          ProgressEvent value, $Res Function(ProgressEvent) then) =
      _$ProgressEventCopyWithImpl<$Res, ProgressEvent>;
  @useResult
  $Res call({double value});
}

/// @nodoc
class _$ProgressEventCopyWithImpl<$Res, $Val extends ProgressEvent>
    implements $ProgressEventCopyWith<$Res> {
  _$ProgressEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetProgressCopyWith<$Res>
    implements $ProgressEventCopyWith<$Res> {
  factory _$$SetProgressCopyWith(
          _$SetProgress value, $Res Function(_$SetProgress) then) =
      __$$SetProgressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$$SetProgressCopyWithImpl<$Res>
    extends _$ProgressEventCopyWithImpl<$Res, _$SetProgress>
    implements _$$SetProgressCopyWith<$Res> {
  __$$SetProgressCopyWithImpl(
      _$SetProgress _value, $Res Function(_$SetProgress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SetProgress(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SetProgress implements SetProgress {
  const _$SetProgress(this.value);

  @override
  final double value;

  @override
  String toString() {
    return 'ProgressEvent.setProgress(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetProgress &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetProgressCopyWith<_$SetProgress> get copyWith =>
      __$$SetProgressCopyWithImpl<_$SetProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double value) setProgress,
  }) {
    return setProgress(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double value)? setProgress,
  }) {
    return setProgress?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double value)? setProgress,
    required TResult orElse(),
  }) {
    if (setProgress != null) {
      return setProgress(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SetProgress value) setProgress,
  }) {
    return setProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SetProgress value)? setProgress,
  }) {
    return setProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SetProgress value)? setProgress,
    required TResult orElse(),
  }) {
    if (setProgress != null) {
      return setProgress(this);
    }
    return orElse();
  }
}

abstract class SetProgress implements ProgressEvent {
  const factory SetProgress(final double value) = _$SetProgress;

  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$SetProgressCopyWith<_$SetProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressState _$ProgressStateFromJson(Map<String, dynamic> json) {
  return _ProgressState.fromJson(json);
}

/// @nodoc
mixin _$ProgressState {
  double get percent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressStateCopyWith<ProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStateCopyWith<$Res> {
  factory $ProgressStateCopyWith(
          ProgressState value, $Res Function(ProgressState) then) =
      _$ProgressStateCopyWithImpl<$Res, ProgressState>;
  @useResult
  $Res call({double percent});
}

/// @nodoc
class _$ProgressStateCopyWithImpl<$Res, $Val extends ProgressState>
    implements $ProgressStateCopyWith<$Res> {
  _$ProgressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = null,
  }) {
    return _then(_value.copyWith(
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProgressStateCopyWith<$Res>
    implements $ProgressStateCopyWith<$Res> {
  factory _$$_ProgressStateCopyWith(
          _$_ProgressState value, $Res Function(_$_ProgressState) then) =
      __$$_ProgressStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double percent});
}

/// @nodoc
class __$$_ProgressStateCopyWithImpl<$Res>
    extends _$ProgressStateCopyWithImpl<$Res, _$_ProgressState>
    implements _$$_ProgressStateCopyWith<$Res> {
  __$$_ProgressStateCopyWithImpl(
      _$_ProgressState _value, $Res Function(_$_ProgressState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percent = null,
  }) {
    return _then(_$_ProgressState(
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProgressState extends _ProgressState {
  const _$_ProgressState({this.percent = 0.0}) : super._();

  factory _$_ProgressState.fromJson(Map<String, dynamic> json) =>
      _$$_ProgressStateFromJson(json);

  @override
  @JsonKey()
  final double percent;

  @override
  String toString() {
    return 'ProgressState(percent: $percent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProgressState &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, percent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProgressStateCopyWith<_$_ProgressState> get copyWith =>
      __$$_ProgressStateCopyWithImpl<_$_ProgressState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProgressStateToJson(
      this,
    );
  }
}

abstract class _ProgressState extends ProgressState {
  const factory _ProgressState({final double percent}) = _$_ProgressState;
  const _ProgressState._() : super._();

  factory _ProgressState.fromJson(Map<String, dynamic> json) =
      _$_ProgressState.fromJson;

  @override
  double get percent;
  @override
  @JsonKey(ignore: true)
  _$$_ProgressStateCopyWith<_$_ProgressState> get copyWith =>
      throw _privateConstructorUsedError;
}
