import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_colors.dart';
import '../../data/models/mood_model.dart';
import '../widgets/mood_info_card.dart';
import '../widgets/mood_playlist_card.dart';
import '../widgets/song_tile.dart';
import '../widgets/artist_card.dart';

class MoodRecommendationsScreen extends StatefulWidget {
  final Mood mood;

  const MoodRecommendationsScreen({
    super.key,
    required this.mood,
  });

  @override
  State<MoodRecommendationsScreen> createState() => _MoodRecommendationsScreenState();
}

class _MoodRecommendationsScreenState extends State<MoodRecommendationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Mood _currentMood;

  @override
  void initState() {
    super.initState();
    _currentMood = widget.mood;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppColors.primaryText),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.auto_awesome, color: AppColors.accentCyan, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Your mood',
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.tune_rounded, size: 22),
                    onPressed: () => _showSnackBar('Mood filter options'),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Heading & Subtitle
                    Text(
                      _currentMood.soundtrackHeading,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _currentMood.soundtrackSubtitle,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Selected Mood Info Card with Change Button
                    MoodInfoCard(
                      mood: _currentMood,
                      onChangePressed: () => Navigator.pop(context),
                    ),

                    const SizedBox(height: 20),

                    // Segmented Tab Bar (Songs | Artists)
                    Container(
                      height: 48,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.cardBorder, width: 1),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelColor: AppColors.primaryText,
                        unselectedLabelColor: AppColors.secondaryText,
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        tabs: const [
                          Tab(text: 'Songs'),
                          Tab(text: 'Artists'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tab Views Content Height Controlled via TabBarView inside Expanded or Builder
                    // Using LayoutBuilder or fixed height wrapper for nested scroll
                    SizedBox(
                      height: 700,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // SONGS TAB CONTENT
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MoodPlaylistCard(
                                  playlist: _currentMood.playlist,
                                  onPlayPressed: () {
                                    _showSnackBar(
                                      'Playing "${_currentMood.playlist.title}" mix 🎵',
                                    );
                                  },
                                ),

                                const SizedBox(height: 24),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Songs for your mood',
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${_currentMood.songs.length * 28} matches',
                                      style: const TextStyle(
                                        color: AppColors.accentCyan,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _currentMood.songs.length,
                                  itemBuilder: (context, index) {
                                    final song = _currentMood.songs[index];
                                    return SongTile(
                                      song: song,
                                      onFavouriteToggle: () {
                                        setState(() {
                                          song.isFavourite = !song.isFavourite;
                                        });
                                        _showSnackBar(
                                          song.isFavourite
                                              ? 'Added to favourites ❤️'
                                              : 'Removed from favourites',
                                        );
                                      },
                                      onTap: () {
                                        _showSnackBar('Now playing: ${song.title}');
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // ARTISTS TAB CONTENT
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_currentMood.artists.isNotEmpty)
                                  ArtistCard(
                                    artist: _currentMood.artists.first,
                                    isFeatured: true,
                                    onFollowToggle: () {
                                      setState(() {
                                        _currentMood.artists.first.isFollowing =
                                            !_currentMood.artists.first.isFollowing;
                                      });
                                      _showSnackBar(
                                        _currentMood.artists.first.isFollowing
                                            ? 'Following ${_currentMood.artists.first.name}'
                                            : 'Unfollowed ${_currentMood.artists.first.name}',
                                      );
                                    },
                                  ),

                                const SizedBox(height: 24),

                                const Text(
                                  'More artists for your mood',
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),

                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _currentMood.artists.length > 1
                                      ? _currentMood.artists.length - 1
                                      : 0,
                                  itemBuilder: (context, index) {
                                    final artist = _currentMood.artists[index + 1];
                                    return ArtistCard(
                                      artist: artist,
                                      isFeatured: false,
                                      onFollowToggle: () {
                                        setState(() {
                                          artist.isFollowing = !artist.isFollowing;
                                        });
                                        _showSnackBar(
                                          artist.isFollowing
                                              ? 'Following ${artist.name}'
                                              : 'Unfollowed ${artist.name}',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
