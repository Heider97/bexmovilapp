import 'package:flutter/material.dart';

class CustomShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;
    final paint2 = Paint()
      ..color = const Color(0xFFFEAD1D)
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(0, size.height - 20, 20, size.height - 20)
      ..lineTo(size.width, size.height - 20)
      ..lineTo(size.width, 20)
      ..quadraticBezierTo(size.width, 0, size.width - 20, 0)
      ..lineTo(20, 0)
      ..quadraticBezierTo(0, 0, 0, 20);

    final path2 = Path()
      ..moveTo(size.width * 0.65, size.height - 20)
      ..quadraticBezierTo(
          size.width * 0.7, size.height, size.width * 0.75, size.height)
      ..lineTo(size.width - 20, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - 20);

    // Agregar sombra al contenedor
    canvas.drawShadow(path, Colors.grey, 8, true);
    canvas.drawShadow(path2, Colors.grey, 8, true);

    // Dibujar la forma personalizada
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
