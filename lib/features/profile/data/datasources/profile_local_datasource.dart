import '../../domain/entities/listener_profile.dart';

abstract class ProfileLocalDataSource {
  Future<ListenerProfile> getProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ListenerProfile> getProfile() async {
    return const ListenerProfile(
      displayName: 'Anushka',
      username: '@anushka',
      bio: 'Music lover • Concert explorer',
      avatarUrl: 'assets/images/placeholders/avatar.png',
      followersCount: '12.8K',
      followingCount: '640',
      matchesPercentage: '86%',
      genreTaste: ['Alt Pop', 'Indie', 'R&B'],
      artistTaste: ['Luna Rae', 'Aarya K'],
      languageTaste: ['English', 'Hindi'],
      topArtists: [
        TopArtistEntity(
          name: 'Mira Vale',
          genre: 'Alt pop',
          imageUrl: 'assets/images/artists/mira_vale.png',
        ),
        TopArtistEntity(
          name: 'Nox',
          genre: 'Indie',
          imageUrl: 'assets/images/artists/nox.png',
        ),
        TopArtistEntity(
          name: 'Luna Rae',
          genre: 'Dream pop',
          imageUrl: 'assets/images/artists/luna_rae.png',
        ),
      ],
      selectedMoods: ['Chill', 'Happy', 'Late Night'],
      activeMood: 'Chill',
      achievements: [
        AchievementEntity(title: 'Music Explorer', type: 'explorer'),
        AchievementEntity(title: 'Music Twin', type: 'twin'),
      ],
      communities: [
        CommunityEntity(name: 'Luna Lounge', membersCount: '24.8K fans', type: 'lounge'),
        CommunityEntity(name: 'Indie India', membersCount: '8.2K members', type: 'indie'),
      ],
      upcomingEvents: [
        EventEntity(
          title: 'Electric Hearts Tour',
          month: 'OCT',
          day: '18',
          location: 'Oct 18 · Phoenix Marketcity',
          status: 'INTERESTED',
          imageUrl: 'assets/images/backgrounds/electric_hearts.png',
        ),
      ],
    );
  }
}
