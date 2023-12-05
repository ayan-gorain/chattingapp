import 'package:chatapp/pages/user.dart';
import 'package:chatapp/pages/welcomepage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:io' show Platform;



// Import your Dart files here

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  // List of pages to navigate to
  final List<Widget> _pages = [
    welco(), // Imported Dart file 1
    about(), // Imported Dart file 2
    // Add more Dart files here for additional tabs
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Add your custom logic when the back button is pressed
        // For example, showing an alert or confirming exit
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ).then((value) {
          if (value == true) {
            // If user pressed "Yes", exit the app
            SystemNavigator.pop();
          }
        });

        // Return false to prevent back button press
        return false;
      },
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: GNav(
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.person_2,
                    text: 'Profile',
                  ),
                  // Add more GButton for additional tabs
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onTabChange,
                backgroundColor: Colors.white,
                color: Colors.black,
                activeColor: Colors.black,
                gap: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
