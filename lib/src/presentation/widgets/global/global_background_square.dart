import 'package:flutter/material.dart';
//utils
import '../../../utils/constants/strings.dart';
//widgets
import '../drawer_widget.dart';

class GlobalBackgroundSquare extends StatelessWidget {
  final Widget child;
  final double opacity;
  final bool? hideBottomNavigationBar;
  const GlobalBackgroundSquare(
      {super.key,
      required this.child,
      required this.opacity,
      this.hideBottomNavigationBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      extendBody: true,
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
      //TODO:: [Heider Zapa] put custom navbar
      bottomNavigationBar: (hideBottomNavigationBar == true)
          ? null
          : null,
    );
  }
}
