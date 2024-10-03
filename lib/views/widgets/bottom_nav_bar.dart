// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexplay/views/pages/explore_page.dart';
import 'package:nexplay/views/pages/library_page.dart';
import 'package:nexplay/views/pages/profile_page.dart';

class BottomNavBar extends StatefulWidget {
  final String name;

  const BottomNavBar({super.key, required this.name});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with TickerProviderStateMixin {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          ExplorePage(username: widget.name),
          Library(),
          ProfilePage(username: widget.name),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: tertiaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GNav(
          selectedIndex: selectedIndex,
          onTabChange: onTapped,
          rippleColor: backgroundColor,
          hoverColor: backgroundColor,
          haptic: true,
          tabBorderRadius: 15,
          backgroundColor: tertiaryColor,
          color: Colors.white,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          gap: 8,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: "Explore",
              iconActiveColor: foregroundColor,
              iconColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: foregroundColor),
              backgroundColor: backgroundColor,
            ),
            GButton(
              icon: FontAwesomeIcons.book,
              text: "Library",
              iconActiveColor: foregroundColor,
              iconColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: foregroundColor),
              backgroundColor: backgroundColor,
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              text: "Profile",
              iconActiveColor: foregroundColor,
              iconColor: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: foregroundColor),
              backgroundColor: backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
