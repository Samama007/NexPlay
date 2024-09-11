// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RatingsPage extends StatelessWidget {
  const RatingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade900,
        elevation: 0,
        bottomOpacity: 0,
        toolbarHeight: 32,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          height: MediaQuery.of(context).size.height,
          color: Colors.deepPurple.shade900,
          child: ListView.builder(
            itemCount: 20,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text('Z', style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 8),
                          Text('Zeeshan Daanish', style: TextStyle(color: Colors.white)),
                          Spacer(),
                          Icon(Icons.more_vert, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This app is ver.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
