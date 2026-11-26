import 'package:flutter/material.dart';
import 'app/theme/app_theme.dart';
import 'app/routes/app_routes.dart';
import 'features/artist_profile/presentation/artist_profile_setup_screen.dart';
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
      // Launch Artist Profile Setup screen directly for US29 testing.
      initialRoute: AppRoutes.artistProfileSetup,
      routes: {
        ...AppRoutes.routes,
        '/': (context) => const RegistrationScreen(),
        '/artist-registration': (context) => const ArtistRegistrationScreen(),
        AppRoutes.artistProfileSetup: (context) => const ArtistProfileSetupScreen(),
      },
    );
  }
}
