import 'package:flutter/material.dart';
//utils
import '../../../utils/constants/strings.dart';

class GlobalBackground extends StatelessWidget {
  final Widget child;
  const GlobalBackground({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.background,
      body: Stack(fit: StackFit.expand, children: [
        Image.asset(
          Assets.bgPattern,
          fit: BoxFit.cover,
          color: theme.colorScheme.background,
        ),
        child
      ]),
    );
  }
}
