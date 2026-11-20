import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Reusable selection chip for genres, languages, vibes, and listening preferences.
/// Uses AppColors, AppDimensions, and AppTextStyles.
/// Displays a vibrant purple-to-pink gradient with checkmark and glowing drop shadow
/// when selected, and a dark slate/navy pill when unselected.
class PreferenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PreferenceChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: AppDimensions.chipPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.chipRadius),
          gradient: isSelected ? AppColors.primaryGradient : null,
          color: isSelected ? null : AppColors.unselectedChip,
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppColors.unselectedChipBorder,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryPink.withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(
                Icons.check,
                color: Colors.white,
                size: 13,
              ),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: isSelected
                  ? AppTextStyles.chipSelected
                  : AppTextStyles.chipUnselected,
            ),
          ],
        ),
      ),
    );
  }
}
