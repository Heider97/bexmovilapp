import 'package:bexmovil/src/presentation/views/user/calendar/index.dart';
import 'package:bexmovil/src/presentation/views/user/prospect/index.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({super.key});

  @override
  State<CustomButtonNavigationBar> createState() => _CustomButtonNavigationBarState();

}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {


  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    final screens = [
      const CalendarPage(),
       ProspectSheduleView()
    ];

    int selectedIndex = 0;

    return GNav(
      color: Colors.orange.shade300,
      activeColor: theme.colorScheme.primary,
      tabBackgroundColor: theme.colorScheme.secondary,
      gap: 8,
      onTabChange: (index){
        setState(() {
          selectedIndex = index;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
      tabs: [
        GButton(
          icon: Icons.home_filled, iconColor: theme.colorScheme.tertiary,
          text: 'Home', textColor: theme.colorScheme.onBackground,
        ),
        GButton(
          icon: Icons.calendar_month_outlined, iconColor: theme.colorScheme.tertiary,
          text: 'Agenda', textColor: theme.colorScheme.onBackground,
        ),
        GButton(
          icon: Icons.person, iconColor: theme.colorScheme.tertiary,
          text: 'Clientes', textColor: theme.colorScheme.onBackground,
        ),
      ]
    );
    // return BottomNavigationBar(
    //   items: const [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home_filled),
    //       label: 'Home'
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.calendar_month_outlined),
    //       label: 'Agenda'
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.person),
    //       label: 'clientes'
    //     )
    //   ],
    //   currentIndex: _selectedIndex,
    //   onTap: _onItemTapped,
    // );
  }
}