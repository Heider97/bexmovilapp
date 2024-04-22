import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomUserMarker extends CustomPainter {
  final BuildContext context;
  final ui.Image? image;
  final String initials;

  CustomUserMarker(
      {required this.context, required this.image, required this.initials});

  @override
  void paint(Canvas canvas, Size size) {
    ThemeData theme = Theme.of(context);

    final primaryPaint = Paint()..color = Colors.blue;
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
    if (image != null) {
      /* canvas.drawImage(image!, Offset(5, size.height - 140), Paint()); */

      // Dibujar la imagen dentro del círculo
      // Dibujar la imagen dentro del círculo

      // Dibujar la imagen dentro del círculo
       // Aplicar la máscara de recorte
    final imageOffset = Offset(4, size.height - 115);
    final imageSize = Size(circleBlackRadius * 1.8, circleBlackRadius * 1.8);
    final imageRect = Rect.fromLTWH(imageOffset.dx, imageOffset.dy, imageSize.width, imageSize.height);
    canvas.clipPath(Path()
      ..addOval(imageRect));

    // Dibujar la imagen dentro del círculo
    final srcRect = Rect.fromLTWH(0, 0, image!.width.toDouble(), image!.height.toDouble());
    final dstRect = Rect.fromCircle(center: imageOffset.translate(circleBlackRadius, circleBlackRadius), radius: circleBlackRadius);
    canvas.drawImageRect(image!, srcRect, dstRect, Paint());
      /*  final srcRect = Rect.fromLTWH(
          0, 0, image!.width.toDouble(), image!.height.toDouble());
      final dstRect = Rect.fromCircle(
          center: Offset(
              5 + circleBlackRadius, size.height - 140 + circleBlackRadius),
          radius: circleBlackRadius);
      canvas.drawImageRect(image!, srcRect, dstRect, Paint()); */
      /*   canvas.save(); // Guarda el estado actual del lienzo
    canvas.clipPath(Path() // Aplica una máscara de recorte para dar forma circular
      ..addOval(Rect.fromCircle(
          center: Offset(5 + circleBlackRadius, size.height - 112 + circleBlackRadius),
          radius: circleBlackRadius))
      ..close());
    canvas.drawImage(image!, Offset(5, size.height - 110),primaryPaint); // Dibuja la imagen
    canvas.restore(); / */
    } else {
      final textSpan = TextSpan(
          style: TextStyle(
              color: Colors.blue,
              fontSize: 40,
              fontWeight: FontWeight.w400),
          text: initials);

      final positionTextPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(minWidth: 70, maxWidth: 70);

      positionTextPainter.paint(canvas, Offset(5, size.height - 100));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
