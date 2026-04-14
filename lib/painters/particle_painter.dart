import 'dart:math';
import 'package:flutter/material.dart';
import '../constants.dart';

/// Animated particle / star-field background that adapts to dark / light theme.
class ParticlePainter extends CustomPainter {
  final double progress;
  final bool isDark;

  static final _rng = Random(42); // fixed seed for stable positions

  // Pre-computed star data so we don't create them every frame
  static final List<_Star> _stars = List.generate(
    180,
    (i) => _Star(
      baseX:  _rng.nextDouble(),
      baseY:  _rng.nextDouble(),
      radius: _rng.nextDouble() * 1.8 + 0.3,
      speed:  _rng.nextDouble() * 0.4 + 0.05,
      alpha:  _rng.nextDouble() * 0.6 + 0.2,
      twinkleOffset: _rng.nextDouble() * 2 * pi,
    ),
  );

  ParticlePainter(this.progress, {required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final bgPaint = Paint()
      ..shader = (isDark ? AppColors.heroDark : AppColors.heroLight)
          .createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Stars / particles
    final starPaint = Paint();
    for (final s in _stars) {
      final x = ((s.baseX + progress * s.speed) % 1.0) * size.width;
      final y = ((s.baseY + progress * s.speed * 0.6) % 1.0) * size.height;
      final twinkle = (sin(progress * 2 * pi * 3 + s.twinkleOffset) + 1) / 2;
      final alpha   = s.alpha * (0.6 + 0.4 * twinkle);

      starPaint.color = isDark
          ? Colors.cyanAccent.withOpacity(alpha * 0.7)
          : AppColors.teal.withOpacity(alpha * 0.35);
      canvas.drawCircle(Offset(x, y), s.radius, starPaint);
    }

    // Floating orb glow (dark only)
    if (isDark) {
      final orbX = size.width  * (0.8 + 0.12 * sin(progress * 2 * pi * 0.3));
      final orbY = size.height * (0.2 + 0.08 * cos(progress * 2 * pi * 0.2));
      final orb  = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.teal.withOpacity(0.18),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(orbX, orbY), radius: 260));
      canvas.drawCircle(Offset(orbX, orbY), 260, orb);

      final orb2X = size.width  * (0.15 + 0.08 * cos(progress * 2 * pi * 0.25));
      final orb2Y = size.height * (0.75 + 0.06 * sin(progress * 2 * pi * 0.18));
      final orb2 = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.violet.withOpacity(0.12),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: Offset(orb2X, orb2Y), radius: 200));
      canvas.drawCircle(Offset(orb2X, orb2Y), 200, orb2);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter old) =>
      old.progress != progress || old.isDark != isDark;
}

class _Star {
  final double baseX, baseY, radius, speed, alpha, twinkleOffset;
  const _Star({
    required this.baseX,
    required this.baseY,
    required this.radius,
    required this.speed,
    required this.alpha,
    required this.twinkleOffset,
  });
}
