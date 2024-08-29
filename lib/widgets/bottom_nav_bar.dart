// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexplay/pages/explore_page.dart';
import 'package:nexplay/pages/library_page.dart';
import 'package:nexplay/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          children: [
            ExplorePage(),
            LibraryPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: onTapped,
        selectedItemColor: Colors.red.shade500,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "Explore",
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          ),
          BottomNavigationBarItem(
            label: "Library",
            icon: FaIcon(FontAwesomeIcons.book),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: FaIcon(FontAwesomeIcons.user),
          ),
        ],
      ),
    );
  }
}
