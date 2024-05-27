import 'package:bexmovil/src/presentation/views/user/home/pages/calendar.dart';
import 'package:bexmovil/src/presentation/views/user/home/pages/clients.dart';
import 'package:bexmovil/src/presentation/views/user/home/pages/home.dart';
import 'package:flutter/material.dart';

class IndexView extends StatefulWidget {
  const IndexView({super.key});

  @override
  State<IndexView> createState() => IndexViewState();
}

class IndexViewState extends State<IndexView> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      const BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Agenda',
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.info_outline), label: 'Clientes')
    ];
  }

  final pageController = PageController(
    initialPage: 0,
    // viewportFraction: 0.8,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[HomeView(), CalendarView(), ClientsView()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }
}
