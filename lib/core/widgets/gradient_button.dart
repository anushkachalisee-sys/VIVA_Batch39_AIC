import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';
import 'loading_widget.dart';

/// Reusable gradient button for the VIVA application.
/// Supports custom text, dimensions, loading indicator, icons, and disabled states.
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final bool isLoading;
  final Gradient? gradient;
  final Widget? icon;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = AppDimensions.buttonHeight,
    this.isLoading = false,
    this.gradient,
    this.icon,
  });

  bool get _isEnabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isEnabled ? onPressed : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _isEnabled ? 1.0 : 0.6,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
            gradient: _isEnabled
                ? (gradient ?? AppColors.primaryGradient)
                : null,
            color: _isEnabled ? null : AppColors.unselectedChip,
            boxShadow: _isEnabled
                ? [
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 5),
              ),
            ]
                : null,
          ),
          child: Center(
            child: isLoading
                ? const LoadingWidget(
              size: 22.0,
              color: Colors.white,
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: _isEnabled
                      ? AppTextStyles.button
                      : AppTextStyles.buttonDisabled,
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  icon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
