import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Terms of Service and Privacy Policy agreement section.
///
/// Features:
/// - Interactive Checkbox (purple/cyan checked state, unchecked by default)
/// - Muted lavender text ("I agree to the ")
/// - Clickable Cyan text ("Terms of Service", "Privacy Policy") that display SnackBars
/// - Mandatory validation error indicator when unchecked upon submission
class TermsCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool showError;

  const TermsCheckboxWidget({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.purpleAccent,
                checkColor: AppColors.primaryText,
                side: BorderSide(
                  color: showError ? AppColors.errorText : AppColors.inputBorder,
                  width: showError ? 2.0 : 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: RichText(
                  text: TextSpan(
                    text: 'I agree to the ',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryText,
                      fontFamily: 'Roboto',
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Service',
                        style: const TextStyle(
                          color: AppColors.cyanAccent,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _showComingSoonSnackBar(
                                context,
                                'Terms of Service viewed.',
                              ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(
                          color: AppColors.cyanAccent,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _showComingSoonSnackBar(
                                context,
                                'Privacy Policy viewed.',
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (showError) ...[
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.only(left: 36.0),
            child: Text(
              'You must agree to the terms and privacy policy to continue',
              style: TextStyle(
                color: AppColors.errorText,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
