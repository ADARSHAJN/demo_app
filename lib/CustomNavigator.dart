import 'package:flutter/material.dart';
import 'package:demo_app/movie.dart';
import 'package:demo_app/myspace.dart';

import 'Logout.dart'; // Import your share screen

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  List widgetList = [
    MovieListPage(),
    MySpace(),
    Logout(),
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              activeIcon: Icon(
                Icons.home_outlined,
                color: Colors.orangeAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My Space',
              activeIcon: Icon(
                Icons.person_2_outlined,
                color: Colors.orangeAccent,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: Colors.orangeAccent ,
              label: 'Share',
              activeIcon: Icon(
                Icons.settings_outlined,
                color: Colors.orangeAccent,
              )),
        ],
        currentIndex: _selectedIndex,
        onTap: onTap,
      ),
    );
  }
}
