import 'package:flutter/material.dart';

class GameDetail extends StatelessWidget {
  final String image;
  final String name;

  const GameDetail({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Expanded(
              child: Column(
            children: [
              Image.network(
                image,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
              Center(
                  child: Text(
                name,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ],
          )),
        ),
      ),
    );
  }
}
