// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/search_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePagState();
}

class _ExplorePagState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Games'))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Mysearchbar(),
              MyCarousel(),
            ],
          ),
        ));
  }
}
