import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Reusable card container for preference sections.
/// Features a dark rounded container with subtle border and a colored vertical
/// accent bar preceding the section title.
class PreferenceSection extends StatelessWidget {
  final String title;
  final Color indicatorColor;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const PreferenceSection({
    super.key,
    required this.title,
    required this.indicatorColor,
    required this.child,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.only(bottom: AppDimensions.sectionSpacing),
      padding: padding ?? AppDimensions.cardPadding,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: AppDimensions.indicatorBarWidth,
                height: AppDimensions.indicatorBarHeight,
                decoration: BoxDecoration(
                  color: indicatorColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppDimensions.smallSpacing),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.sectionTitle,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.mediumSpacing),
          child,
        ],
      ),
    );
  }
}
