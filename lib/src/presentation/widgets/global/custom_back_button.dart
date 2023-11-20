import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CustomBackButton extends StatelessWidget {
  final String? route;

  const CustomBackButton({super.key, this.route});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        route ?? _navigationService.goBack();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Const.radius),
            color: theme.colorScheme.secondary),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSecondary,
            size: 18,
          ),
        ),
      ),
    );
  }
}
