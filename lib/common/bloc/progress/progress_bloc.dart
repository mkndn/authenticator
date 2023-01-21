import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_event.dart';
part 'progress_state.dart';
part 'progress_bloc.freezed.dart';
part 'progress_bloc.g.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressState.initial()) {
    on<ProgressEvent>(
      (event, emit) => event.map(
        setProgress: (event) => _setProgress(event, emit),
      ),
    );
  }

  void _setProgress(SetProgress event, Emitter<ProgressState> emit) {
    emit(
      state.copyWith(percent: event.value),
    );
  }
}
