import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nexplay/pages/explore_page.dart';
import 'package:nexplay/pages/library_page.dart';
import 'package:nexplay/pages/profile_page.dart';

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
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GNav(
          selectedIndex: selectedIndex,
          onTabChange: onTapped,
          rippleColor: Colors.grey[800]!, // Tab ripple color
          hoverColor: Colors.grey[700]!, // Tab hover color
          haptic: true, // Haptic feedback when a tab is clicked
          tabBorderRadius: 15,
          backgroundColor: Colors.black,
          color: Colors.white, // Inactive icon color
          activeColor: Colors.red.shade500, // Active icon color
          iconSize: 24,
          tabBackgroundColor: Colors.red.shade200.withOpacity(0.3), // Active tab background color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          gap: 8, // Gap between icon and text
          duration: const Duration(milliseconds: 400), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          tabs: [
            GButton(
              icon: FontAwesomeIcons.magnifyingGlass,
              text: "Explore",
              iconActiveColor: Colors.red.shade500,
              iconColor: Colors.white,
              textColor: Colors.red.shade500,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.red.shade200.withOpacity(0.3),
            ),
            GButton(
              icon: FontAwesomeIcons.book,
              text: "Library",
              iconActiveColor: Colors.green.shade500,
              iconColor: Colors.white,
              textColor: Colors.green.shade500,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.green.shade200.withOpacity(0.3),
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              text: "Profile",
              iconActiveColor: Colors.blue.shade500,
              iconColor: Colors.white,
              textColor: Colors.blue.shade500,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: Colors.blue.shade200.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
