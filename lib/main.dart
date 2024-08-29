import 'dart:ui';
import 'package:flutter/material.dart';
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
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse,PointerDeviceKind.touch},
      ),
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
      ),
    );
  }
}
