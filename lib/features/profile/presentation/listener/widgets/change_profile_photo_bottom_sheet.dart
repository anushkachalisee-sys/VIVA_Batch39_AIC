import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.
import 'package:viva/app/theme/app_text_styles.dart';

/// Bottom sheet modal for changing profile photo (Gallery, Camera, Remove Photo, Cancel).
class ChangeProfilePhotoBottomSheet extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final VoidCallback onRemoveTap;

  const ChangeProfilePhotoBottomSheet({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.onRemoveTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag indicator
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title & Subtitle
          const Text(
            'Change Profile Photo',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 4),
          const Text(
            'A face to go with your music taste.',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 24),

          // Gallery Option
          _buildOptionTile(
            context,
            icon: Icons.photo_library_outlined,
            title: 'Gallery',
            iconColor: AppColors.primaryPurple,
            onTap: onGalleryTap,
          ),
          const SizedBox(height: 12),

          // Camera Option
          _buildOptionTile(
            context,
            icon: Icons.camera_alt_outlined,
            title: 'Camera',
            iconColor: AppColors.accentCyan,
            onTap: onCameraTap,
          ),
          const SizedBox(height: 12),

          // Remove Photo Option
          _buildOptionTile(
            context,
            icon: Icons.delete_outline,
            title: 'Remove Photo',
            iconColor: AppColors.primaryPink,
            textColor: AppColors.primaryPink,
            onTap: onRemoveTap,
          ),
          const SizedBox(height: 16),

          // Cancel Button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.cardBorder),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.searchBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: textColor ?? AppColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.secondaryText,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
