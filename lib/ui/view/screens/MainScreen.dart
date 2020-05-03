import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/view/screens/AddPictureScreen.dart';

import 'HomeScreen.dart';
import 'ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    HomeScreen(),
    AddPictureScreen(),
    ProfileScreen(),
  ];

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("")),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.search), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo),
              title: Text("")),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.favorite_border),
          //     title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.portrait), title: Text("")),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
    );
  }
}
