import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(
        padding: EdgeInsets.all(0)
      ),
      child: DotNavigationBar(
        marginR: const  EdgeInsets.all(0),
        backgroundColor: const Color.fromARGB(255, 255, 254, 253),
        selectedItemColor: const Color(0xFFF27114),
        unselectedItemColor: const Color(0xFFF69B5B),
        splashBorderRadius: 80,
        currentIndex: 0,
        onTap: (p0) {},
        items: [
          /// Home
          DotNavigationBarItem(
            icon: const Row(
              children: [
                Icon(Icons.home),
                Text('Home'),
              ],
            ),
          ),
          DotNavigationBarItem(
            icon: const Row(
              children: [
                Icon(Icons.calendar_month),
                Text('Agenda'),
              ],
            ),
          ),
          DotNavigationBarItem(
            icon: const Row(
              children: [
                Icon(Icons.person),
                Text('Clientes'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
