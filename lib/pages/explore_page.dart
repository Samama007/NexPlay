// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/categories.dart';
import 'package:nexplay/widgets/search_bar.dart';

class ExplorePage extends StatefulWidget {
  final String username;
  const ExplorePage({super.key, required this.username});

  @override
  State<ExplorePage> createState() => _ExplorePagState();
}

class _ExplorePagState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: FloatingActionButton(
        //       onPressed: () {
        //       },
        //       backgroundColor: Colors.white,
        //       foregroundColor: Colors.black,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //       child: Icon(
        //         Icons.gamepad_outlined,
        //         size: 35,
        //       )),
        // ),
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 10, top: 20),
            child: Row(
              children: [
                Text("Welcome,", style: TextStyle(color: Colors.white, fontSize: 25)),
                SizedBox(width: 5),
                Text(widget.username, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://media.fortniteapi.io/images/dd35114d0cb56d5df4e2cd3c0fc992d0/transparent.png'),
                  ),
                )
              ],
            ),
          ),
          Mysearchbar(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Trending now',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: MyCarousel(),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Categories',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Categories(),
          ),
        ],
      ),
    ));
  }
}
