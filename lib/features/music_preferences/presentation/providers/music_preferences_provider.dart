import 'package:flutter/foundation.dart';

/// ViewModel managing state and business logic for the Music Preferences onboarding screen.
/// Follows Clean Architecture and separation of concerns without backend/Firebase ties.
class MusicPreferencesProvider extends ChangeNotifier {
  // 1. Genres
  final List<String> availableGenres = const [
    'Pop',
    'Hip-Hop',
    'R&B',
    'Rock',
    'Indie',
    'EDM',
    'K-Pop',
    'J-Pop',
    'Bollywood',
    'Nepali',
    'Classical',
    'Folk',
  ];
  final Set<String> _selectedGenres = {
    'Pop',
    'Hip-Hop',
    'Indie',
    'K-Pop',
    'Bollywood',
  };
  Set<String> get selectedGenres => Set.unmodifiable(_selectedGenres);

  // 2. Artists
  final List<String> availableArtists = const [
    'Lana Del Rey',
    'Ariana Grande',
    'Justin Bieber',
    'Daniel Caesar',
    'SZA',
    'The Weekend'
  ];
  final Set<String> _selectedArtists = {
    'Lana Del Rey',
    'Ariana Grande',
    'The Weekend',
  };
  Set<String> get selectedArtists => Set.unmodifiable(_selectedArtists);

  String _artistSearchQuery = '';
  String get artistSearchQuery => _artistSearchQuery;
  final Map<String, String> artistImages = const {
    'Lana Del Rey': 'assets/images/artists/lana_del_rey.jpg',
    'Ariana Grande': 'assets/images/artists/ariana_grande.jpg',
    'Justin Bieber': 'assets/images/artists/justin_bieber.jpg',
    'Daniel Caesar': 'assets/images/artists/daniel_caesar.jpg',
    'SZA': 'assets/images/artists/sza.jpg',
    'The Weekend': 'assets/images/artists/the_weekend.jpg',
  };


  // 3. Languages
  final List<String> availableLanguages = const [
    'English',
    'Nepali',
    'Hindi',
    'Korean',
    'Japanese',
    'Spanish',
    'Other',
  ];
  final Set<String> _selectedLanguages = {
    'English',
    'Nepali',
    'Hindi',
  };
  Set<String> get selectedLanguages => Set.unmodifiable(_selectedLanguages);

  // 4. Moods / Vibes
  final List<String> availableMoods = const [
    'Happy',
    'Chill',
    'Romantic',
    'Sad',
    'Energetic',
    'Late Night',
    'Study',
    'Workout',
    'Party',
    'Rainy Day',
  ];
  final Set<String> _selectedMoods = {
    'Happy',
    'Chill',
    'Energetic',
    'Late Night',
  };
  Set<String> get selectedMoods => Set.unmodifiable(_selectedMoods);

  // 5. Listening Preferences
  final List<String> availableListeningPreferences = const [
    'Headphones / Hi-Res',
    'Background',
    'Lyrics Focused',
    'Discovery',
    'Concerts / Live',
    'Instrumental',
    'Bass Boosted',
  ];
  final Set<String> _selectedListeningPreferences = {
    'Headphones / Hi-Res',
    'Discovery',
  };
  Set<String> get selectedListeningPreferences =>
      Set.unmodifiable(_selectedListeningPreferences);

  // Filtered Artists based on search query
  List<String> get filteredArtists {
    if (_artistSearchQuery.isEmpty) {
      return availableArtists;
    }
    return availableArtists
        .where((artist) =>
        artist.toLowerCase().contains(_artistSearchQuery.toLowerCase()))
        .toList();
  }

  // Total selected count across all categories
  int get totalSelections =>
      _selectedGenres.length +
          _selectedArtists.length +
          _selectedLanguages.length +
          _selectedMoods.length +
          _selectedListeningPreferences.length;

  // Toggle Methods
  void toggleGenre(String genre) {
    if (_selectedGenres.contains(genre)) {
      _selectedGenres.remove(genre);
    } else {
      _selectedGenres.add(genre);
    }
    notifyListeners();
  }

  void toggleArtist(String artist) {
    if (_selectedArtists.contains(artist)) {
      _selectedArtists.remove(artist);
    } else {
      _selectedArtists.add(artist);
    }
    notifyListeners();
  }

  void toggleLanguage(String language) {
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
    } else {
      _selectedLanguages.add(language);
    }
    notifyListeners();
  }

  void toggleMood(String mood) {
    if (_selectedMoods.contains(mood)) {
      _selectedMoods.remove(mood);
    } else {
      _selectedMoods.add(mood);
    }
    notifyListeners();
  }

  void toggleListeningPreference(String preference) {
    if (_selectedListeningPreferences.contains(preference)) {
      _selectedListeningPreferences.remove(preference);
    } else {
      _selectedListeningPreferences.add(preference);
    }
    notifyListeners();
  }

  void setArtistSearchQuery(String query) {
    _artistSearchQuery = query.trim();
    notifyListeners();
  }

  void clearArtistSearch() {
    _artistSearchQuery = '';
    notifyListeners();
  }
}
