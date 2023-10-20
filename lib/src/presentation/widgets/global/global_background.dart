import 'package:flutter/material.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;
  const GlobalBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg-pattern.png', // Reemplaza con la ruta de tu imagen
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        child,
      ],
    );
  }
}
