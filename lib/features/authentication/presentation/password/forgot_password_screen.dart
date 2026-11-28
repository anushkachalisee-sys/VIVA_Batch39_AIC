import 'package:flutter/material.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../shared/enums/auth_role.dart';
import 'widgets/password_recovery_header.dart';
import 'widgets/password_recovery_illustration.dart';

/// Screen 1: Forgot Password Screen
///
/// Features:
/// - Back navigation arrow & centered VIVA logo
/// - Ethereal envelope with lock badge illustration
/// - Heading: "Forgot Password?" & description
/// - "Email Address" label & email input field with email icon
/// - Email validation (empty field + regex format)
/// - Loading state on submission
/// - "Send Reset Link →" gradient button
/// - "Remember your password? Back to Login" navigation link
/// - Preserves originating [AuthRole] to return to the proper login screen
class ForgotPasswordScreen extends StatefulWidget {
  final AuthRole role;

  const ForgotPasswordScreen({
    super.key,
    this.role = AuthRole.listener,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  /// Resolves the effective [AuthRole], checking constructor or route arguments.
  AuthRole _getEffectiveRole() {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs is AuthRole) {
      return routeArgs;
    }
    return widget.role;
  }

  /// Handles form validation, loading state, and transitions to Check Your Inbox.
  void _handleSendResetLink() {
    // Dismiss the keyboard
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulated frontend validation & loading delay
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });

        final role = _getEffectiveRole();
        final email = _emailController.text.trim();

        // Navigate to Screen 2 (Check Your Inbox), passing role and email
        Navigator.pushNamed(
          context,
          AppRoutes.checkYourInbox,
          arguments: {
            'role': role,
            'email': email,
          },
        );
      });
    }
  }

  /// Returns to the originating login screen.
  void _handleBackToLogin() {
    final role = _getEffectiveRole();
    final targetRoute = role == AuthRole.artist
        ? AppRoutes.artistLogin
        : AppRoutes.userLogin;

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed(targetRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Bar with Back Arrow and Centered VIVA Logo
                PasswordRecoveryHeader(
                  onBack: _handleBackToLogin,
                ),

                const SizedBox(height: 28),

                // 2. Cosmic Envelope & Lock Illustration
                const PasswordRecoveryIllustration(
                  type: RecoveryIllustrationType.lock,
                ),

                const SizedBox(height: 28),

                // 3. Screen Heading
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 8),

                // 4. Description Text
                const Text(
                  'No worries! Enter your email address and we\'ll help you reset your password.',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 28),

                // 5. Email Input Label & Text Field
                const Text(
                  'Email Address',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Enter your email address',
                  controller: _emailController,
                  prefixIcon: const Icon(
                    Icons.mail_outline_rounded,
                    color: AppColors.secondaryText,
                    size: 20,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleSendResetLink(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // 6. "Send Reset Link →" Gradient Action Button
                GradientButton(
                  text: 'Send Reset Link',
                  borderRadius: BorderRadius.circular(16),
                  icon: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: AppColors.primaryText,
                  ),
                  isLoading: _isLoading,
                  onPressed: _handleSendResetLink,
                ),

                const SizedBox(height: 36),

                // 7. Footer: "Remember your password? Back to Login"
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Remember your password?',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _handleBackToLogin,
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            color: AppColors.accentCyan,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
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
      ),
    );
  }
}
