import 'package:flutter/material.dart';

/// Centralized dimensions, spacings, and radiuses for the VIVA application.
/// Ensures consistent scale and rhythm across all user interfaces.
abstract class AppDimensions {
  AppDimensions._();

  // Spacing Scale (4, 8, 12, 16, 24, 32, 40)
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;

  // Screen Padding
  static const double screenPaddingHorizontal = 16.0;
  static const double screenPaddingVertical = 16.0;
  static const double horizontalScreenPadding = 16.0;
  static const double verticalScreenPadding = 12.0;
  static const double bottomContentInset = 120.0;

  // Component Spacing
  static const double sectionSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 14.0;
  static const double largeSpacing = 20.0;
  static const double itemSpacing = 12.0;

  // Border Radii
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusFull = 999.0;

  // Semantic Component Radii
  static const double cardRadius = 20.0;
  static const double chipRadius = 20.0;
  static const double inputRadius = 12.0;
  static const double buttonRadius = 26.0;
  static const double badgeRadius = 10.0;

  // Button Heights
  static const double buttonHeightSmall = 38.0;
  static const double buttonHeight = 52.0;
  static const double buttonHeightMedium = 52.0;
  static const double buttonHeightLarge = 56.0;

  // Text Field / Input Heights
  static const double inputHeight = 44.0;
  static const double textFieldHeight = 52.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconExtraLarge = 48.0;

  // Avatar Sizes
  static const double avatarSmall = 36.0;
  static const double avatarMedium = 48.0;
  static const double avatarSize = 60.0;
  static const double avatarLarge = 64.0;
  static const double avatarExtraLarge = 96.0;

  // Badges & Indicators
  static const double badgeSize = 19.0;
  static const double verifiedBadgeSize = 18.0;
  static const double indicatorBarWidth = 3.5;
  static const double indicatorBarHeight = 16.0;

  // Reusable Edge Insets
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(
    horizontalScreenPadding,
    verticalScreenPadding,
    horizontalScreenPadding,
    bottomContentInset,
  );

  static const EdgeInsets screenPaddingDefault = EdgeInsets.symmetric(
    horizontal: screenPaddingHorizontal,
    vertical: screenPaddingVertical,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(12.0);

  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: 14.0,
    vertical: 8.5,
  );

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 14.0,
  );
}