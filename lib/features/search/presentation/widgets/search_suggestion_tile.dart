import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable search suggestion tile for VIVA search results and auto-complete lists.
///
/// Supports a leading icon or image, primary title, optional subtitle,
/// optional category badge, trailing arrow, and tap callback.
class SearchSuggestionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? categoryLabel;
  final IconData? leadingIcon;
  final String? imageUrl;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;
  final bool showTrailingArrow;
  final IconData trailingIcon;
  final Color? leadingIconColor;
  final Color? leadingBackgroundColor;
  final Color? categoryColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double leadingSize;
  final bool isCircularLeading;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const SearchSuggestionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.categoryLabel,
    this.leadingIcon,
    this.imageUrl,
    this.leading,
    this.onTap,
    this.onTrailingTap,
    this.showTrailingArrow = true,
    this.trailingIcon = Icons.north_east_rounded,
    this.leadingIconColor,
    this.leadingBackgroundColor,
    this.categoryColor,
    this.backgroundColor,
    this.borderColor,
    this.leadingSize = 44.0,
    this.isCircularLeading = false,
    this.borderRadius = AppDimensions.radiusL,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppDimensions.space12,
      vertical: AppDimensions.space12,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);
    final effectiveBg = backgroundColor ?? AppColors.cardBackground;
    final effectiveBorder = borderColor ?? AppColors.cardBorder;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
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
            children: [
              _buildLeading(),
              const SizedBox(width: AppDimensions.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 14.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        subtitle!,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (categoryLabel != null && categoryLabel!.isNotEmpty) ...[
                const SizedBox(width: AppDimensions.space8),
                _CategoryBadge(
                  label: categoryLabel!,
                  color: categoryColor ?? AppColors.primaryPurple,
                ),
              ],
              if (showTrailingArrow) ...[
                const SizedBox(width: AppDimensions.space8),
                _buildTrailingArrow(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (leading != null) {
      return SizedBox(
        width: leadingSize,
        height: leadingSize,
        child: leading,
      );
    }

    final shapeRadius = isCircularLeading
        ? BorderRadius.circular(AppDimensions.radiusFull)
        : BorderRadius.circular(AppDimensions.radiusM);

    final bgColor = leadingBackgroundColor ?? AppColors.unselectedChip;
    final iconColor = leadingIconColor ?? AppColors.accentCyan;

    if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
      final trimmed = imageUrl!.trim();
      final isNetwork =
          trimmed.startsWith('http://') || trimmed.startsWith('https://');

      return ClipRRect(
        borderRadius: shapeRadius,
        child: Container(
          width: leadingSize,
          height: leadingSize,
          color: bgColor,
          child: isNetwork
              ? Image.network(
                  trimmed,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildIconFallback(iconColor),
                )
              : Image.asset(
                  trimmed,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildIconFallback(iconColor),
                ),
        ),
      );
    }

    return Container(
      width: leadingSize,
      height: leadingSize,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: shapeRadius,
        border: Border.all(
          color: AppColors.unselectedChipBorder,
          width: 1.0,
        ),
      ),
      child: _buildIconFallback(iconColor),
    );
  }

  Widget _buildIconFallback(Color iconColor) {
    return Center(
      child: Icon(
        leadingIcon ?? Icons.music_note_rounded,
        color: iconColor,
        size: leadingSize * 0.48,
      ),
    );
  }

  Widget _buildTrailingArrow() {
    final icon = Icon(
      trailingIcon,
      color: AppColors.secondaryText,
      size: 18.0,
    );

    if (onTrailingTap == null) {
      return icon;
    }

    return InkResponse(
      onTap: onTrailingTap,
      radius: 18.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: icon,
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryBadge({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space8,
        vertical: AppDimensions.space4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppDimensions.badgeRadius),
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
