import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DotNavigationBar(
        marginR: const EdgeInsets.symmetric(
            horizontal: Const.margin, vertical: Const.space25),
        selectedItemColor: const Color(0xFFF27114),
        unselectedItemColor: const Color(0xFFF69B5B),
        currentIndex: 0,
        onTap: (p0) {},
        // dotIndicatorColor: Colors.black,
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
