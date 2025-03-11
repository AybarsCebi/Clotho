import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:modaapp/AccountPage.dart';
import 'package:modaapp/AddPage.dart';
import 'package:modaapp/ExplorePage.dart';
import 'package:modaapp/HomePage.dart';
import 'package:modaapp/LoginPage.dart';
import 'package:modaapp/MiniBlogPage.dart';
import 'constraints.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Color bckgrd = const Color.fromARGB(255, 235, 235, 235);
  int _selectedIndex = 0;

  void onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int get selectedIndex => _selectedIndex;

  final List<Widget> _pages = <Widget>[
    HomePage(),
    ExplorePage(),
    AccountPage()
  ];

  Widget get selectedPage => _pages.elementAt(_selectedIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 300),
            index: 0,
            height: 55,
            backgroundColor: bckgrd,
            color: darkcolor,
            items: <Widget>[
              Icon(
                Icons.home_filled,
                size: 27,
                color: bckgrd,
              ),
              Icon(
                Icons.search,
                size: 27,
                color: bckgrd,
              ),
              Icon(
                Icons.account_circle_sharp,
                size: 27,
                color: bckgrd,
              ),
            ],
            onTap: (newindex) {
              onBottomNavBarItemTapped(newindex);
            },
          ),
          body: selectedPage,
    );
  }
}