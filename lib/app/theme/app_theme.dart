import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

/// Application theme definition for VIVA.
///
/// Implements Material 3 with the VIVA dark aesthetic guidelines:
/// - Deep navy (#0D0D1B) canvas
/// - Purple (#8B35F0) & Pink (#D52CCB) accents
/// - Cyan (#20D9F2) highlights
/// - Rounded dark input fields (#19192F) with 18px radius
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.mainBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purpleAccent,
        onPrimary: AppColors.primaryText,
        secondary: AppColors.pinkAccent,
        onSecondary: AppColors.primaryText,
        tertiary: AppColors.cyanAccent,
        surface: AppColors.secondaryBackground,
        onSurface: AppColors.primaryText,
        error: AppColors.errorText,
        onError: AppColors.primaryText,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.primaryText,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
          letterSpacing: -0.3,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryText,
          height: 1.4,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryText,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryText,
          letterSpacing: 0.3,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        hintStyle: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        prefixIconColor: AppColors.secondaryText,
        suffixIconColor: AppColors.secondaryText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.purpleAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.errorText, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.errorText, width: 1.5),
        ),
        errorStyle: const TextStyle(
          color: AppColors.errorText,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(
          color: AppColors.inputBorder,
          width: 1.5,
        ),
        checkColor: WidgetStateProperty.all(AppColors.primaryText),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.purpleAccent;
          }
          return AppColors.inputBackground;
        }),
      ),
    );
  }

  // Alias for backward compatibility if lightTheme was referenced
  static ThemeData get lightTheme => darkTheme;
}
