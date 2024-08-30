import 'package:flutter/material.dart';
import 'package:nexplay/models/my_model.dart';

class GameDetail extends StatelessWidget {
  final GameModel game;

  const GameDetail({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    game.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 25,
                  ),
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white38)),
                )
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: ListTile(
                title: Center(
                  child: Text(
                    game.name,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
                // subtitle: Padding(
                //   padding: const EdgeInsets.only(left: 2.0),
                //   child: Text(game.released.year.toString()),
                // ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(game.rating.toString(), style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2),
                            Icon(Icons.star, color: Colors.white, size: 17)
                          ],
                        ),
                        Text('${game.ratingsCount.toString()} reviews', style: TextStyle(fontSize: 14, color: Colors.white))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(color: Colors.white, thickness: 20, width: 20)
          ],
        ),
      ),
    );
  }
}
