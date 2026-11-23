import 'package:flutter/material.dart';
import 'package:viva/core/constants/app_color.dart';
import 'package:viva/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:viva/features/profile/data/repositories/profile_repository_impl.dart';
import '../providers/profile_provider.dart';
import '../widgets/achievements_section.dart';
import '../widgets/communities_section.dart';
import '../widgets/events_section.dart';
import '../widgets/music_mood_section.dart';
import '../widgets/music_taste_section.dart';
import '../widgets/profile_bottom_navigation.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/profile_stats_card.dart';
import '../widgets/top_artists_section.dart';

class ListenerProfilePage extends StatefulWidget {
  const ListenerProfilePage({super.key});

  @override
  State<ListenerProfilePage> createState() => _ListenerProfilePageState();
}

class _ListenerProfilePageState extends State<ListenerProfilePage> {
  late final ProfileProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = ProfileProvider(
      repository: ProfileRepositoryImpl(
        localDataSource: ProfileLocalDataSourceImpl(),
      ),
    );
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _provider,
          builder: (context, child) {
            if (_provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryPurple,
                ),
              );
            }

            final profile = _provider.profile;
            if (profile == null) {
              return const Center(
                child: Text(
                  'Profile failed to load',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              );
            }

            return Column(
              children: [
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A. App Header
                        ProfileHeader(
                          onBackTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          onSettingsTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Settings tapped'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),

                        // B. User Profile Information
                        ProfileInfoSection(
                          profile: profile,
                          onEditProfileTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Edit Profile tapped'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // C. Profile Statistics
                        ProfileStatsCard(
                          profile: profile,
                          onFollowersTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Followers tapped'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          onFollowingTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Following tapped'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // D. My Music Taste
                        MusicTasteSection(profile: profile),
                        const SizedBox(height: 12),

                        // E. Top Artists
                        TopArtistsSection(
                          profile: profile,
                          onArtistTap: (artist) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Artist: ${artist.name}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // F. Music Mood
                        MusicMoodSection(
                          activeMood: _provider.activeMood,
                          onMoodSelected: (mood) {
                            _provider.selectMood(mood);
                          },
                        ),
                        const SizedBox(height: 12),

                        // G. Achievements
                        AchievementsSection(profile: profile),
                        const SizedBox(height: 12),

                        // H. My Communities
                        CommunitiesSection(
                          profile: profile,
                          onCommunityTap: (community) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Community: ${community.name}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),

                        // I. My Events
                        EventsSection(
                          profile: profile,
                          onEventTap: (event) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Event: ${event.title}'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Fixed Bottom Navigation Bar
                ProfileBottomNavigation(
                  selectedIndex: _provider.currentNavIndex,
                  onTabSelected: (index) {
                    _provider.setNavIndex(index);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
