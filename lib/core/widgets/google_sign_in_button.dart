import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Google Sign-Up Divider & Action Button Widget for VIVA.
///
/// Includes:
/// 1. Thin horizontal divider lines with "or sign up with" text
/// 2. Dark button (#19192F) with thin border (#363653) and 4-color Google G icon
class GoogleSignInSection extends StatelessWidget {
  const GoogleSignInSection({super.key});

  void _handleGoogleSignUp(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Google Sign Up will be available soon.',
          style: TextStyle(
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
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with Text: "or sign up with"
        Row(
          children: const [
            Expanded(
              child: Divider(
                color: AppColors.inputBorder,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'or sign up with',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.inputBorder,
                thickness: 1,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Google Sign-Up Button
        SizedBox(
          width: double.infinity,
          height: 52,
          child: OutlinedButton(
            onPressed: () => _handleGoogleSignUp(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.inputBackground,
              side: const BorderSide(color: AppColors.inputBorder, width: 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Custom Crisp Google 'G' Logo
                const _GoogleGLogo(size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Sign up with Google',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Renders the Google logo from asset image.
class _GoogleGLogo extends StatelessWidget {
  final double size;

  const _GoogleGLogo({this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/logo/googlelogo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.g_mobiledata_rounded,
              color: AppColors.primaryText,
              size: size + 4,
            ),
          );
        },
      ),
    );
  }
}
