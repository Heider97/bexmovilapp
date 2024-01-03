import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

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
      onTap: (p0) {},
      items: [
        /// Home
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.home),
              gapW12,
              Text('Home'),
            ],
          ),
        ),
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.calendar_month),
              gapW12,
              Text('Agenda'),
            ],
          ),
        ),
        DotNavigationBarItem(
          icon: const Row(
            children: [
              Icon(Icons.person),
              gapW12,
              Text('Clientes'),
            ],
          ),
        ),
      ],
    );
  }
}
