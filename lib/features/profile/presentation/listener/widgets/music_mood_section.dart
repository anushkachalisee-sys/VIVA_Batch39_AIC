import 'package:flutter/material.dart';
import 'package:viva/core/constants/app_colors.dart';

class MusicMoodSection extends StatelessWidget {
  final String activeMood;
  final ValueChanged<String> onMoodSelected;

  const MusicMoodSection({
    super.key,
    required this.activeMood,
    required this.onMoodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Music Mood',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // Mood Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder, width: 1),
            ),
            child: Row(
              children: [
                _buildMoodItem(
                  moodName: 'Chill',
                  icon: Icons.nightlight_round,
                  color: AppColors.primaryPurple,
                ),
                _buildMoodItem(
                  moodName: 'Happy',
                  icon: Icons.sentiment_satisfied_alt_outlined,
                  color: AppColors.cyanAccent,
                ),
                _buildMoodItem(
                  moodName: 'Late Night',
                  icon: Icons.auto_awesome,
                  color: AppColors.pinkAccent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodItem({
    required String moodName,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = activeMood == moodName;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onMoodSelected(moodName),
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? color.withValues(alpha: 0.18) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: color.withValues(alpha: 0.6), width: 1)
                  : Border.all(color: Colors.transparent, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    moodName,
                    style: TextStyle(
                      color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
