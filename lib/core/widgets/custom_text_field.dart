import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Reusable dark-themed input field for VIVA registration.
///
/// Features:
/// - Label displayed above the field
/// - Dark background (#19192F)
/// - 18px rounded corners
/// - Thin muted purple border (#363653)
/// - White typed text & muted lavender hint/icon styling
/// - Optional multiline & character counter support
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final Widget prefixWidget;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final int maxLines;
  final int? minLines;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.prefixWidget,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Field Label above input
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),

        // Text Form Field
        TextFormField(
          controller: controller,
          obscureText: maxLines == 1 ? obscureText : false,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
          ),
          cursorColor: AppColors.cyanAccent,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            fillColor: AppColors.inputBackground,
            filled: true,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                top: maxLines > 1 ? 14 : 0,
              ),
              child: prefixWidget,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 46,
              minHeight: 24,
              maxHeight: maxLines > 1 ? double.infinity : 48,
            ),
            suffixIcon: suffixIcon,
            counterStyle: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 12,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.inputBorder, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.purpleAccent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.errorText, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: AppColors.errorText, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
