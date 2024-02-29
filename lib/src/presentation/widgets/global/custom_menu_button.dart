import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';

class CustomMenuButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? primaryColorBackgroundMode;

  const CustomMenuButton(
      {super.key, this.onTap, this.primaryColorBackgroundMode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Const.radius),
          color: (primaryColorBackgroundMode == true)
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            weight: 40,
            Icons.menu_rounded,
            color: (primaryColorBackgroundMode == true)
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSecondary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
