//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class GlobalBackgroundSquare extends StatelessWidget {
  final Widget child;
  final double opacity;
  const GlobalBackgroundSquare(
      {super.key, required this.child, required this.opacity});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [
        Positioned(
          top: -540,
          right: -280,
          child: Transform.rotate(
            angle: 0,
            child: Opacity(
              opacity: opacity,
              child: Image.asset(
                Assets.bgSquare,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        child
      ]),
    );
  }
}
