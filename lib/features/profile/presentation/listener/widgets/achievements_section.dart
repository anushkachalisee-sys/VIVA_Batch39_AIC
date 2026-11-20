import 'package:flutter/material.dart';
import 'package:viva/core/constants/app_colors.dart';
import 'package:viva/features/profile/domain/entities/listener_profile.dart';

class AchievementsSection extends StatelessWidget {
  final ListenerProfile profile;

  const AchievementsSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    if (profile.achievements.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Achievements',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Badge Row
          Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: profile.achievements.map((achievement) {
              final isTwin = achievement.type.toLowerCase() == 'twin';
              return _buildAchievementBadge(
                title: achievement.title,
                icon: isTwin ? Icons.auto_awesome : Icons.explore_outlined,
                accentColor: isTwin ? AppColors.pinkAccent : AppColors.cyanAccent,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementBadge({
    required String title,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.7), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: accentColor,
              size: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
