import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Header component for VIVA registration screen.
///
/// Top Horizontal Header:
/// - Left side: "VIVA" brand text (bold white) + "Find your sound. Find your people." tagline (muted lavender)
/// - Right side: Soundwave asset image (`assets/images/placeholders/soundwave.png`)
///
/// Welcome Section:
/// - Heading: "Join the VIVA community"
/// - Subtitle: "Discover music that feels like you."
class VivaHeader extends StatelessWidget {
  const VivaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Horizontal Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Side: VIVA Brand & Tagline
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // VIVA Brand Name
                const Text(
                  'VIVA',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryText,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 2),
                // Tagline
                Text(
                  'Find your sound. Find your people.',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),

            // Right Side: Soundwave Image Asset
            Container(
              height: 48,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondaryBackground,
                border: Border.all(color: AppColors.inputBorder, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.asset(
                  'assets/images/logo/soundwave.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.graphic_eq_rounded,
                        color: AppColors.cyanAccent,
                        size: 26,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Welcome Section Heading & Subtitle
        const Text(
          'Join the VIVA community',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Discover music that feels like you.',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
