import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';
//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CustomCloseButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool? primaryColorBackgroundMode;

  const CustomCloseButton(
      {super.key, this.onTap, this.primaryColorBackgroundMode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Const.radius),
          color: (primaryColorBackgroundMode == true)
              ? theme.colorScheme.secondary
              : theme.colorScheme.primary),
      child: InkWell(
        onTap: (onTap == null)
            ? () {
                _navigationService.goBack();
              }
            : onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.close,
            color: (primaryColorBackgroundMode == true)
                ? theme.colorScheme.onSecondary
                : theme.colorScheme.onPrimary,
            size: 18,
          ),
        ),
      ),
    );
  }
}