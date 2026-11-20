import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimensions.dart';
import 'providers/music_preferences_provider.dart';
import 'widgets/artist_selection_selection.dart';
import 'widgets/preference_bottom_bar.dart';
import 'widgets/preference_chip.dart';
import 'widgets/preference_header.dart';
import 'widgets/preference_section.dart';

/// Music Taste Setup Onboarding Screen for VIVA.
/// A single vertically scrollable screen allowing users to pick genres, artists,
/// languages, moods, and listening preferences, with a fixed bottom action button.
class MusicPreferencesScreen extends StatefulWidget {
  const MusicPreferencesScreen({super.key});

  @override
  State<MusicPreferencesScreen> createState() => _MusicPreferencesScreenState();
}

class _MusicPreferencesScreenState extends State<MusicPreferencesScreen> {
  late final MusicPreferencesProvider _provider;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _provider = MusicPreferencesProvider();
    _searchController = TextEditingController();

    _searchController.addListener(() {
      _provider.setArtistSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _provider.dispose();
    super.dispose();
  }

  void _onContinuePressed() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.primaryPurple, width: 1),
        ),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.accentCyan,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Saved ${_provider.totalSelections} preferences! (Genres: ${_provider.selectedGenres.length}, Artists: ${_provider.selectedArtists.length}, Languages: ${_provider.selectedLanguages.length}, Vibes: ${_provider.selectedMoods.length}, Listening: ${_provider.selectedListeningPreferences.length})',
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: AnimatedBuilder(
          animation: _provider,
          builder: (context, _) {
            return Stack(
              children: [
                // Scrollable Body
                Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: AppDimensions.screenPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PreferenceHeader(),
                        const SizedBox(height: AppDimensions.largeSpacing),

                        // 2. Favourite Genres
                        PreferenceSection(
                          title: 'Choose your favorite genres',
                          indicatorColor: AppColors.primaryPurple,
                          child: Wrap(
                            spacing: AppDimensions.smallSpacing,
                            runSpacing: 10,
                            children: _provider.availableGenres.map((genre) {
                              final isSelected =
                              _provider.selectedGenres.contains(genre);
                              return PreferenceChip(
                                label: genre,
                                isSelected: isSelected,
                                onTap: () => _provider.toggleGenre(genre),
                              );
                            }).toList(),
                          ),
                        ),

                        // 3. Favourite Artists
                        ArtistSelectionSection(
                          artists: _provider.filteredArtists,
                          selectedArtists: _provider.selectedArtists,
                          searchController: _searchController,
                          onArtistToggled: _provider.toggleArtist,
                          onSearchCleared: _provider.clearArtistSearch,
                          artistImages: _provider.artistImages,
                        ),

                        // 4. Preferred Languages
                        PreferenceSection(
                          title: 'What languages do you listen to?',
                          indicatorColor: AppColors.accentCyan,
                          child: Wrap(
                            spacing: AppDimensions.smallSpacing,
                            runSpacing: 10,
                            children: _provider.availableLanguages.map((language) {
                              final isSelected =
                              _provider.selectedLanguages.contains(language);
                              return PreferenceChip(
                                label: language,
                                isSelected: isSelected,
                                onTap: () => _provider.toggleLanguage(language),
                              );
                            }).toList(),
                          ),
                        ),

                        // 5. Music Moods / Vibes
                        PreferenceSection(
                          title: 'What’s your vibe?',
                          indicatorColor: AppColors.accentCoral,
                          child: Wrap(
                            spacing: AppDimensions.smallSpacing,
                            runSpacing: 10,
                            children: _provider.availableMoods.map((mood) {
                              final isSelected =
                              _provider.selectedMoods.contains(mood);
                              return PreferenceChip(
                                label: mood,
                                isSelected: isSelected,
                                onTap: () => _provider.toggleMood(mood),
                              );
                            }).toList(),
                          ),
                        ),

                        // 6. Listening Preferences
                        PreferenceSection(
                          title: 'Listening preferences',
                          indicatorColor: AppColors.primaryPurple,
                          child: Wrap(
                            spacing: AppDimensions.smallSpacing,
                            runSpacing: 10,
                            children: _provider.availableListeningPreferences
                                .map((pref) {
                              final isSelected = _provider
                                  .selectedListeningPreferences
                                  .contains(pref);
                              return PreferenceChip(
                                label: pref,
                                isSelected: isSelected,
                                onTap: () =>
                                    _provider.toggleListeningPreference(pref),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 7. Fixed Bottom Action Bar
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: PreferenceBottomBar(
                    onContinue: _onContinuePressed,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
