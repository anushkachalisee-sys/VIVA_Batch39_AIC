import 'package:flutter/material.dart';

/// Centralized color palette for the VIVA application.
/// Preserves the dark purple/navy aesthetic and purple-to-pink gradient accents.
abstract class AppColors {
  AppColors._();

  // Brand & Background
  static const Color background = Color(0xFF0B0813);
  static const Color cardBackground = Color(0xFF141126);
  static const Color cardBorder = Color(0xFF261F40);

  // Chips
  static const Color unselectedChip = Color(0xFF1E1A32);
  static const Color unselectedChipBorder = Color(0xFF2E2749);

  // Brand Accents
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryPink = Color(0xFFEC4899);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentCoral = Color(0xFFFB7185);

  // Search & Inputs
  static const Color searchBackground = Color(0xFF1B172E);
  static const Color searchBorder = Color(0xFF292244);
  static const Color searchHint = Color(0xFF6B6884);
  static const Color inputBackground = searchBackground;

  // Avatars
  static const Color avatarPlaceholder = Color(0xFF28243C);
  static const Color avatarPurple = Color(0xFF9333EA);

  // Typography
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFA5A4BE);
  static const Color mutedText = Color(0xFF7E7D96);
  static const Color darkCheckIcon = Color(0xFF0B0813);

  // Reusable Gradients
  static const LinearGradient soundwaveGlow = LinearGradient(
    colors: [accentCyan, primaryPurple, primaryPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient avatarGradient = LinearGradient(
    colors: [avatarPurple, primaryPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient bottomBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      background.withValues(alpha: 0.0),
      background.withValues(alpha: 0.85),
      background,
    ],
    stops: const [0.0, 0.35, 1.0],
  );

  // Semantic Design System Aliases for Universal UI Components
  static const Color primary = primaryPurple;
  static const Color secondary = primaryPink;
  static const Color secondaryAccent = primaryPurple;
  static const Color surface = cardBackground;
  static const Color surfaceElevated = unselectedChip;
  static const Color border = cardBorder;
  static const Color hintText = searchHint;

  // Status & Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Brand Gradient Aliases
  static const LinearGradient vivaGradient = primaryGradient;
  static const LinearGradient primaryGradientVertical = LinearGradient(
    colors: [primaryPurple, primaryPink],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
