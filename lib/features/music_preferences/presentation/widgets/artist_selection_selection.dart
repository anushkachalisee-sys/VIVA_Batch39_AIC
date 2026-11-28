import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';
import 'artist_search_field.dart';
import 'artist_selection_card.dart';
import 'preference_section.dart';

/// Reusable section for searching and picking favourite artists.
class ArtistSelectionSection extends StatelessWidget {
  final List<String> artists;
  final Set<String> selectedArtists;
  final TextEditingController searchController;
  final ValueChanged<String> onArtistToggled;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchCleared;
  final Map<String, String>? artistImages;

  const ArtistSelectionSection({
    super.key,
    required this.artists,
    required this.selectedArtists,
    required this.searchController,
    required this.onArtistToggled,
    this.onSearchChanged,
    this.onSearchCleared,
    this.artistImages,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceSection(
      title: 'Who do you love listening to?',
      indicatorColor: AppColors.primaryPink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Input
          ArtistSearchField(
            controller: searchController,
            onChanged: onSearchChanged,
            onClear: onSearchCleared,
          ),
          const SizedBox(height: AppDimensions.sectionSpacing),

          // Artist List
          if (artists.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Center(
                child: Text(
                  'No matching artists found',
                  style: AppTextStyles.caption,
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: artists.asMap().entries.map((entry) {
                  final index = entry.key;
                  final artist = entry.value;
                  final isSelected = selectedArtists.contains(artist);
                  final imagePath = artistImages?[artist];

                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == artists.length - 1 ? 0 : 20,
                    ),
                    child: ArtistSelectionCard(
                      name: artist,
                      isSelected: isSelected,
                      imagePath: imagePath,
                      onTap: () => onArtistToggled(artist),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
