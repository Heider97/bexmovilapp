import 'package:flutter/material.dart';
import '../atomsbox.dart';

class AppCustomBottomNavBar extends StatelessWidget {
  const AppCustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(
        floating: false,
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
          AppBottomNavBarItem(
              icon: Icons.people, label: 'Cliente', onTap: () {}),
        ],
      ),
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: Container(color: Colors.black12),
          )
        ],
      ),
    );
  }
}
