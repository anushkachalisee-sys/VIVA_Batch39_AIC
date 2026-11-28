import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
import '../../../../core/widgets/custom_text_field.dart';

/// Reusable search field specifically configured for searching/filtering artists.
class ArtistSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const ArtistSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final hasText = value.text.isNotEmpty;

        return CustomTextField(
          controller: controller,
          hintText: 'Search artists...',
          onChanged: onChanged,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.accentCyan,
            size: 20,
          ),
          suffixIcon: hasText
              ? GestureDetector(
            onTap: () {
              controller.clear();
              onClear?.call();
            },
            child: const Icon(
              Icons.close,
              color: AppColors.secondaryText,
              size: 16,
            ),
          )
              : null,
        );
      },
    );
  }
}
