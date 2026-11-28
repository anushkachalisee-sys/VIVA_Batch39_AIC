import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_dimensions.dart';
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/colors.dart';

/// Reusable recent search history section for VIVA.
///
/// Purely UI-driven (no permanent storage): accepts a list of previous search
/// queries and exposes callbacks for tapping an item, removing an individual
/// item, and clearing all items.
class SearchHistorySection extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String>? onItemTap;
  final ValueChanged<String>? onRemoveItem;
  final VoidCallback? onClearAll;
  final String title;
  final String clearAllLabel;
  final String emptyMessage;
  final String? emptySubtitle;
  final IconData headingIcon;
  final IconData itemLeadingIcon;
  final IconData emptyIcon;
  final bool showEmptyState;
  final bool showDividers;
  final int? maxItems;
  final Widget? emptyState;
  final EdgeInsetsGeometry padding;

  const SearchHistorySection({
    super.key,
    required this.items,
    this.onItemTap,
    this.onRemoveItem,
    this.onClearAll,
    this.title = 'Recent Searches',
    this.clearAllLabel = 'Clear All',
    this.emptyMessage = 'No recent searches',
    this.emptySubtitle,
    this.headingIcon = Icons.access_time_rounded,
    this.itemLeadingIcon = Icons.history_rounded,
    this.emptyIcon = Icons.manage_search_rounded,
    this.showEmptyState = true,
    this.showDividers = true,
    this.maxItems,
    this.emptyState,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final visibleItems = maxItems != null && maxItems! < items.length
        ? items.take(maxItems!).toList()
        : items;

    if (visibleItems.isEmpty && !showEmptyState) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(hasItems: visibleItems.isNotEmpty),
          const SizedBox(height: AppDimensions.space12),
          if (visibleItems.isEmpty)
            emptyState ?? _buildDefaultEmptyState()
          else
            _buildHistoryList(visibleItems),
        ],
      ),
    );
  }

  Widget _buildHeader({required bool hasItems}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                headingIcon,
                color: AppColors.accentCyan,
                size: 18.0,
              ),
              const SizedBox(width: AppDimensions.space8),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.sectionTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (hasItems && onClearAll != null)
          TextButton(
            onPressed: onClearAll,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryPink,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.space8,
                vertical: AppDimensions.space4,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              clearAllLabel,
              style: AppTextStyles.buttonSmall.copyWith(
                color: AppColors.primaryPink,
                fontSize: 13.0,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHistoryList(List<String> visibleItems) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: visibleItems.length,
          separatorBuilder: (_, _) => showDividers
              ? const Divider(
                  height: 1.0,
                  thickness: 1.0,
                  color: AppColors.cardBorder,
                )
              : const SizedBox.shrink(),
          itemBuilder: (context, index) {
            final query = visibleItems[index];
            return _HistoryItemTile(
              query: query,
              leadingIcon: itemLeadingIcon,
              onTap: onItemTap != null ? () => onItemTap!(query) : null,
              onRemove:
                  onRemoveItem != null ? () => onRemoveItem!(query) : null,
            );
          },
        ),
      ),
    );
  }

  Widget _buildDefaultEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.space16,
        vertical: AppDimensions.space24,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: AppColors.unselectedChip,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.unselectedChipBorder,
                width: 1.0,
              ),
            ),
            child: Icon(
              emptyIcon,
              color: AppColors.secondaryText,
              size: 22.0,
            ),
          ),
          const SizedBox(height: AppDimensions.space12),
          Text(
            emptyMessage,
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (emptySubtitle != null && emptySubtitle!.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.space4),
            Text(
              emptySubtitle!,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _HistoryItemTile extends StatelessWidget {
  final String query;
  final IconData leadingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const _HistoryItemTile({
    required this.query,
    required this.leadingIcon,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space16,
            vertical: AppDimensions.space12,
          ),
          child: Row(
            children: [
              Icon(
                leadingIcon,
                color: AppColors.secondaryText,
                size: 18.0,
              ),
              const SizedBox(width: AppDimensions.space12),
              Expanded(
                child: Text(
                  query,
                  style: AppTextStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onRemove != null) ...[
                const SizedBox(width: AppDimensions.space8),
                Tooltip(
                  message: 'Remove',
                  child: InkResponse(
                    onTap: onRemove,
                    radius: 18.0,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColors.mutedText,
                        size: 17.0,
                      ),
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
