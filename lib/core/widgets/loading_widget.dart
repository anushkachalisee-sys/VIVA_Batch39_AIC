import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

/// Reusable loading indicator for the VIVA application.
class LoadingWidget extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const LoadingWidget({
    super.key,
    this.size = 24.0,
    this.strokeWidth = 2.5,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primaryPink,
          ),
        ),
      ),
    );
  }
}
