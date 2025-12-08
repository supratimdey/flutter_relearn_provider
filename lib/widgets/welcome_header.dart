import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: HeaderWavePainter(context)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome To TBT App",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.deepPurple[200]
                        : const Color(0xFF542AE2),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Let's continue your spiritual journey.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.deepPurple[200]
                        : const Color(0xFF542AE2),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ), // Adding some bottom spacing for the wave to cover
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWavePainter extends CustomPainter {
  final BuildContext context;
  HeaderWavePainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).brightness == Brightness.dark
          ? Colors.deepPurple[200]!.withOpacity(0.1)
          : const Color(0xFF542AE2).withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Wave across the whole width
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.8,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.4,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    final paint2 = Paint()
      ..color = Theme.of(context).brightness == Brightness.dark
          ? Colors.deepPurple[200]!.withOpacity(0.05)
          : const Color(0xFF542AE2).withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.3);
    path2.quadraticBezierTo(
      size.width * 0.4,
      size.height * 1.0, // Dip down
      size.width,
      size.height * 0.5,
    );
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);
    path2.close();

    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
