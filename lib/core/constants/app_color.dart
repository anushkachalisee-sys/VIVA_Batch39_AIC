import 'package:flutter/material.dart';

/// App color palette matching the VIVA Listener Profile Figma design specifications.
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color mainBackground = Color(0xFF0D0C1B);
  static const Color secondaryBackground = Color(0xFF151329);
  static const Color cardBackground = Color(0xFF19182F);
  static const Color cardBorder = Color(0xFF302D50);
  static const Color headerButtonBg = Color(0xFF201D3D);

  // Accents
  static const Color primaryPurple = Color(0xFF8B35F2);
  static const Color pinkAccent = Color(0xFFF02C91);
  static const Color cyanAccent = Color(0xFF00D9E9);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9692B0);
  static const Color textMuted = Color(0xFF77738F);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, pinkAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient avatarGlowGradient = LinearGradient(
    colors: [primaryPurple, pinkAccent, cyanAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
