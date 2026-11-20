import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_dropdown_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/gradient_button.dart';
import 'artist_terms_checkbox_widget.dart';
import 'artist_viva_header.dart';

/// Artist Registration Screen for VIVA - Feel the Music.
///
/// Features:
/// - Dark music app aesthetic (#0D0D1B background, purple/pink gradients, cyan accents)
/// - Top header with VIVA branding, "FOR ARTISTS" badge, heading & soundwave visual asset
/// - Artist Name / Stage Name, Official Email Address, Password, Confirm Password fields
/// - Music Genre & Artist Type side-by-side dropdown fields
/// - Optional Short Bio multiline field with character count
/// - Interactive Terms of Service & Artist Guidelines agreement checkbox
/// - Full-width "Create Artist Account →" gradient button with local validation
/// - Artist profile verification informational notice
/// - "Already have an artist account? Log In" bottom navigation link
class ArtistRegistrationScreen extends StatefulWidget {
  const ArtistRegistrationScreen({super.key});

  @override
  State<ArtistRegistrationScreen> createState() => _ArtistRegistrationScreenState();
}

class _ArtistRegistrationScreenState extends State<ArtistRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text Editing Controllers
  final TextEditingController _artistNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Selected Dropdown values
  String? _selectedGenre;
  String? _selectedArtistType;

  // Password visibility flags
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Terms & Guidelines agreement state
  bool _agreeToTerms = false;
  bool _showTermsError = false;

  // Dropdown options
  static const List<String> _genreOptions = [
    'Pop',
    'Rock',
    'Hip-Hop / Rap',
    'R&B',
    'Classical',
    'Folk / Traditional',
    'Electronic',
    'Jazz',
    'Indie',
    'Alternative',
    'Bollywood',
    'Other',
  ];

  static const List<String> _artistTypeOptions = [
    'Solo Artist',
    'Band',
    'Music Producer',
    'Singer',
    'Rapper',
    'DJ',
    'Instrumentalist',
    'Composer',
    'Other',
  ];

  @override
  void dispose() {
    _artistNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  /// Validates and submits the Artist Registration form locally.
  void _handleArtistRegistration() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final isGenreValid = _selectedGenre != null && _selectedGenre!.isNotEmpty;
    final isArtistTypeValid = _selectedArtistType != null && _selectedArtistType!.isNotEmpty;

    setState(() {
      _showTermsError = !_agreeToTerms;
    });

    if (isFormValid && isGenreValid && isArtistTypeValid && _agreeToTerms) {
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
                  'Artist registration form completed successfully!',
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
      // Show Validation Error SnackBar
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

  void _showArtistLoginSnackBar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Artist Login page coming soon.',
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
          // Background Ambient Radial Glow
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

          // Responsive Scrollable View
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Header: VIVA Logo, FOR ARTISTS Badge, Heading, Subtitle & Soundwave
                  const ArtistVivaHeader(),

                  const SizedBox(height: 28),

                  // 2. Artist Registration Form Fields
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // A. Artist Name / Stage Name
                        CustomTextField(
                          labelText: 'Artist Name / Stage Name',
                          hintText: 'What should your fans call you?',
                          controller: _artistNameController,
                          prefixIcon: const Icon(
                            Icons.mic_none_rounded,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Artist Name / Stage Name is required';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // B. Official Email Address
                        CustomTextField(
                          labelText: 'Official Email Address',
                          hintText: 'you@yourmusic.com',
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
                              return 'Official Email Address is required';
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

                        const SizedBox(height: 12),

                        // C. Password
                        CustomTextField(
                          labelText: 'Password',
                          hintText: 'Create a strong password',
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
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),

                        // D. Confirm Password
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
                          textInputAction: TextInputAction.next,
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

                        const SizedBox(height: 12),

                        // E & F. Side-by-side Dropdowns: Music Genre & Artist Type
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth > 320) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // E. Music Genre Dropdown
                                  Expanded(
                                    child: CustomDropdownField(
                                      label: 'Music Genre',
                                      hintText: 'Select genre',
                                      value: _selectedGenre,
                                      items: _genreOptions,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedGenre = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select genre';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // F. Artist Type Dropdown
                                  Expanded(
                                    child: CustomDropdownField(
                                      label: 'Artist Type',
                                      hintText: 'Select type',
                                      value: _selectedArtistType,
                                      items: _artistTypeOptions,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _selectedArtistType = newValue;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Select type';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Stack vertically for very small devices
                              return Column(
                                children: [
                                  CustomDropdownField(
                                    label: 'Music Genre',
                                    hintText: 'Select genre',
                                    value: _selectedGenre,
                                    items: _genreOptions,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedGenre = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select genre';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  CustomDropdownField(
                                    label: 'Artist Type',
                                    hintText: 'Select type',
                                    value: _selectedArtistType,
                                    items: _artistTypeOptions,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedArtistType = newValue;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Select type';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        ),

                        const SizedBox(height: 12),

                        // G. Short Bio (Optional)
                        CustomTextField(
                          labelText: 'Short Bio (optional)',
                          hintText: 'Tell us a little about your sound...',
                          controller: _bioController,
                          prefixIcon: const Icon(
                            Icons.edit_note_rounded,
                            color: AppColors.secondaryText,
                            size: 22,
                          ),
                          maxLines: 2,
                          minLines: 2,
                          maxLength: 250,
                          textInputAction: TextInputAction.done,
                        ),

                        const SizedBox(height: 16),

                        // H. Terms of Service and Artist Guidelines Checkbox
                        ArtistTermsCheckboxWidget(
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

                        const SizedBox(height: 20),

                        // I. Create Account Button
                        GradientButton(
                          text: 'CREATE ACCOUNT',
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.cyanAccent,
                              Color(0xFF0096C7),
                            ],
                          ),
                          onPressed: _handleArtistRegistration,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 3. Artist Verification Information Text
                  const Text(
                    'Your artist profile may require verification before publication.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 22),

                  // 4. Artist Login Navigation ("Already have an account? Sign In")
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
                        onTap: _showArtistLoginSnackBar,
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.cyanAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // 5. Toggle switch back to Listener Registration
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      },
                      icon: const Icon(
                        Icons.headphones_rounded,
                        size: 16,
                        color: AppColors.secondaryText,
                      ),
                      label: const Text(
                        'Register as a Listener instead',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
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
