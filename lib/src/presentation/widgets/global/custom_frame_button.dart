import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';

class CustomFrameButtom extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? primaryColorBackgroundMode;
  final IconData? icon;

  const CustomFrameButtom(
      {super.key, this.onTap, this.primaryColorBackgroundMode, this.icon});

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
            icon,
            color: (primaryColorBackgroundMode == true)
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSecondary,
            size: 22,
          ),
        ),
      ),
    );
  }
}
