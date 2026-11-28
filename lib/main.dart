import 'package:flutter/material.dart';
import 'package:viva/features/authentication/presentation/artist/artist_login_page.dart';
import 'package:viva/features/authentication/presentation/listener/user_login_page.dart';
import 'package:viva/features/authentication/presentation/password/forgot_password_screen.dart';
import 'package:viva/features/music_preferences/presentation/music_preferences_screen.dart';
import 'package:viva/features/profile/presentation/listener/pages/listener_profile_page.dart';
import 'package:viva/features/search/presentation/search_screen.dart';
import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'features/authentication/presentation/artist/artist_registration_screen.dart';
import 'features/authentication/presentation/listener/registration_screen.dart';

void main() {
  runApp(const VivaApp());
}

class VivaApp extends StatelessWidget {
  const VivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIVA – Feel the Music',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routes: AppRoutes.routes,
      home: const ForgotPasswordScreen(),
    );
  }
}
