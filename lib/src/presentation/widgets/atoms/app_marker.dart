import 'package:flutter/material.dart';

class CustomMarker extends CustomPainter {
 /*  final String dailyPrice;
  final String model; */
  final BuildContext context;

  CustomMarker(
      {/* required this.dailyPrice, required this.model, */ required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    ThemeData theme = Theme.of(context);
    final blackPaint = Paint()..color = theme.primaryColor;

    final whitePaint = Paint()..color = theme.colorScheme.onPrimary;

    const double circleBlackRadius = 20;
    const double circleWhiteRadius = 7;

    // Circulo Negro
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleBlackRadius,
        blackPaint);

    // Circulo Blanco
    canvas.drawCircle(
        Offset(circleBlackRadius, size.height - circleBlackRadius),
        circleWhiteRadius,
        whitePaint);

    // Dibujar caja blanca
/*     final path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 30, 20);
    path.lineTo(size.width - 30, 100);
    path.lineTo(40, 100); */

    // Sombra
    //canvas.drawShadow(path, Colors.white, 10, false);

    // Caja
   // canvas.drawPath(path, whitePaint);

    // Caja Negra
    const blackBox = Rect.fromLTWH(40, 20, 70, 80);
   // canvas.drawRect(blackBox, blackPaint);

    // Textos
    // Minutos
    /* final textSpan = TextSpan(
        style: const TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400),
        text: (double.tryParse(dailyPrice) != null) ? '\$' : model); */

   /*  final minutesPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70); */

/*     minutesPainter.paint(canvas, const Offset(40, 35)); */

    // Palabra MIN
   /*  final minutesText = TextSpan(
        style: (double.tryParse(dailyPrice) != null)
            ? const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w300)
            : const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w200),
        text: (double.tryParse(dailyPrice) != null) ? 'Day' : 'Available'); */

   /*  final minutesMinPainter = TextPainter(
        text: minutesText,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center)
      ..layout(minWidth: 70, maxWidth: 70); */
/* 
    minutesMinPainter.paint(canvas, const Offset(40, 68));
 */
    // Descripción

   /*  final locationText = TextSpan(
        style: const TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),
        text: (double.tryParse(dailyPrice) != null)
            ? "US $dailyPrice"
            : dailyPrice); */

    /* final locationPainter = TextPainter(
        maxLines: 2,
        ellipsis: '...',
        text: locationText,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left)
      ..layout(minWidth: size.width - 135, maxWidth: size.width - 135); */

   /*  final double offsetY = (dailyPrice.length > 20) ? 35 : 48;
 */
    /* locationPainter.paint(canvas, Offset(120, 35)); */
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
