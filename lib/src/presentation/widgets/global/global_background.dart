import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;
  const GlobalBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          Assets.bgPattern,
          fit: BoxFit.cover,
        ),
        child
      ]),
    );
  }
}
