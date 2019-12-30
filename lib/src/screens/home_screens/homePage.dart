import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:soaqtwo/src/screens/home_screens/profile_page.dart';
import 'package:soaqtwo/src/screens/home_screens/store_page.dart';

import 'favourites_page.dart';
import 'my_cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  List<Widget> _widgetList = [
    Store(),
    MyCartPage(),
    FavouritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Store'),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('My Cart'),
              activeColor: Colors.purpleAccent),
          BottomNavyBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favourites'),
              activeColor: Colors.pink),
          BottomNavyBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('My Account'),
              activeColor: Colors.blue),
        ],
      ),
      body: _widgetList[currentIndex],
    );
  }


}
