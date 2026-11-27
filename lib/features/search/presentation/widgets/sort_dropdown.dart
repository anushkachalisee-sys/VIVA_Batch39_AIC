import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable VIVA-styled sorting dropdown for lists and search results.
///
/// Displays the currently selected sort option in a compact dark pill trigger
/// and opens a themed popup menu of configurable sort options.
class SortDropdown extends StatelessWidget {
  static const List<String> defaultOptions = [
    'Relevance',
    'Popularity',
    'Newest First',
    'Oldest First',
    'Alphabetical',
  ];

  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String>? onSelected;
  final String? prefixLabel;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? menuBackgroundColor;
  final Color? accentColor;
  final EdgeInsetsGeometry padding;
  final String? tooltip;

  const SortDropdown({
    super.key,
    this.options = defaultOptions,
    required this.selectedOption,
    this.onSelected,
    this.prefixLabel,
    this.leadingIcon = Icons.swap_vert_rounded,
    this.trailingIcon = Icons.keyboard_arrow_down_rounded,
    this.height = AppDimensions.buttonHeightSmall,
    this.borderRadius = AppDimensions.chipRadius,
    this.backgroundColor,
    this.borderColor,
    this.menuBackgroundColor,
    this.accentColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.tooltip = 'Sort options',
  });

  @override
  Widget build(BuildContext context) {
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    final effectiveSelected =
        selectedOption != null && options.contains(selectedOption)
            ? selectedOption!
            : options.first;
    final effectiveAccent = accentColor ?? AppColors.accentCyan;
    final effectiveBg = backgroundColor ?? AppColors.unselectedChip;
    final effectiveBorder = borderColor ?? AppColors.unselectedChipBorder;
    final effectiveMenuBg = menuBackgroundColor ?? AppColors.cardBackground;
    final radius = BorderRadius.circular(borderRadius);

    return PopupMenuButton<String>(
      initialValue: effectiveSelected,
      enabled: onSelected != null,
      tooltip: tooltip,
      position: PopupMenuPosition.under,
      offset: const Offset(0, 6),
      color: effectiveMenuBg,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        side: const BorderSide(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      onSelected: onSelected,
      itemBuilder: (context) {
        return options.map((option) {
          final isSelected = option == effectiveSelected;
          return PopupMenuItem<String>(
            value: option,
            height: 42.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: AppTextStyles.body.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? AppColors.primaryText
                          : AppColors.secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: AppDimensions.space12),
                  Icon(
                    Icons.check_rounded,
                    color: AppColors.primaryPink,
                    size: 16.0,
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: radius,
          border: Border.all(
            color: effectiveBorder,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              leadingIcon,
              color: effectiveAccent,
              size: 17.0,
            ),
            const SizedBox(width: 6.0),
            if (prefixLabel != null && prefixLabel!.isNotEmpty) ...[
              Text(
                prefixLabel!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.mutedText,
                ),
              ),
              const SizedBox(width: 4.0),
            ],
            Flexible(
              child: Text(
                effectiveSelected,
                style: AppTextStyles.chipSelected.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 4.0),
            Icon(
              trailingIcon,
              color: AppColors.secondaryText,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
