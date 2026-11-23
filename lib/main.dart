import 'package:flutter/material.dart';
import 'core/constants/app_color.dart';
import 'features/profile/presentation/listener/pages/listener_profile_page.dart';

void main() {
  runApp(const VivaApp());
}

class VivaApp extends StatelessWidget {
  const VivaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIVA Music',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.mainBackground,
        primaryColor: AppColors.primaryPurple,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryPurple,
          secondary: AppColors.pinkAccent,
          tertiary: AppColors.cyanAccent,
          surface: AppColors.cardBackground,
        ),
        useMaterial3: true,
      ),
      home: const ListenerProfilePage(),
    );
  }
}
