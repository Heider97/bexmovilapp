import 'package:flutter/material.dart';

class CustomMarker extends CustomPainter {
  final String index;
  final BuildContext context;

  CustomMarker(
      {/* required this.dailyPrice, required this.model, */ required this.context,
      required this.index});

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

    // Texto
    final textSpan = TextSpan(
        style: TextStyle(
            color: theme.primaryColor,
            fontSize: 55,
            fontWeight: FontWeight.w400),
        text: index.toString());

    final positionTextPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70);

    positionTextPainter.paint(canvas, Offset(5, size.height - 110));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
