import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ScreenShotDetail extends StatelessWidget {
  final GameModel game;
  final int index;

  const ScreenShotDetail({super.key, required this.game, required this.index});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, color: foregroundColor, size: 25), onPressed: () => Get.back()),
      ),
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
