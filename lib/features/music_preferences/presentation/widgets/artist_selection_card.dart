import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';

/// Reusable artist selection widget displaying a circular avatar, an optional
/// artist image or gradient fallback, a cyan checkmark badge when selected,
/// and the artist's name below.
class ArtistSelectionCard extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final String? imagePath;
  final ImageProvider? image;
  final Gradient? avatarGradient;

  const ArtistSelectionCard({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    this.imagePath,
    this.image,
    this.avatarGradient,
  });

  DecorationImage? _buildDecorationImage() {
    if (image != null) {
      return DecorationImage(
        image: image!,
        fit: BoxFit.cover,
      );
    }
    if (imagePath != null && imagePath!.isNotEmpty) {
      if (imagePath!.startsWith('http://') || imagePath!.startsWith('https://')) {
        return DecorationImage(
          image: NetworkImage(imagePath!),
          fit: BoxFit.cover,
        );
      }
      return DecorationImage(
        image: AssetImage(imagePath!),
        fit: BoxFit.cover,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final decorationImage = _buildDecorationImage();

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: AppDimensions.avatarSize + 2,
            height: AppDimensions.avatarSize + 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Circular Avatar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: AppDimensions.avatarSize,
                  height: AppDimensions.avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: decorationImage,
                    gradient: decorationImage == null && isSelected
                        ? (avatarGradient ?? AppColors.avatarGradient)
                        : null,
                    color: decorationImage == null && !isSelected
                        ? AppColors.avatarPlaceholder
                        : null,
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppColors.primaryPink.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                        : null,
                  ),
                ),

                // Cyan Selection Badge
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: AppDimensions.badgeSize,
                      height: AppDimensions.badgeSize,
                      decoration: BoxDecoration(
                        color: AppColors.accentCyan,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.cardBackground,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          size: 11,
                          color: AppColors.darkCheckIcon,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.smallSpacing),
          Text(
            name,
            style: isSelected
                ? AppTextStyles.artistNameSelected
                : AppTextStyles.artistNameUnselected,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
