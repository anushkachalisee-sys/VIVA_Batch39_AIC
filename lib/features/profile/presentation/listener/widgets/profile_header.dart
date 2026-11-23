import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const ProfileHeader({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onBackTap ?? () {},
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.unselectedChip,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryText,
                  size: 20,
                ),
              ),
            ),
          ),

          // Title
          const Text(
            'Profile',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.3,
            ),
          ),

          // Settings Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onSettingsTap ?? () {},
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.unselectedChip,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.primaryText,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
