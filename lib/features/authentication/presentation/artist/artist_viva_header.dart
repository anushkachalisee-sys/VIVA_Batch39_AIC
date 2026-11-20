import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Header component for VIVA Artist Registration screen.
///
/// Features:
/// - Top Row: "VIVA" brand title (bold white) + "FOR ARTISTS" cyan outlined badge
/// - Main Heading: "Bring Your Sound to VIVA"
/// - Supporting Subtitle: "Build your audience. Share your journey."
/// - Decorative soundwave asset (`assets/images/placeholders/soundwave.png`)
class ArtistVivaHeader extends StatelessWidget {
  const ArtistVivaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: VIVA Title & FOR ARTISTS Cyan Badge
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side: VIVA Brand Name
            const Text(
              'VIVA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryText,
                letterSpacing: 2.0,
              ),
            ),

            // Right Side: Outlined "FOR ARTISTS" Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.cyanAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cyanAccent.withValues(alpha: 0.7),
                  width: 1.2,
                ),
              ),
              child: const Text(
                'FOR ARTISTS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.cyanAccent,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Heading, Subtitle & Soundwave Asset Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bring Your Sound to VIVA',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryText,
                      height: 1.25,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Build your audience. Share your journey.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Soundwave Visual Asset
            SizedBox(
              height: 54,
              width: 90,
              child: Image.asset(
                'assets/images/logo/soundwave.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.graphic_eq_rounded,
                    color: AppColors.cyanAccent,
                    size: 36,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
