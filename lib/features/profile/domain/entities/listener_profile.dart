class ListenerProfile {
  final String displayName;
  final String username;
  final String bio;
  final String avatarUrl;
  final String followersCount;
  final String followingCount;
  final String matchesPercentage;
  final List<String> genreTaste;
  final List<String> artistTaste;
  final List<String> languageTaste;
  final List<TopArtistEntity> topArtists;
  final List<String> selectedMoods;
  final String activeMood;
  final List<AchievementEntity> achievements;
  final List<CommunityEntity> communities;
  final List<EventEntity> upcomingEvents;

  const ListenerProfile({
    required this.displayName,
    required this.username,
    required this.bio,
    required this.avatarUrl,
    required this.followersCount,
    required this.followingCount,
    required this.matchesPercentage,
    required this.genreTaste,
    required this.artistTaste,
    required this.languageTaste,
    required this.topArtists,
    required this.selectedMoods,
    required this.activeMood,
    required this.achievements,
    required this.communities,
    required this.upcomingEvents,
  });
}

class TopArtistEntity {
  final String name;
  final String genre;
  final String imageUrl;

  const TopArtistEntity({
    required this.name,
    required this.genre,
    required this.imageUrl,
  });
}

class AchievementEntity {
  final String title;
  final String type; // e.g. 'explorer', 'twin'

  const AchievementEntity({
    required this.title,
    required this.type,
  });
}

class CommunityEntity {
  final String name;
  final String membersCount;
  final String type; // e.g. 'fans', 'members'

  const CommunityEntity({
    required this.name,
    required this.membersCount,
    required this.type,
  });
}

class EventEntity {
  final String title;
  final String month;
  final String day;
  final String location;
  final String status;
  final String imageUrl;

  const EventEntity({
    required this.title,
    required this.month,
    required this.day,
    required this.location,
    required this.status,
    required this.imageUrl,
  });
}
