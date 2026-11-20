import 'package:flutter/material.dart';
import 'package:viva/core/constants/app_colors.dart';
import 'package:viva/features/profile/domain/entities/listener_profile.dart';

class MusicTasteSection extends StatelessWidget {
  final ListenerProfile profile;

  const MusicTasteSection({
    super.key,
    required this.profile,
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
            'My Music Taste',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          // GENRES Row
          _buildTasteRow(
            label: 'GENRES',
            items: profile.genreTaste,
            borderColors: [
              AppColors.primaryPurple,
              AppColors.pinkAccent,
              AppColors.cyanAccent,
            ],
          ),
          const SizedBox(height: 10),

          // ARTISTS Row
          _buildTasteRow(
            label: 'ARTISTS',
            items: profile.artistTaste,
            borderColors: [
              AppColors.pinkAccent,
              AppColors.primaryPurple,
            ],
          ),
          const SizedBox(height: 10),

          // LANGUAGES Row
          _buildTasteRow(
            label: 'LANGUAGES',
            items: profile.languageTaste,
            borderColors: [
              AppColors.cyanAccent,
              AppColors.primaryPurple,
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasteRow({
    required String label,
    required List<String> items,
    required List<Color> borderColors,
  }) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Category Label
        SizedBox(
          width: 85,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),

        // Chips
        Expanded(
          child: Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: List.generate(items.length, (index) {
              final color = borderColors[index % borderColors.length];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color, width: 1.2),
                ),
                child: Text(
                  items[index],
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
