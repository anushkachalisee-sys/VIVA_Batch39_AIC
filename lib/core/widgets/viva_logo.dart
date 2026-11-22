import 'package:flutter/material.dart';

/// Reusable VIVA Logo component.
/// Uses the official VIVA logo image asset from `assets/images/viva_logo.png`.
class VivaLogo extends StatelessWidget {
  static const String assetPath = 'assets/images/logo/soundwave.png';

  final double? width;
  final double? height;
  final BoxFit fit;

  const VivaLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
