import 'package:flutter/material.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ScreenShotDetail extends StatelessWidget {
  final GameModel game;
  final int index;

  const ScreenShotDetail({super.key, required this.game, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PinchZoom(
          maxScale: 5,
          child: Hero(
            tag: '${game.shortScreenshots[index].id}',
            child: Image.network(
              game.shortScreenshots[index].image,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
