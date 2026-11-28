import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';
/// Top bar header for Password Recovery screens.
/// Features a back navigation arrow on the left and a centered VIVA brand logo.
class PasswordRecoveryHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const PasswordRecoveryHeader({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left: Back Navigation Arrow
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryText,
                size: 24,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              splashRadius: 22,
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            ),
          ),

          // Center: VIVA Logo & Branding
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Gradient Soundwave Badge
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF8B5CF6),
                      Color(0xFFEC4899),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(16, 12),
                    painter: _SoundwaveCurvePainter(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // VIVA Brand Text
              const Text(
                'VIVA',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Paints the iconic VIVA continuous waveform squiggle.
class _SoundwaveCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.05, h * 0.70);
    path.lineTo(w * 0.24, h * 0.20);
    path.lineTo(w * 0.46, h * 0.85);
    path.lineTo(w * 0.68, h * 0.10);
    path.lineTo(w * 0.84, h * 0.75);
    path.lineTo(w * 0.95, h * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
