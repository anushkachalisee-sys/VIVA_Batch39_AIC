import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:viva/core/constants/colors.dart';

/// Type of illustration badge to display.
enum RecoveryIllustrationType {
  lock,
  successCheck,
}

/// Custom illustration widget for Password Recovery screens.
/// Renders an ethereal purple envelope surrounded by orbital cosmic rings,
/// glowing particles, and a distinct status badge (Lock or Cyan Checkmark).
class PasswordRecoveryIllustration extends StatelessWidget {
  final RecoveryIllustrationType type;

  const PasswordRecoveryIllustration({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: CustomPaint(
        painter: _EnvelopeIllustrationPainter(type: type),
      ),
    );
  }
}

class _EnvelopeIllustrationPainter extends CustomPainter {
  final RecoveryIllustrationType type;

  _EnvelopeIllustrationPainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.48);

    // 1. Soft Ambient Radial Glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryPurple.withValues(alpha: 0.22),
          AppColors.primaryPink.withValues(alpha: 0.08),
          Colors.transparent,
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(
        Rect.fromCircle(center: center, radius: 95),
      );

    canvas.drawCircle(center, 95, glowPaint);

    // 2. Cosmic Orbital Ellipses
    _drawOrbit(
      canvas: canvas,
      center: center,
      radiusX: 115,
      radiusY: 42,
      rotation: -0.22, // Slight tilt
      color: AppColors.primaryPurple.withValues(alpha: 0.28),
      strokeWidth: 1.0,
    );

    _drawOrbit(
      canvas: canvas,
      center: center,
      radiusX: 125,
      radiusY: 34,
      rotation: 0.20,
      color: AppColors.primaryPurple.withValues(alpha: 0.16),
      strokeWidth: 0.8,
    );

    // 3. Glowing Orbital Particles / Dots
    final particlePaint = Paint()..style = PaintingStyle.fill;

    // Cyan particle on the left orbit
    particlePaint.color = AppColors.accentCyan;
    canvas.drawCircle(
      Offset(center.dx - 98, center.dy + 12),
      2.5,
      particlePaint,
    );

    // Pink particle on the upper right orbit
    particlePaint.color = AppColors.primaryPink;
    canvas.drawCircle(
      Offset(center.dx + 88, center.dy - 32),
      2.5,
      particlePaint,
    );

    // 4. Envelope Body (Rounded Rectangle)
    const envWidth = 126.0;
    const envHeight = 82.0;
    final envRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 2),
      width: envWidth,
      height: envHeight,
    );
    const envRadius = Radius.circular(14.0);

    // Fill interior with dark translucent purple
    final envFillPaint = Paint()
      ..color = const Color(0xFF141126).withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(envRect, envRadius),
      envFillPaint,
    );

    // Envelope Outer Glowing Border
    final envBorderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF9065F7),
          Color(0xFFA855F7),
          Color(0xFF8B5CF6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(envRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(envRect, envRadius),
      envBorderPaint,
    );

    // 5. Envelope Flap and Fold Lines
    final foldPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF8B5CF6).withValues(alpha: 0.9);

    final flapTip = Offset(envRect.center.dx, envRect.top + envHeight * 0.52);

    // Flap Top V
    final flapPath = Path()
      ..moveTo(envRect.left + 5, envRect.top + 3)
      ..lineTo(flapTip.dx, flapTip.dy)
      ..lineTo(envRect.right - 5, envRect.top + 3);
    canvas.drawPath(flapPath, foldPaint);

    // Bottom-Left to Flap Tip Fold Line
    canvas.drawLine(
      Offset(envRect.left + 5, envRect.bottom - 4),
      Offset(flapTip.dx - 12, flapTip.dy + 8),
      foldPaint,
    );

    // Bottom-Right to Flap Tip Fold Line
    canvas.drawLine(
      Offset(envRect.right - 5, envRect.bottom - 4),
      Offset(flapTip.dx + 12, flapTip.dy + 8),
      foldPaint,
    );

    // 6. Overlapping Badge at Bottom Right Corner
    final badgeCenter = Offset(envRect.right - 6, envRect.bottom - 4);
    const badgeRadius = 19.5;

    final isLock = type == RecoveryIllustrationType.lock;

    // Badge Background Fill
    final badgeBgPaint = Paint()
      ..color = isLock ? const Color(0xFF16122C) : const Color(0xFF0F1E2E)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(badgeCenter, badgeRadius, badgeBgPaint);

    // Badge Border Ring
    final badgeRingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = isLock ? const Color(0xFF8B5CF6) : AppColors.accentCyan;
    canvas.drawCircle(badgeCenter, badgeRadius, badgeRingPaint);

    // 7. Badge Icon (Lock or Cyan Checkmark)
    if (isLock) {
      _drawLockIcon(canvas, badgeCenter);
    } else {
      _drawCheckmarkIcon(canvas, badgeCenter);
    }
  }

  void _drawOrbit({
    required Canvas canvas,
    required Offset center,
    required double radiusX,
    required double radiusY,
    required double rotation,
    required Color color,
    required double strokeWidth,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: radiusX * 2,
      height: radiusY * 2,
    );
    canvas.drawOval(rect, paint);
    canvas.restore();
  }

  void _drawLockIcon(Canvas canvas, Offset center) {
    final strokePaint = Paint()
      ..color = AppColors.primaryText
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = AppColors.primaryText
      ..style = PaintingStyle.fill;

    // Lock Shackle (top arch)
    final shackleRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 3.5),
      width: 10,
      height: 9,
    );
    final shacklePath = Path()
      ..arcTo(shackleRect, math.pi, math.pi, false)
      ..lineTo(shackleRect.right, center.dy - 1.5)
      ..moveTo(shackleRect.left, center.dy - 1.5)
      ..lineTo(shackleRect.left, shackleRect.center.dy);
    canvas.drawPath(shacklePath, strokePaint);

    // Lock Body (rounded rectangle)
    final bodyRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + 3.0),
      width: 13,
      height: 9.5,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(bodyRect, const Radius.circular(2.5)),
      fillPaint,
    );

    // Keyhole
    final keyholePaint = Paint()
      ..color = const Color(0xFF16122C)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx, center.dy + 2.5), 1.3, keyholePaint);
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + 4.2),
        width: 1.2,
        height: 2.2,
      ),
      keyholePaint,
    );
  }

  void _drawCheckmarkIcon(Canvas canvas, Offset center) {
    final checkPaint = Paint()
      ..color = AppColors.accentCyan
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path()
      ..moveTo(center.dx - 6.0, center.dy + 0.5)
      ..lineTo(center.dx - 2.0, center.dy + 4.5)
      ..lineTo(center.dx + 6.5, center.dy - 4.5);

    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _EnvelopeIllustrationPainter oldDelegate) {
    return oldDelegate.type != type;
  }
}
