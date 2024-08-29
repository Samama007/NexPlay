// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/categories.dart';
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Mysearchbar(),
          SizedBox(
            height: 20,
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'Trending now',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            )
          ]),
          MyCarousel(),
          SizedBox(height: 20),
          Categories(),
        ],
      ),
    ));
  }
}
