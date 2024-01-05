import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';
//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CustomCheckButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? primaryColorBackgroundMode;

  const CustomCheckButton(
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
        onTap: (onTap == null)
            ? () {
                // _navigationService.goBack();
              }
            : onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.check,
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