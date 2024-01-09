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

    final screens = [
      const CalendarPage(),
       ProspectSheduleView()
    ];

    int selectedIndex = 0;

    return GNav(
      color: Colors.orange.shade300,
      activeColor: Colors.orange.shade300,
      tabBackgroundColor: Colors.orange.shade50,
      gap: 8,
      onTabChange: (index){
        setState(() {
          selectedIndex = index;
        });
      },
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 20),
      tabs: const [
        GButton(
          icon: Icons.home_filled, iconColor: Colors.orange,
          text: 'Home', textColor: Colors.black,
        ),
        GButton(
          icon: Icons.calendar_month_outlined, iconColor: Colors.orange,
          text: 'Agenda', textColor: Colors.black,
        ),
        GButton(
          icon: Icons.person, iconColor: Colors.orange,
          text: 'Clientes', textColor: Colors.black,
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