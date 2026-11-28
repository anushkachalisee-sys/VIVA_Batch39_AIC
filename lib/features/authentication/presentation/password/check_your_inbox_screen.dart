import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../shared/enums/auth_role.dart';
import 'widgets/password_recovery_header.dart';
import 'widgets/password_recovery_illustration.dart';

/// Screen 2: Check Your Inbox Screen
///
/// Features:
/// - Back navigation arrow & centered VIVA logo
/// - Ethereal envelope illustration with glowing cyan checkmark badge
/// - Heading: "Check Your Inbox"
/// - Explanatory description of the password reset link
/// - Gradient "Back to Login →" action button
/// - "Can't find the email?" section with spam folder guidance
/// - Clean navigation back to originating Login Screen (Listener or Artist)
class CheckYourInboxScreen extends StatelessWidget {
  final AuthRole role;
  final String? email;

  const CheckYourInboxScreen({
    super.key,
    this.role = AuthRole.listener,
    this.email,
  });

  /// Resolves the effective [AuthRole], checking constructor or route arguments.
  AuthRole _getEffectiveRole(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs is AuthRole) {
      return routeArgs;
    }
    if (routeArgs is Map && routeArgs['role'] is AuthRole) {
      return routeArgs['role'] as AuthRole;
    }
    return role;
  }

  /// Navigates back to the originating login screen (Listener or Artist).
  void _navigateToLogin(BuildContext context) {
    final effectiveRole = _getEffectiveRole(context);
    final targetRoute = effectiveRole == AuthRole.artist
        ? AppRoutes.artistLogin
        : AppRoutes.userLogin;

    Navigator.pushNamedAndRemoveUntil(
      context,
      targetRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar with Back Arrow and Centered VIVA Logo
              PasswordRecoveryHeader(
                onBack: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    _navigateToLogin(context);
                  }
                },
              ),

              const SizedBox(height: 28),

              // 2. Cosmic Envelope & Cyan Checkmark Illustration
              const PasswordRecoveryIllustration(
                type: RecoveryIllustrationType.successCheck,
              ),

              const SizedBox(height: 28),

              // 3. Screen Heading
              const Text(
                'Check Your Inbox',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 12),

              // 4. Description Text
              const Text(
                'If an account matches your email address, you\'ll receive a password reset link. Open the email and follow the link to choose a new password.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 36),

              // 5. "Back to Login →" Gradient Action Button
              GradientButton(
                text: 'Back to Login',
                borderRadius: BorderRadius.circular(16),
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: AppColors.primaryText,
                ),
                onPressed: () => _navigateToLogin(context),
              ),

              const SizedBox(height: 40),

              // 6. Footer: "Can't find the email? Check your spam or junk folder..."
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Can\'t find the email?',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check your spam or junk folder.',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'It may take a few minutes to arrive.',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
