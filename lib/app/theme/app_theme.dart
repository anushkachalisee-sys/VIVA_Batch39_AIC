import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
import 'app_dimensions.dart';
import 'app_text_styles.dart';

/// Global application theme configuration for VIVA.
/// Establishes the dark, immersive music identity across all widgets.
abstract class AppTheme {
  AppTheme._();

  /// Default and primary dark theme for VIVA.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondaryAccent,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.primaryText,
        onSecondary: AppColors.primaryText,
        onSurface: AppColors.primaryText,
        onError: AppColors.primaryText,
      ),

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: AppColors.primaryText,
          size: AppDimensions.iconMedium,
        ),
        titleTextStyle: AppTextStyles.heading2,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
          side: const BorderSide(
            color: AppColors.border,
            width: 1.0,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.searchBackground,
        hintStyle: AppTextStyles.hint,
        labelStyle: AppTextStyles.label,
        contentPadding: AppDimensions.inputPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryText,
          elevation: 0,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryAccent,
          textStyle: AppTextStyles.buttonSmall,
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryText,
          side: const BorderSide(color: AppColors.border),
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeight),
          textStyle: AppTextStyles.buttonSmall,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
          ),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1.0,
        space: 1.0,
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: AppTextStyles.body,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.primaryText,
        size: AppDimensions.iconMedium,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.heading1,
        headlineLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading2,
        headlineSmall: AppTextStyles.heading3,
        titleLarge: AppTextStyles.heading3,
        titleMedium: AppTextStyles.sectionTitle,
        titleSmall: AppTextStyles.subtitle,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
        labelMedium: AppTextStyles.label,
        labelSmall: AppTextStyles.caption,
      ),
    );
  }
}
