import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.
import 'package:viva/app/theme/app_text_styles.dart';
import 'package:viva/core/constants/app_assets.dart';
import 'package:viva/core/widgets/gradient_button.dart';
import 'package:viva/core/widgets/viva_logo.dart';
import 'package:viva/features/profile/presentation/listener/widgets/profile_bottom_navigation.dart';

/// Screen implementing US06: Lyrics-Based Search.
/// Allows users to search songs by entering lyrics, view match percentages,
/// lyric snippet previews with highlighted matching terms, and helpful tips.
class LyricsSearchScreen extends StatefulWidget {
  const LyricsSearchScreen({super.key});

  @override
  State<LyricsSearchScreen> createState() => _LyricsSearchScreenState();
}

class _LyricsSearchScreenState extends State<LyricsSearchScreen> {
  final TextEditingController _lyricsController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;
  int _currentNavIndex = 1; // Discover tab selected by default

  @override
  void initState() {
    super.initState();
    _lyricsController.text = 'dancing in the moonlight';
  }

  @override
  void dispose() {
    _lyricsController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final query = _lyricsController.text.trim();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter any lyrics you remember first.'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate search processing delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Found close matches for "$query"!'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentNavIndex = index;
    });
    if (index == 4) {
      // Profile tab navigation if desired or show snackbar
      Navigator.pop(context);
    } else if (index != 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Switched to tab ${index == 0 ? "Home" : index == 2 ? "Events" : "Community"}'),
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Navigation Icon
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryText,
                      size: 24,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),

                  // Center Title
                  const Text(
                    'Lyrics Search',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // VIVA Logo on the right
                  const VivaLogo(
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Heading & Music Note Icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Remember the\nlyrics? Find the song.',
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              height: 1.25,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Circular Music Note Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primaryPurple.withValues(alpha: 0.4),
                              width: 1.2,
                            ),
                          ),
                          child: const Icon(
                            Icons.music_note,
                            color: AppColors.accentCyan,
                            size: 26,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      "Type any lyrics you remember and we'll help you find it.",
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Lyrics Search Field
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.searchBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primaryPurple.withValues(alpha: 0.5),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPurple.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _lyricsController,
                        focusNode: _focusNode,
                        style: AppTextStyles.input,
                        maxLines: 3,
                        minLines: 1,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (_) => _handleSearch(),
                        decoration: InputDecoration(
                          hintText: 'Type lyrics you remember...',
                          hintStyle: AppTextStyles.hint,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 14, right: 10, top: 12, bottom: 12),
                            child: Icon(
                              Icons.search,
                              color: AppColors.accentCyan,
                              size: 22,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 12, top: 12, bottom: 12),
                            child: IconButton(
                              icon: const Icon(
                                Icons.mic_none_rounded,
                                color: AppColors.primaryPink,
                                size: 22,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Listening for voice lyrics...'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Find My Song Button
                    GradientButton(
                      text: 'Find My Song',
                      icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
                      isLoading: _isLoading,
                      onPressed: _handleSearch,
                    ),

                    const SizedBox(height: 12),

                    // Suggestion Text
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _lyricsController.text = 'dancing in the moonlight';
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: AppColors.primaryPink,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Try: 'dancing in the moonlight...'",
                            style: TextStyle(
                              color: AppColors.secondaryText.withValues(alpha: 0.9),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Possible Matches Header & Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Possible Matches',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accentCyan.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.accentCyan.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            '2 CLOSE HITS',
                            style: TextStyle(
                              color: AppColors.accentCyan,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Song Match Card 1: Midnight Dreams
                    _buildSongMatchCard(
                      context,
                      coverImagePath: 'assets/images/artists/lana_del_rey.jpg',
                      title: 'Midnight Dreams',
                      artist: 'Luna Rae',
                      matchPercent: '92%',
                      beforeSnippet: '...',
                      highlightedSnippet: 'dancing in the moonlight',
                      afterSnippet: '... hearts in the city glow',
                    ),

                    const SizedBox(height: 14),

                    // Song Match Card 2: Afterglow Avenue
                    _buildSongMatchCard(
                      context,
                      coverImagePath: 'assets/images/artists/the_weekend.jpg',
                      title: 'Afterglow Avenue',
                      artist: 'The Wild Hours',
                      matchPercent: '78%',
                      beforeSnippet: 'We were ',
                      highlightedSnippet: 'dancing in the moonlight',
                      afterSnippet: ', chasing the afterglow...',
                    ),

                    const SizedBox(height: 16),

                    // Help Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.cardBorder,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_fix_high,
                              color: AppColors.primaryPurple,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Can't find it?",
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Try using fewer words or a different lyric.',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.graphic_eq,
                            color: AppColors.accentCyan,
                            size: 24,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            ProfileBottomNavigation(
              selectedIndex: _currentNavIndex,
              onTabSelected: _onTabSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongMatchCard(
    BuildContext context, {
    required String coverImagePath,
    required String title,
    required String artist,
    required String matchPercent,
    required String beforeSnippet,
    required String highlightedSnippet,
    required String afterSnippet,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Selected "$title" by $artist'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        borderRadius: BorderRadius.circular(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Song Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                coverImagePath,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppAssets.soundwaveLogo,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            const SizedBox(width: 14),

            // Song Info & Lyrics Preview
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Match Badge Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primaryPurple.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          '$matchPercent lyric match',
                          style: const TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 2),

                  // Artist Name
                  Text(
                    artist,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Lyrics Snippet Preview with Highlighted Words
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                      children: [
                        TextSpan(text: beforeSnippet),
                        TextSpan(
                          text: highlightedSnippet,
                          style: const TextStyle(
                            color: AppColors.primaryPink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: afterSnippet),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Navigation / Arrow Action Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.unselectedChip,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.unselectedChipBorder,
                ),
              ),
              child: const Icon(
                Icons.north_east_rounded,
                color: AppColors.primaryText,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
