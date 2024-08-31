import 'package:flutter/material.dart';
import 'package:nexplay/models/game_model.dart';

class ScreenShotDetail extends StatelessWidget {
  final GameModel game;
  final int index;

  const ScreenShotDetail({super.key, required this.game, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Image.network(
            game.shortScreenshots[index].image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
