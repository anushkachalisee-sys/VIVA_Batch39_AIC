import 'package:flutter/material.dart';
import 'app/theme/app_theme.dart';
import 'features/lyrics/presentation/lyrics_search_screen.dart';

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
      home: const LyricsSearchScreen(),
    );
  }
}
