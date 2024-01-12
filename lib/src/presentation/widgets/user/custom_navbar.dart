import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/strings.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DotNavigationBar(
      backgroundColor: theme.cardColor,
      selectedItemColor: theme.primaryColor,
      unselectedItemColor: theme.colorScheme.tertiary,
      marginR: EdgeInsets.zero,
      paddingR: EdgeInsets.zero,
      currentIndex: 0,
      onTap: (p0) {
        print(p0);
        //TODO: [Heider Zapa ] remove this logic
        switch(p0){
          case 0:
            Navigator.of(context).pushNamed(Routes.homeRoute);
            break;
          case 1:
            Navigator.of(context).pushNamed(Routes.calendarRoute);
            break;
          case 2:
            break;
        }
      },
      items: [
        /// Home
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.home),
              gapW12,
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.calendar_month),
              gapW12,
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Agenda',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.person),
              gapW12,
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  'Clientes',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
