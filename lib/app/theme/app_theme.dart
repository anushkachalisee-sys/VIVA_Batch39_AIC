import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// App theme definition for VIVA.
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.secondaryBackground,
      ),
      fontFamily: 'Roboto',
    );
  }
}
