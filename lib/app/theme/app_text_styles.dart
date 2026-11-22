import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized typography and text styles for the VIVA application.
/// Provides consistent typography across all screens and components.
/// Uses a modern geometric sans-serif font family (Inter / Poppins fallback).
abstract class AppTextStyles {
  AppTextStyles._();

  /// Preferred font family for VIVA
  static const String fontFamily = 'Inter';

  // Core Heading Styles
  /// Large screen heading / hero title (28px, Bold)
  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  /// Standard section / page heading (22px, Bold)
  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// Sub-section heading (18px, SemiBold)
  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.35,
  );

  // Body & Subtitle Styles
  /// Secondary explanatory subtitle (14px, Regular)
  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.secondaryText,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Standard body text (14px, Regular)
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  /// Small body text (12px, Regular)
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.secondaryText,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  /// Metadata, timestamps, captions (11px, Regular)
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.hintText,
    fontSize: 11.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  // Button & Interactive Control Styles
  /// Primary button label (16px, Bold)
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );

  /// Small / compact button label (14px, SemiBold)
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  /// Form field label / section label (13px, Medium)
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.secondaryText,
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  // Form Field Styles
  /// Active text field input text
  static const TextStyle input = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  /// Text field placeholder / hint text
  static const TextStyle hint = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.hintText,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  // Backward Compatibility Styles for Existing Features
  /// Legacy heading alias
  static const TextStyle heading = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
  );

  /// Legacy sectionTitle alias
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 15.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  /// Disabled button text
  static const TextStyle buttonDisabled = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.mutedText,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );

  /// Selected preference chip
  static const TextStyle chipSelected = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  /// Unselected preference chip
  static const TextStyle chipUnselected = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.secondaryText,
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Selected artist name label
  static const TextStyle artistNameSelected = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.primaryText,
    fontSize: 12.0,
    fontWeight: FontWeight.w600,
  );

  /// Unselected artist name label
  static const TextStyle artistNameUnselected = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.secondaryText,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
  );
}
