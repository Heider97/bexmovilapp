//TODO [Heider Zapa] Organize

import 'package:bexmovil/src/presentation/widgets/drawer_widget.dart';
import 'package:bexmovil/src/presentation/widgets/user/custom_navbar.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

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
      //  backgroundColor: Colors.white,
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
      bottomNavigationBar: (hideBottomNavigationBar == true)
          ? null
          : const CustomBottomNavigationBar(),
    );
  }
}
