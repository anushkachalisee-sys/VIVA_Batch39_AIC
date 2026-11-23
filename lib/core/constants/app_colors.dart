import 'package:flutter/material.dart';

/// App color palette for VIVA Music App according to design specification.
class AppColors {
  static const Color background = Color(0xFF0D0D1D);
  static const Color secondaryBackground = Color(0xFF17102B);
  static const Color cardBackground = Color(0xFF19182B);
  static const Color inputBackground = Color(0xFF19182B);

  static const Color purple = Color(0xFF9635ED);
  static const Color pink = Color(0xFFE936A9);
  static const Color cyan = Color(0xFF18D8E8);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA5A0BB);
  static const Color border = Color(0xFF302746);
  static const Color focusedBorder = Color(0xFF9635ED);

  // Aliases and additional colors used across feature widgets
  static const Color primaryPurple = purple;
  static const Color pinkAccent = pink;
  static const Color cyanAccent = cyan;
  static const Color cardBorder = border;
  static const Color textMuted = textSecondary;
  static const Color mainBackground = background;
  static const Color headerButtonBg = secondaryBackground;
  static const Color primaryText = textPrimary;
  static const Color secondaryText = textSecondary;
  static const Color mutedText = textSecondary;
  static const Color primaryPink = pink;
  static const Color accentCyan = cyan;
  static const Color back = background;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [purple, pink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0D0D1D), Color(0xFF17102B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient soundwaveGlow = LinearGradient(
    colors: [Color(0x339635ED), Color(0x3318D8E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
