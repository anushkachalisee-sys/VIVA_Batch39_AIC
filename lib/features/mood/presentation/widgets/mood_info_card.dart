import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.
import '../../data/models/mood_model.dart';

class MoodInfoCard extends StatelessWidget {
  final Mood mood;
  final VoidCallback? onChangePressed;

  const MoodInfoCard({
    super.key,
    required this.mood,
    this.onChangePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mood.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              mood.emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Selected Vibe: ',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      mood.name,
                      style: const TextStyle(
                        color: AppColors.accentCyan,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  mood.description,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (onChangePressed != null)
            TextButton(
              onPressed: onChangePressed,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentCyan,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                backgroundColor: AppColors.accentCyan.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Change',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
