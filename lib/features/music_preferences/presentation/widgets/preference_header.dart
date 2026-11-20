import 'package:flutter/material.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/viva_logo.dart';

/// Header widget for the Music Preferences onboarding screen.
/// Displays the official VIVA logo and the welcome heading/subtitle.
/// The old '1 of 4' progress indicator has been removed per specifications.
class PreferenceHeader extends StatelessWidget {
  const PreferenceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Official VIVA Logo
        const VivaLogo(
          height: 36,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: AppDimensions.largeSpacing),

        // Welcome Heading
        const Text(
          'Let’s get to know your vibe 🎧',
          style: AppTextStyles.heading,
        ),
        const SizedBox(height: AppDimensions.smallSpacing),

        // Subtitle
        const Text(
          'Pick what you love so we can find music and people that match you.',
          style: AppTextStyles.subtitle,
        ),
      ],
    );
  }
}
