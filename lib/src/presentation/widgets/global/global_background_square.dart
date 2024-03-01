import 'package:bexmovil/src/presentation/widgets/atoms/app_back_button.dart';
import 'package:flutter/material.dart';
//utils
import '../../../utils/constants/strings.dart';
//widgets
import '../drawer_widget.dart';
import 'app_global_bottom_nav_bar.dart';

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

    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(7), child: AppBackButton(needPrimary: true)),
        title: TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Perform search functionality here
          },
        ),

      ),
      key: globalKey,
      drawerEnableOpenDragGesture: false,
      drawer: const DrawerWidget(),
      endDrawer: const DrawerWidget(),
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
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
      bottomNavigationBar: hideBottomNavigationBar == true
          ? null
          : const AppGlobalBottomNavBar(),
    );
  }
}
