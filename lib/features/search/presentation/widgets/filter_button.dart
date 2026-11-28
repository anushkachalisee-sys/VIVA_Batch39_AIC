import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable VIVA-styled filter trigger button with optional label and active
/// filter indicator (dot or count badge).
class FilterButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? label;
  final IconData icon;
  final bool hasActiveFilters;
  final int? activeFilterCount;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? activeColor;
  final Color? iconColor;
  final String? tooltip;

  const FilterButton({
    super.key,
    this.onTap,
    this.label,
    this.icon = Icons.tune_rounded,
    this.hasActiveFilters = false,
    this.activeFilterCount,
    this.height = AppDimensions.buttonHeightSmall,
    this.borderRadius = AppDimensions.chipRadius,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.activeColor,
    this.iconColor,
    this.tooltip = 'Filters',
  });

  bool get _isActive => hasActiveFilters || (activeFilterCount ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    final hasLabel = label != null && label!.trim().isNotEmpty;
    final effectiveActiveColor = activeColor ?? AppColors.primaryPink;
    final effectiveBg = _isActive
        ? effectiveActiveColor.withValues(alpha: 0.14)
        : (backgroundColor ?? AppColors.unselectedChip);
    final effectiveBorder = _isActive
        ? effectiveActiveColor.withValues(alpha: 0.75)
        : (borderColor ?? AppColors.unselectedChipBorder);
    final effectiveIconColor =
        iconColor ?? (_isActive ? effectiveActiveColor : AppColors.primaryPink);
    final radius = BorderRadius.circular(borderRadius);

    final effectivePadding = padding ??
        (hasLabel
            ? const EdgeInsets.symmetric(horizontal: 14.0)
            : const EdgeInsets.symmetric(horizontal: 10.0));

    final content = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: height,
          padding: effectivePadding,
          decoration: BoxDecoration(
            color: effectiveBg,
            borderRadius: radius,
            border: Border.all(
              color: effectiveBorder,
              width: _isActive ? 1.2 : 1.0,
            ),
            boxShadow: _isActive
                ? [
                    BoxShadow(
                      color: effectiveActiveColor.withValues(alpha: 0.22),
                      blurRadius: 10.0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    icon,
                    color: effectiveIconColor,
                    size: 18.0,
                  ),
                  if (_isActive && !hasLabel && (activeFilterCount ?? 0) == 0)
                    Positioned(
                      top: -2.0,
                      right: -2.0,
                      child: Container(
                        width: 7.0,
                        height: 7.0,
                        decoration: const BoxDecoration(
                          color: AppColors.accentCyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              if (hasLabel) ...[
                const SizedBox(width: 6.0),
                Text(
                  label!,
                  style: AppTextStyles.chipSelected.copyWith(
                    color: _isActive
                        ? AppColors.primaryText
                        : AppColors.secondaryText,
                  ),
                ),
              ],
              if ((activeFilterCount ?? 0) > 0) ...[
                const SizedBox(width: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: effectiveActiveColor,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                  child: Text(
                    '$activeFilterCount',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ] else if (_isActive && hasLabel) ...[
                const SizedBox(width: 6.0),
                Container(
                  width: 7.0,
                  height: 7.0,
                  decoration: const BoxDecoration(
                    color: AppColors.accentCyan,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: content,
      );
    }

    return content;
  }
}
