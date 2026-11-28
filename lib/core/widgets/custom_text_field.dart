import 'package:flutter/material.dart';

import 'package:viva/core/constants/colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';

/// Reusable dark-themed text field component for the VIVA application.
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;

  final FocusNode? focusNode;

  final int maxLines;
  final int? minLines;
  final int? maxLength;

  final double height;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.focusNode,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.height = AppDimensions.inputHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isMultiline = maxLines > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (labelText != null) ...[
          Text(
            labelText!,
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 8),
        ],

        // Input Field
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: isMultiline ? false : obscureText,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          autovalidateMode: autovalidateMode,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,

          style: AppTextStyles.input,
          cursorColor: AppColors.primaryPink,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.hint,

            filled: true,
            fillColor: AppColors.searchBackground,

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            prefixIconConstraints: const BoxConstraints(
              minWidth: 46,
              minHeight: 24,
            ),

            counterStyle: AppTextStyles.hint,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: isMultiline ? 14 : 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.searchBorder,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.searchBorder,
                width: 1,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.primaryPink,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.2,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppDimensions.inputRadius,
              ),
              borderSide: const BorderSide(
                color: AppColors.error,
                width: 1.5,
              ),
            ),
          ),

          // Maintain fixed height for single-line fields.
          // Multiline fields grow according to their content.
          expands: false,
        ),
      ],
    );
  }
}
