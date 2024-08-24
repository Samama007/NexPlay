import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePagState();
}

class _ExplorePagState extends State<ExplorePage> {
  List games = [
    'sad',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
    'asd',
    'sad',
    'asd',
    'sad',
    'asd',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Center(child: Text('Games'))),
        body: SizedBox(
          height: 250, // Fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: games.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200, // Width of each item
                margin: EdgeInsets.symmetric(horizontal: 8.0), // Optional spacing between items
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(games[index]),
                    Image.network(
                      "https://w7.pngwing.com/pngs/695/655/png-transparent-head-the-dummy-avatar-man-tie-jacket-user.png",
                      width: 100, // Width of the image
                      height: 100, // Height of the image
                      fit: BoxFit.cover, // Fit the image within its bounds
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
