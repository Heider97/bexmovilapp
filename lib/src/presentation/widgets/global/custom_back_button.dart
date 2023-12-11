import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';
//services
import '../../../locator.dart';
import '../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final int? mode;

  const CustomBackButton({super.key, this.onTap, this.mode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: (onTap == null)
          ? () {
              _navigationService.goBack();
            }
          : onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.radius),
            color: (mode != null)
                ? theme.colorScheme.primary
                : theme.colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color:
                (mode != null) ? Colors.white : theme.colorScheme.onSecondary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
