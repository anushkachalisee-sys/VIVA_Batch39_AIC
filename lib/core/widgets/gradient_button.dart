import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Full-width primary button with Purple-to-Pink gradient and subtle glow.
///
/// Features:
/// - LinearGradient: #8B35F0 -> #D52CCB
/// - White bold typography
/// - Right-aligned arrow icon
/// - 18px rounded corners
/// - Subtle purple/pink shadow elevation glow
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final List<Color>? colors;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = Icons.arrow_forward_rounded,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = colors ?? const [
      AppColors.purpleAccent,
      AppColors.pinkAccent,
    ];
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withValues(alpha: 0.35),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: gradientColors.last.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          splashColor: Colors.white24,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                    letterSpacing: 0.3,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    icon,
                    size: 20,
                    color: AppColors.primaryText,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
