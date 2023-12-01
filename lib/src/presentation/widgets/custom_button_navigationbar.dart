import 'package:flutter/material.dart';


class CustomButtonNavigationBar extends StatelessWidget {
  const CustomButtonNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
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