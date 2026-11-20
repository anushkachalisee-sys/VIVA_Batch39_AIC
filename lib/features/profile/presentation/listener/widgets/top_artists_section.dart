import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../domain/entities/listener_profile.dart';

class TopArtistsSection extends StatelessWidget {
  final ListenerProfile profile;
  final void Function(TopArtistEntity artist)? onArtistTap;

  const TopArtistsSection({
    super.key,
    required this.profile,
    this.onArtistTap,
  });

  @override
  Widget build(BuildContext context) {
    if (profile.topArtists.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Top Artists',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Horizontal Artist List
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: profile.topArtists.map((artist) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: _buildArtistCard(artist),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtistCard(TopArtistEntity artist) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onArtistTap?.call(artist),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 142,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Row(
            children: [
              // Image Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Image.asset(
                    artist.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildArtistPlaceholder(artist.name);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Artist Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      artist.name,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      artist.genre,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtistPlaceholder(String name) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryPurple, AppColors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0] : 'A',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
