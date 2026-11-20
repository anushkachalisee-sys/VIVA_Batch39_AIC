import 'package:flutter/material.dart';
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
      // Set initialRoute to '/artist-registration' to launch Artist Registration directly.
      initialRoute: '/artist-registration',
      routes: {
        '/': (context) => const RegistrationScreen(),
        '/artist-registration': (context) => const ArtistRegistrationScreen(),
      },
    );
  }
}
