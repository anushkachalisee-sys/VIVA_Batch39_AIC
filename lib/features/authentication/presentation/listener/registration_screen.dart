import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/google_sign_in_button.dart';
import '../../../../core/widgets/gradient_button.dart';
import 'password_requirements_widget.dart';
import 'terms_checkbox_widget.dart';
import 'viva_header.dart';

/// User/Listener Registration Screen for VIVA - Feel the Music.
///
/// Features:
/// - Clean dark music app aesthetic (#0D0D1B background, purple/pink gradients, cyan accents)
/// - Top horizontal header with VIVA branding and soundwave image asset
/// - 5 registration input fields with icons & validation (No password requirements box)
/// - Confirm Password field immediately following Password
/// - Password visibility toggles
/// - Interactive Terms of Service & Privacy Policy agreement
/// - Gradient "Create Account →" button with full local form validation
/// - Google sign-up section with "or sign up with" divider
/// - "Already have an account? Log In" bottom navigation
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Obscure password flags
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Terms agreement state
  bool _agreeToTerms = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Triggered when tapping "Create Account →"
  void _handleRegistration() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final isPasswordRequirementsMet = PasswordRequirementsWidget.isPasswordValid(_passwordController.text);

    setState(() {
      _showTermsError = !_agreeToTerms;
    });

    if (isFormValid && isPasswordRequirementsMet && _agreeToTerms) {
      // Dismiss soft keyboard
      FocusScope.of(context).unfocus();

      // Show Success SnackBar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle_rounded, color: AppColors.cyanAccent),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Registration form completed successfully!',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.secondaryBackground,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.purpleAccent, width: 1.2),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    } else {
      // Show validation error SnackBar
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline_rounded, color: AppColors.errorText),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Please fix the highlighted errors before proceeding.',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.secondaryBackground,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: AppColors.errorText, width: 1.2),
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showLoginSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Login page coming soon.',
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackground,
      body: Stack(
        children: [
          // Background Glow Accents
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.purpleAccent.withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.pinkAccent.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Responsive Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1-3. Header, Logo, Tagline, Heading & Subtitle
                  const VivaHeader(),

                  const SizedBox(height: 28),

                  // 4-9. Registration Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 4. Full Name
                        CustomTextField(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          controller: _fullNameController,
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        // 5. Username
                        CustomTextField(
                          labelText: 'Username',
                          hintText: 'Choose a username',
                          controller: _usernameController,
                          prefixIcon: const Text(
                            '@',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Username is required';
                            }
                            if (value.trim().length < 3) {
                              return 'Username must be at least 3 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        // 6. Email Address
                        CustomTextField(
                          labelText: 'Email Address',
                          hintText: 'Enter your email address',
                          controller: _emailController,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email address is required';
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

                        const SizedBox(height: 18),

                        // 7. Password
                        CustomTextField(
                          labelText: 'Password',
                          hintText: 'Create a password',
                          controller: _passwordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.secondaryText,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (!PasswordRequirementsWidget.isPasswordValid(value)) {
                              return 'Password must be at least 8 chars, with uppercase, number & special char';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        // 8. Confirm Password (Immediately following Password field)
                        CustomTextField(
                          labelText: 'Confirm Password',
                          hintText: 'Re-enter your password',
                          controller: _confirmPasswordController,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          obscureText: _obscureConfirmPassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.secondaryText,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 22),

                        // 9. Terms and Conditions Checkbox
                        TermsCheckboxWidget(
                          value: _agreeToTerms,
                          showError: _showTermsError,
                          onChanged: (newValue) {
                            setState(() {
                              _agreeToTerms = newValue ?? false;
                              if (_agreeToTerms) {
                                _showTermsError = false;
                              }
                            });
                          },
                        ),

                        const SizedBox(height: 26),

                        // 10. Create Account Primary Button
                        GradientButton(
                          text: 'Create Account',
                          onPressed: _handleRegistration,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 11-12. "or sign up with" divider & Google Sign-Up Button
                  const GoogleSignInSection(),

                  const SizedBox(height: 28),

                  // 13. "Already have an account? Log In" Navigation Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showLoginSnackBar,
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: AppColors.cyanAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 14. "Are you an artist? Register here" Navigation Link
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/artist-registration');
                      },
                      icon: const Icon(
                        Icons.mic_rounded,
                        size: 16,
                        color: AppColors.cyanAccent,
                      ),
                      label: const Text(
                        'Are you an artist? Register here',
                        style: TextStyle(
                          color: AppColors.cyanAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
