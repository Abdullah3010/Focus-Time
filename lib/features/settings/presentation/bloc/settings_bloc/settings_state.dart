part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SwitchThemeModeState extends SettingsState {
  final ThemeMode themeMode;

  const SwitchThemeModeState({required this.themeMode});
  @override
  List<Object> get props => [themeMode];
}
