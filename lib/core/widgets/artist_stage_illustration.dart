import 'package:flutter/material.dart';
import 'package:viva/app/theme/app_colors.dart';/// Lightweight custom painter widget for the Artist Login stage & microphone artwork.
class ArtistStageIllustration extends StatelessWidget {
  const ArtistStageIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: CustomPaint(
        painter: _StagePainter(),
      ),
    );
  }
}

class _StagePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.72);
    final stageRadiusX = size.width * 0.35;
    final stageRadiusY = 22.0;

    // 1. Draw Spotlight Rays (Left Cyan, Right Pink)
    final spotlightLeft = Path()
      ..moveTo(size.width * 0.15, 0)
      ..lineTo(center.dx - 50, center.dy)
      ..lineTo(center.dx + 10, center.dy)
      ..lineTo(size.width * 0.25, 0)
      ..close();

    final spotlightRight = Path()
      ..moveTo(size.width * 0.85, 0)
      ..lineTo(center.dx + 50, center.dy)
      ..lineTo(center.dx - 10, center.dy)
      ..lineTo(size.width * 0.75, 0)
      ..close();

    final cyanLight = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.accentCyan.withValues(alpha: 0.35),
          AppColors.accentCyan.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final pinkLight = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryPink.withValues(alpha: 0.35),
          AppColors.primaryPink.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(spotlightLeft, cyanLight);
    canvas.drawPath(spotlightRight, pinkLight);

    // 2. Stage Platform Glow (Radial)
    final stageGlowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.primaryPurple.withValues(alpha: 0.5),
          AppColors.primaryPink.withValues(alpha: 0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: stageRadiusX * 1.3));

    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: stageRadiusX * 2.6,
        height: stageRadiusY * 2.6,
      ),
      stageGlowPaint,
    );

    // 3. Stage Oval Base
    final stageBasePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [
          AppColors.background,
          Color(0xFF0F0B1A),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: stageRadiusX));

    final stageStrokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..shader = const LinearGradient(
        colors: [AppColors.accentCyan, AppColors.primaryPink, AppColors.primaryPurple],
      ).createShader(Rect.fromCircle(center: center, radius: stageRadiusX));

    final stageRect = Rect.fromCenter(
      center: center,
      width: stageRadiusX * 2,
      height: stageRadiusY * 2,
    );

    canvas.drawOval(stageRect, stageBasePaint);
    canvas.drawOval(stageRect, stageStrokePaint);

    // 4. Studio Microphone
    final micCenter = Offset(center.dx, center.dy - 35);

    // Stand rod
    final standPaint = Paint()
      ..color = const Color(0xFFD0CDE0)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(center.dx, center.dy - 5),
      Offset(micCenter.dx, micCenter.dy + 18),
      standPaint,
    );

    // Mic Clip Base
    final clipPaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(center.dx, micCenter.dy + 18), 5, clipPaint);

    // Mic Body
    final micBodyRect = Rect.fromCenter(
      center: micCenter,
      width: 22,
      height: 38,
    );

    final micBodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE2E0EC), Color(0xFF7A7593), Color(0xFF38334E)],
      ).createShader(micBodyRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(micBodyRect, const Radius.circular(11)),
      micBodyPaint,
    );

    // Mic Grille Lines
    final grillePaint = Paint()
      ..color = AppColors.background
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(micCenter.dx - 9, micCenter.dy - 4),
      Offset(micCenter.dx + 9, micCenter.dy - 4),
      grillePaint,
    );
    canvas.drawLine(
      Offset(micCenter.dx - 9, micCenter.dy + 4),
      Offset(micCenter.dx + 9, micCenter.dy + 4),
      grillePaint,
    );

    // Mic Outer Glow Ring
    final micRingPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = const LinearGradient(
        colors: [AppColors.accentCyan, AppColors.primaryPink],
      ).createShader(micBodyRect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(micBodyRect.inflate(3), const Radius.circular(14)),
      micRingPaint,
    );

    // 5. Floating Music Sparkles around Mic
    final sparkPaint = Paint()..style = PaintingStyle.fill;

    final sparkles = [
      Offset(micCenter.dx - 35, micCenter.dy - 25),
      Offset(micCenter.dx + 38, micCenter.dy - 20),
      Offset(micCenter.dx - 22, micCenter.dy - 45),
      Offset(micCenter.dx + 25, micCenter.dy - 42),
      Offset(micCenter.dx - 45, micCenter.dy + 10),
      Offset(micCenter.dx + 48, micCenter.dy + 12),
    ];

    for (int i = 0; i < sparkles.length; i++) {
      final pos = sparkles[i];
      sparkPaint.color = i % 2 == 0 ? AppColors.accentCyan : AppColors.primaryPink;
      final radius = 2.0 + (i % 3);
      canvas.drawCircle(pos, radius, sparkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
