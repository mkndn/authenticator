part of 'progress_bloc.dart';

@freezed
class ProgressEvent with _$ProgressEvent {
  const factory ProgressEvent.setProgress(double value) = SetProgress;
}
