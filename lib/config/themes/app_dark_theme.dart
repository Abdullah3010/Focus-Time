import 'package:flutter/material.dart';
import 'package:focus_time/core/utils/app_colors.dart';

final appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 50, 50, 50),
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    background: AppColors.backgroundLight,
    error: AppColors.error,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
  ),
  inputDecorationTheme: _getInputDecoration(),
);

InputDecorationTheme _getInputDecoration() {
  return InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    floatingLabelStyle: const TextStyle(
      color: AppColors.primary,
      fontSize: 18,
    ),
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.5),
      fontSize: 14,
    ),
    errorStyle: const TextStyle(
      color: AppColors.error,
    ),
    iconColor: AppColors.primary,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.black.withOpacity(0.3),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.error,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
