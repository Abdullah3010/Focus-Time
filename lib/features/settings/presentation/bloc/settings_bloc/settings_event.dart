part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SwitchThemeModeEvent extends SettingsEvent {

  const SwitchThemeModeEvent();
  @override
  List<Object> get props => [];
}
