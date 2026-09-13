import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Latar belakang bergaya "lapangan" — garis tengah tipis dan lingkaran
/// tengah, mengingatkan pada garis tengah lapangan olahraga. Sangat
/// transparan supaya tidak mengganggu konten di atasnya.
class ArenaBackground extends StatelessWidget {
  final Widget child;

  const ArenaBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, AppColors.backgroundAlt],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _CourtLinePainter()),
          child,
        ],
      ),
    );
  }
}

class _CourtLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);

    // Garis tengah vertikal, seperti garis tengah lapangan.
    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      linePaint,
    );

    // Lingkaran tengah.
    final radius = size.shortestSide * 0.16;
    canvas.drawCircle(center, radius, linePaint);
    canvas.drawCircle(center, 4, linePaint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
