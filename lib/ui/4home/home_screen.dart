import 'package:flutter/material.dart';

import '../../app/utils_res/color_helper.dart';
import 'placeholder_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  int selectedIndex = 2;

  final List<Widget> pages = [
    PlaceholderScreen("Home"),
    PlaceholderScreen("Charts"),
    WatchlistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: blueMarine,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Charts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: "Watchlist"),
        ],
      ),
    );
  }
}
