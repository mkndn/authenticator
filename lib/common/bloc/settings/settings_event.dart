part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  //Security settings
  const factory SettingsEvent.updateFingerPrintState(bool status) =
      UpdateFingerPrintState;
  const factory SettingsEvent.updatePasswordState(bool status) =
      UpdatePasswordState;
  const factory SettingsEvent.updatePinState(bool status) = UpdatePinState;
  //Display settings
  const factory SettingsEvent.updateTapToRevealState(bool status) =
      UpdateTapToRevealState;
  const factory SettingsEvent.updatePrimaryColor(String color) =
      UpdatePrimaryColor;
  const factory SettingsEvent.setAutoBrightness(bool status) =
      SetAutoBrightness;
}
