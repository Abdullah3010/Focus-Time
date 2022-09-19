import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  ThemeMode themeMode = ThemeMode.light;
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      if (event is SwitchThemeModeEvent) {
        if (themeMode == ThemeMode.light) {
          themeMode = ThemeMode.dark;
        } else {
          themeMode = ThemeMode.light;
        }
        emit(SwitchThemeModeState(themeMode: themeMode));
      }
    });
  }
}
