import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';

/// Password requirement model.
class PasswordRequirement {
  final String label;
  final bool isSatisfied;

  const PasswordRequirement({
    required this.label,
    required this.isSatisfied,
  });
}

/// Visual real-time indicator for password strength requirements.
///
/// Rules checked:
/// - Minimum 8 characters
/// - At least one uppercase letter (A-Z)
/// - At least one number (0-9)
/// - At least one special character (!@#$%...)
///
/// Styling:
/// - Unsatisfied: muted lavender (#AAA8C4)
/// - Satisfied: bright cyan (#20D9F2)
class PasswordRequirementsWidget extends StatelessWidget {
  final String password;

  const PasswordRequirementsWidget({
    super.key,
    required this.password,
  });

  /// Static helper to validate password against all criteria
  static bool isPasswordValid(String password) {
    final hasMinLength = password.length >= 8;
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'''[!@#\$%\^&\*(),.?":{}|<>\-_=+~`[\]\\/;\']'''));

    return hasMinLength && hasUppercase && hasNumber && hasSpecial;
  }

  @override
  Widget build(BuildContext context) {
    final requirements = [
      PasswordRequirement(
        label: 'At least 8 characters',
        isSatisfied: password.length >= 8,
      ),
      PasswordRequirement(
        label: 'At least one uppercase letter (A-Z)',
        isSatisfied: password.contains(RegExp(r'[A-Z]')),
      ),
      PasswordRequirement(
        label: 'At least one number (0-9)',
        isSatisfied: password.contains(RegExp(r'[0-9]')),
      ),
      PasswordRequirement(
        label: 'At least one special character (!@#\$...)',
        isSatisfied: password.contains(RegExp(r'''[!@#\$%\^&\*(),.?":{}|<>\-_=+~`[\]\\/;\']''')),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.inputBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password Requirements:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 10),
          ...requirements.map((req) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Row(
                  children: [
                    Icon(
                      req.isSatisfied
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      size: 16,
                      color: req.isSatisfied
                          ? AppColors.cyanAccent
                          : AppColors.secondaryText,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      req.label,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: req.isSatisfied
                            ? AppColors.primaryText
                            : AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
