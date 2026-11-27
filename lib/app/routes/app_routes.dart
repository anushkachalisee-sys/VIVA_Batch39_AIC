import 'package:flutter/material.dart';
import '../../features/authentication/presentation/listener/user_login_page.dart';
import '../../features/authentication/presentation/artist/artist_login_page.dart';
import '../../features/artist_profile/presentation/artist_profile_setup_screen.dart';
import '../../features/profile/presentation/listener/pages/edit_profile_screen.dart';

/// Navigation routes for VIVA.
class AppRoutes {
  static const String userLogin = '/user-login';
  static const String artistLogin = '/artist-login';
  static const String artistProfileSetup = '/artist-profile-setup';
  static const String editProfile = '/edit-profile';

  static Map<String, WidgetBuilder> get routes => {
        userLogin: (context) => const UserLoginPage(),
        artistLogin: (context) => const ArtistLoginPage(),
        artistProfileSetup: (context) => const ArtistProfileSetupScreen(),
        editProfile: (context) => const EditProfileScreen(),
      };
}
