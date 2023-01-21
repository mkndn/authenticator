part of 'progress_bloc.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState({
    @Default(0.0) double percent,
  }) = _ProgressState;

  const ProgressState._();

  factory ProgressState.initial() => const ProgressState._();

  factory ProgressState.fromJson(Map<String, dynamic> json) =>
      _$ProgressStateFromJson(json);
}
