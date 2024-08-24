import 'package:flutter/material.dart';
import 'package:nexplay/authentication%20pages/login_page.dart';
import 'package:nexplay/pages/explore_page.dart';
import 'package:nexplay/widgets/bottom_nav_bar.dart';

void main() {
  runApp(const NexPlay());
}

class NexPlay extends StatefulWidget {
  const NexPlay({super.key});

  @override
  State<NexPlay> createState() => NexPlayState();
}

class NexPlayState extends State<NexPlay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
    );
  }
}
