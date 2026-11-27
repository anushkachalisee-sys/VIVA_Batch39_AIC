import 'package:flutter/material.dart';
import '../../features/authentication/presentation/listener/user_login_page.dart';
import '../../features/authentication/presentation/artist/artist_login_page.dart';
import '../../features/lyrics/presentation/lyrics_search_screen.dart';

/// Navigation routes for VIVA.
class AppRoutes {
  static const String userLogin = '/user-login';
  static const String artistLogin = '/artist-login';
  static const String lyricsSearch = '/lyrics-search';

  static Map<String, WidgetBuilder> get routes => {
        userLogin: (context) => const UserLoginPage(),
        artistLogin: (context) => const ArtistLoginPage(),
        lyricsSearch: (context) => const LyricsSearchScreen(),
      };
}
