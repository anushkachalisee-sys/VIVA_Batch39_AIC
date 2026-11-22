import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Terms of Service and Artist Guidelines agreement section for Artist Registration.
///
/// Features:
/// - Interactive Checkbox (purple checked state, unchecked by default)
/// - Muted lavender text ("I agree to the ")
/// - Clickable Cyan text ("Terms of Service", "Artist Guidelines") that display SnackBars
/// - Mandatory validation error indicator when unchecked upon submission
class ArtistTermsCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool showError;

  const ArtistTermsCheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.showError = false,
  });

  void _showComingSoonSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 14,
          ),
        ),
        backgroundColor: AppColors.secondaryBackground,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.inputBorder),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.purpleAccent,
                checkColor: AppColors.primaryText,
                side: BorderSide(
                  color: showError ? AppColors.errorText : AppColors.inputBorder,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                    height: 1.4,
                  ),
                  children: [
                    const TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: const TextStyle(
                        color: AppColors.cyanAccent,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showComingSoonSnackBar(
                            context,
                            'Terms of Service page coming soon.',
                          );
                        },
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Artist Guidelines',
                      style: const TextStyle(
                        color: AppColors.cyanAccent,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _showComingSoonSnackBar(
                            context,
                            'Artist Guidelines page coming soon.',
                          );
                        },
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (showError)
          const Padding(
            padding: EdgeInsets.only(left: 36, top: 6),
            child: Text(
              'Please accept the Terms of Service and Artist Guidelines to continue',
              style: TextStyle(
                color: AppColors.errorText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
