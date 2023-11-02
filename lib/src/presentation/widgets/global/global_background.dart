import 'package:flutter/material.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;
  const GlobalBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'assets/images/bg-pattern.png',
            fit: BoxFit.cover,
          ),
          child
        ]));
  }
}
