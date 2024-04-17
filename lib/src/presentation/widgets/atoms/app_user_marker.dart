import 'package:flutter/material.dart';

class CustomUserMarker extends CustomPainter {
  final BuildContext context;
  final String? image;
  final String initials;

  CustomUserMarker(
      {required this.context, required this.image, required this.initials});

  @override
  void paint(Canvas canvas, Size size) {
    ThemeData theme = Theme.of(context);

    final primaryPaint = Paint()..color = theme.primaryColor;
    final whitePaint = Paint()..color = Colors.white;

    const double circleBlackRadius = 40;
    const double circleWhiteRadius = 35;

    // Circulo Negro
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - 40 - circleBlackRadius),
        circleBlackRadius,
        primaryPaint);

    // Triángulo
    final path = Path();

    path.moveTo(5, size.height - 90);

    path.lineTo(75, size.height - 90);

    path.quadraticBezierTo(
        90, size.height - 58, circleBlackRadius, size.height - 10);

    path.quadraticBezierTo(-10, size.height - 58, 5, size.height - 90);

    canvas.drawPath(path, primaryPaint);

    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - 40 - circleBlackRadius),
        circleWhiteRadius,
        whitePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
