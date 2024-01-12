import 'package:flutter/material.dart';

//utils
import '../../utils/constants/strings.dart';

import '../../locator.dart';
import '../../services/navigation.dart';

final NavigationService navigationService = locator<NavigationService>();

class CustomButtonNavigationBar extends StatelessWidget {
  const CustomButtonNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (int index) {
        switch (index){
          case 0:
            navigationService.goTo(Routes.homeRoute);
            break;
          case 1:
            navigationService.goTo(Routes.calendarRoute);
            break;
          case 2:
            // navigationService.goTo(Routes.clientsRoute);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Agenda'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'clientes'
        )
      ],
    );
  }
}