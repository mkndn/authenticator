import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:authenticator/classes/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';
part 'settings_bloc.freezed.dart';
part 'settings_bloc.g.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(SettingsModel initialData)
      : super(SettingsState.load(initialData)) {
    on<SettingsEvent>(
      (event, emit) => event.map(
        updateFingerPrintState: (event) => _updateFingerPrintState(event, emit),
        updatePasswordState: (event) => _updatePasswordState(event, emit),
        updatePinState: (event) => _updatePinState(event, emit),
        updateTapToRevealState: (event) => _updateTapToRevealState(event, emit),
        updatePrimaryColor: (event) => _updatePrimaryColor(event, emit),
        setAutoBrightness: (event) => _setAutoBrightness(event, emit),
      ),
    );
  }

  void _updateFingerPrintState(
      UpdateFingerPrintState event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
          security: state.security.copyWith(fingerPrint: event.status)),
    );
  }

  void _updatePasswordState(
      UpdatePasswordState event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
          security: state.security.copyWith(hasPassword: event.status)),
    );
  }

  void _updatePinState(UpdatePinState event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(security: state.security.copyWith(hasPin: event.status)),
    );
  }

  void _updateTapToRevealState(
      UpdateTapToRevealState event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        display: state.display.copyWith(tapToReveal: event.status),
      ),
    );
  }

  void _updatePrimaryColor(
      UpdatePrimaryColor event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        display: state.display.copyWith(primaryColor: event.color),
      ),
    );
  }

  void _setAutoBrightness(
      SetAutoBrightness event, Emitter<SettingsState> emit) {
    emit(
      state.copyWith(
        display: state.display.copyWith(autoBrightness: event.status),
      ),
    );
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
