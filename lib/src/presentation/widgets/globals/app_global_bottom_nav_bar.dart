import 'package:flutter/material.dart';
import '../atomsbox.dart';

class AppGlobalBottomNavBar extends StatelessWidget {
  const AppGlobalBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomNavBar(
      floating: true,
      items: [
        AppBottomNavBarItem(
          icon: Icons.home,
          label: 'Inicio',
          onTap: () {},
        ),
        AppBottomNavBarItem(
          icon: Icons.calendar_month,
          label: 'Agenda',
          onTap: () {},
        ),
        AppBottomNavBarItem(icon: Icons.people, label: 'Cliente', onTap: () {}),
      ],
    );
  }
}
