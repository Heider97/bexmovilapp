import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../locator.dart';
import '../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({super.key});

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GNav(
        color: Colors.orange.shade300,
        activeColor: theme.colorScheme.primary,
        tabBackgroundColor: theme.colorScheme.secondary,
        gap: 8,
        onTabChange: (index) {
          switch(index) {
            case 0:
              navigationService.goTo(Routes.homeRoute);
              break;
            case 1:
              navigationService.goTo(Routes.calendarRoute);
              break;
            case 2:
              // navigationService.goTo(Routes.homeRoute);
              break;
          }
        },
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
        tabs: [
          GButton(
            icon: Icons.home_filled,
            iconColor: theme.colorScheme.tertiary,
            text: 'Home',
            textColor: theme.colorScheme.onBackground,
          ),
          GButton(
            icon: Icons.calendar_month_outlined,
            iconColor: theme.colorScheme.tertiary,
            text: 'Agenda',
            textColor: theme.colorScheme.onBackground,
          ),
          GButton(
            icon: Icons.person,
            iconColor: theme.colorScheme.tertiary,
            text: 'Clientes',
            textColor: theme.colorScheme.onBackground,
          ),
        ]);
  }
}
