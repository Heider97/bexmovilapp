
//TODO [Heider Zapa] Organize

import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

class GlobalBackgroundWithIcon extends StatelessWidget {
  final Widget child;
  const GlobalBackgroundWithIcon({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Opacity(
          opacity: 0.2,
          child: Stack(fit: StackFit.expand, children: [
            Image.asset(
              Assets.bgPattern,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                Assets.bexBackgroundWhite,
                width: 350.0,
                height: 350.0,
              ),
            ),
            child
          ]),
        ));
  }
}
