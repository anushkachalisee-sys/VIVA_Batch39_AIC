import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable horizontally scrollable category tabs styled for VIVA.
///
/// Supports arbitrary category lists, optional icons/counts per category,
/// and selected/unselected visual states using VIVA's gradient pill aesthetic.
class CategoryTabs extends StatelessWidget {
  static const List<String> defaultCategories = [
    'All',
    'Artists',
    'Communities',
    'Events',
  ];

  final List<String> categories;
  final String? selectedCategory;
  final ValueChanged<String>? onCategoryChanged;
  final Map<String, IconData>? categoryIcons;
  final Map<String, int>? categoryCounts;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry itemPadding;
  final double spacing;
  final double borderRadius;
  final Gradient? selectedGradient;
  final Color? unselectedColor;
  final Color? unselectedBorderColor;

  const CategoryTabs({
    super.key,
    this.categories = defaultCategories,
    required this.selectedCategory,
    this.onCategoryChanged,
    this.categoryIcons,
    this.categoryCounts,
    this.padding = EdgeInsets.zero,
    this.itemPadding = AppDimensions.chipPadding,
    this.spacing = AppDimensions.space8,
    this.borderRadius = AppDimensions.chipRadius,
    this.selectedGradient,
    this.unselectedColor,
    this.unselectedBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: List.generate(categories.length, (index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          final icon = categoryIcons?[category];
          final count = categoryCounts?[category];

          return Padding(
            padding: EdgeInsets.only(
              right: index < categories.length - 1 ? spacing : 0.0,
            ),
            child: _CategoryTabItem(
              label: category,
              icon: icon,
              count: count,
              isSelected: isSelected,
              padding: itemPadding,
              borderRadius: borderRadius,
              selectedGradient: selectedGradient ?? AppColors.primaryGradient,
              unselectedColor: unselectedColor ?? AppColors.unselectedChip,
              unselectedBorderColor:
                  unselectedBorderColor ?? AppColors.unselectedChipBorder,
              onTap: onCategoryChanged != null
                  ? () => onCategoryChanged!(category)
                  : null,
            ),
          );
        }),
      ),
    );
  }
}

class _CategoryTabItem extends StatelessWidget {
  final String label;
  final IconData? icon;
  final int? count;
  final bool isSelected;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Gradient selectedGradient;
  final Color unselectedColor;
  final Color unselectedBorderColor;
  final VoidCallback? onTap;

  const _CategoryTabItem({
    required this.label,
    this.icon,
    this.count,
    required this.isSelected,
    required this.padding,
    required this.borderRadius,
    required this.selectedGradient,
    required this.unselectedColor,
    required this.unselectedBorderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: isSelected ? selectedGradient : null,
            color: isSelected ? null : unselectedColor,
            border: Border.all(
              color: isSelected ? Colors.transparent : unselectedBorderColor,
              width: 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primaryPink.withValues(alpha: 0.30),
                      blurRadius: 10.0,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15.0,
                  color: isSelected
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
                ),
                const SizedBox(width: 6.0),
              ],
              Text(
                label,
                style: isSelected
                    ? AppTextStyles.chipSelected
                    : AppTextStyles.chipUnselected,
              ),
              if (count != null) ...[
                const SizedBox(width: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryText.withValues(alpha: 0.22)
                        : AppColors.cardBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                  child: Text(
                    '$count',
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected
                          ? AppColors.primaryText
                          : AppColors.secondaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
