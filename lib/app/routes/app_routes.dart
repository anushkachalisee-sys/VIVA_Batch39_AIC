import 'package:flutter/material.dart';
import '../../features/authentication/presentation/listener/user_login_page.dart';
import '../../features/authentication/presentation/artist/artist_login_page.dart';
import '../../features/mood/presentation/pages/mood_selection_page.dart';

/// Navigation routes for VIVA.
class AppRoutes {
  static const String userLogin = '/user-login';
  static const String artistLogin = '/artist-login';
  static const String moodSelection = '/mood-selection';

  static Map<String, WidgetBuilder> get routes => {
        userLogin: (context) => const UserLoginPage(),
        artistLogin: (context) => const ArtistLoginPage(),
        moodSelection: (context) => const MoodSelectionScreen(),
      };
}
