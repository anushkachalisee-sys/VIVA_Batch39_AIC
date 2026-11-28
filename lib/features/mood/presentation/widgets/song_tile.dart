import 'package:flutter/material.dart';
import '../../data/models/mood_model.dart';
import 'package:viva/core/constants/colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.


class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onFavouriteToggle;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.onFavouriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            song.albumCover,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.avatarPlaceholder,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.music_note, color: AppColors.secondaryText),
              );
            },
          ),
        ),
        title: Text(
          song.title,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              song.artistName,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.accentCyan.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                song.matchPercentage,
                style: const TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              song.duration,
              style: const TextStyle(
                color: AppColors.mutedText,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                song.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: song.isFavourite ? AppColors.primaryPink : AppColors.secondaryText,
                size: 20,
              ),
              onPressed: onFavouriteToggle,
            ),
          ],
        ),
      ),
    );
  }
}
