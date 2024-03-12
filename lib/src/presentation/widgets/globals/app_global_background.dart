import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//utils
import '../../../utils/constants/strings.dart';
//widgets
import '../atoms/app_back_button.dart';
import '../atoms/app_icon_button.dart';
import 'app_global_bottom_nav_bar.dart';
import 'app_global_drawer.dart';

enum AppGlobalBackgroundType { normal, squared, icon }

/// A versatile background widget with multiple styles.
///
/// The [AppGlobalBackground] widget displays a background with one of the following styles:
/// - normal
/// - squared
/// - icon
///
/// Each style has its own constructor, and some properties can be customized.
/// The card can react to touch events when an [onTap] callback is provided.
///
/// Use the following constructors to create the respective card styles:
/// - [AppGlobalBackground.normal]
/// - [AppGlobalBackground.squared]
/// - [AppGlobalBackground.icon]
///
/// ## Customization
///
/// The appearance of the card can be customized using the following properties:
/// - [color] for the background color
/// - [opacity] for the background opacity
/// - [child] for the card's content
///
/// See also:
///
/// * [Container], which is used to create the gradient background.
/// * [Theme], which provides the colors used in the gradient.

// ignore: must_be_immutable
class AppGlobalBackground extends StatelessWidget {
  /// Creates an [AppGlobalBackground] widget.
  ///
  /// The [child] parameter must not be null.
  /// The [colors] parameter is optional, and if not provided, will use the primary
  /// and secondary colors from the [Theme]'s color scheme.

  /// The [elevation] defaults to 4.0.
  AppGlobalBackground.normal({
    super.key,
    this.color,
    this.opacity,
    this.hideBottomNavigationBar,
    this.hideAppBar,
    required this.child,
  }) {
    builder = (context) {
      return Scaffold(
        appBar: hideAppBar == false
            ? AppBar(
                leading: const Padding(
                    padding: EdgeInsets.all(Const.padding),
                    child: AppBackButton(needPrimary: true)),
                actions: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Const.padding, vertical: 5),
                      child: AppIconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: const Icon(Icons.menu)),
                    );
                  }),
                ],
              )
            : null,
        drawer: const DrawerWidget(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            Assets.bgPattern,
            fit: BoxFit.cover,
            color: Theme.of(context).colorScheme.background,
          ),
          child
        ]),
      );
    };
  }

  AppGlobalBackground.squared({
    super.key,
    this.color,
    required this.opacity,
    required this.hideBottomNavigationBar,
    this.hideAppBar,
    required this.child,
  }) {
    builder = (context) {
      return Scaffold(
        appBar: hideAppBar == false
            ? AppBar(
                leading: const Padding(
                    padding: EdgeInsets.all(Const.padding),
                    child: AppBackButton(needPrimary: true)),
                actions: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: Const.padding),
                      child: AppIconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: const Icon(Icons.menu)),
                    );
                  }),
                ],
              )
            : null,
        drawer: const DrawerWidget(),
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: color ?? Theme.of(context).colorScheme.background,
        body: Stack(fit: StackFit.expand, children: [
          Positioned(
            top: -540,
            right: -280,
            child: Transform.rotate(
              angle: 0,
              child: Opacity(
                opacity: opacity!,
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
            : const AppGlobalBottomNavBar(),
      );
    };
  }

  AppGlobalBackground.icon({
    super.key,
    this.color,
    this.opacity,
    this.hideBottomNavigationBar,
    this.hideAppBar,
    required this.child,
  }) {
    builder = (context) {
      return Scaffold(
        appBar: hideAppBar == false
            ? AppBar(
                leading: const Padding(
                    padding: EdgeInsets.all(Const.padding),
                    child: AppBackButton(needPrimary: true)),
                actions: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: Const.padding),
                      child: AppIconButton(
                          onPressed: () => Scaffold.of(context).openDrawer(),
                          child: const Icon(Icons.menu)),
                    );
                  }),
                ],
              )
            : null,
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(fit: StackFit.expand, children: [
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
      );
    };
  }

  late WidgetBuilder builder;

  final Color? color;
  final double? opacity;
  final bool? hideBottomNavigationBar;
  final bool? hideAppBar;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    Widget background = builder.call(context);
    return background;
  }
}
