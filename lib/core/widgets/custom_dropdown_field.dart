import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Reusable dark-themed dropdown form field for VIVA registration.
///
/// Features:
/// - Label displayed above the dropdown field
/// - Dark background (#19192F) with 18px rounded corners
/// - Thin muted purple border (#363653) & purple focus border
/// - Muted lavender hint & arrow icon, white selected text
/// - Form validation & responsive truncation handling
class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above field
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 8),

        // Dropdown Form Field
        DropdownButtonFormField<String>(
          value: value,
          hint: Text(
            hintText,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          isExpanded: true,
          dropdownColor: AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(18),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.secondaryText,
            size: 22,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            fillColor: AppColors.inputBackground,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
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
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
