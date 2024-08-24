import 'package:flutter/material.dart';
import 'package:nexplay/widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Games')),
      body: Center(child: Text('s')),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
