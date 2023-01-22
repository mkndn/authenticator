import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';
part 'app_bloc.g.dart';

class AppBloc extends Bloc<AppEvent, AppState> with ChangeNotifier {
  AppBloc({
    bool settingsLoaded = false,
    bool hasCredentials = false,
    List<String> availableBiometricsList = const [],
  }) : super(AppState.initial(
          settingsLoadedValue: settingsLoaded,
          hasCredentialsValue: hasCredentials,
          availableBiometricsList: availableBiometricsList,
        )) {
    on<AppEvent>(
      (event, emit) => event.map(
        setSettingsLoaded: (event) => _setSettingsLoaded(event, emit),
        setAuthenticated: (event) => _setAuthenticated(event, emit),
        isAuthenticating: (event) => _isAuthenticating(event, emit),
        setHasCredentials: (event) => _setHasCredentials(event, emit),
        setselectedSidebarItemIndex: (event) =>
            _setselectedSidebarItemIndex(event, emit),
        setAvailableBiometricsOptions: (event) =>
            _setAvailableBiometricsOptions(event, emit),
      ),
    );
  }

  void _setSettingsLoaded(SetSettingsLoaded event, Emitter<AppState> emit) {
    emit(
      state.copyWith(settingsLoaded: true),
    );
  }

  void _setAuthenticated(SetAuthenticated event, Emitter<AppState> emit) {
    emit(
      state.copyWith(authenticated: event.status, isAuthenticating: false),
    );
    notifyListeners();
  }

  void _isAuthenticating(IsAuthenticating event, Emitter<AppState> emit) {
    emit(
      state.copyWith(isAuthenticating: event.status),
    );
    notifyListeners();
  }

  void _setHasCredentials(SetHasCredentials event, Emitter<AppState> emit) {
    emit(
      state.copyWith(authenticated: event.status),
    );
    notifyListeners();
  }

  void _setselectedSidebarItemIndex(
      SetselectedSidebarItemIndex event, Emitter<AppState> emit) {
    emit(
      state.copyWith(selectedSidebarItemIndex: event.index),
    );
  }

  void _setAvailableBiometricsOptions(
      SetAvailableBiometricsOptions event, Emitter<AppState> emit) {
    emit(
      state.copyWith(availableBiometricsOptions: event.options),
    );
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
