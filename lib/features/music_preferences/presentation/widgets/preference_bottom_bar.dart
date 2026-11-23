import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_button.dart';

/// Fixed bottom action bar containing the primary GradientButton and helper caption.
class PreferenceBottomBar extends StatelessWidget {
  final VoidCallback onContinue;
  final bool isLoading;
  final String buttonText;
  final String captionText;

  const PreferenceBottomBar({
    super.key,
    required this.onContinue,
    this.isLoading = false,
    this.buttonText = 'Continue →',
    this.captionText = 'You can change your choices anytime.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.horizontalScreenPadding,
        12.0,
        AppDimensions.horizontalScreenPadding,
        16.0,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.bottomBarGradient,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientButton(
              text: buttonText,
              onPressed: onContinue,
              isLoading: isLoading,
            ),
            const SizedBox(height: 10),
            Text(
              captionText,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
}
