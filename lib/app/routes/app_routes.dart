import 'package:flutter/material.dart';
import '../../features/authentication/presentation/artist/artist_login_page.dart';
import '../../features/lyrics/presentation/lyrics_search_screen.dart';
import '../../features/authentication/presentation/listener/user_login_page.dart';
import '../../features/authentication/presentation/password/check_your_inbox_screen.dart';
import '../../features/authentication/presentation/password/forgot_password_screen.dart';
import '../../shared/enums/auth_role.dart';

/// Navigation routes for VIVA.
class AppRoutes {
  static const String userLogin = '/user-login';
  static const String artistLogin = '/artist-login';
  static const String lyricsSearch = '/lyrics-search';
  static const String forgotPassword = '/forgot-password';
  static const String checkYourInbox = '/check-your-inbox';

  static Map<String, WidgetBuilder> get routes => {
        userLogin: (context) => const UserLoginPage(),
        artistLogin: (context) => const ArtistLoginPage(),
        lyricsSearch: (context) => const LyricsSearchScreen(),
        forgotPassword: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final role = args is AuthRole ? args : AuthRole.listener;
          return ForgotPasswordScreen(role: role);
        },
        checkYourInbox: (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          final role = args is AuthRole
              ? args
              : (args is Map ? args['role'] as AuthRole? : null) ?? AuthRole.listener;
          final email = args is Map ? args['email'] as String? : null;
          return CheckYourInboxScreen(role: role, email: email);
        },
      };
}

