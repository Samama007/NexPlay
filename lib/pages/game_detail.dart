import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_model.dart';

class GameDetail extends StatefulWidget {
  final GameModel game;

  const GameDetail({super.key, required this.game});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  GameApi gameApi = GameApi();
  @override
  void initState() {
    super.initState();
    gameApi.fetchdetails(3498);
  }

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
                    widget.game.backgroundImage,
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
                    widget.game.name,
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
                            Text(widget.game.rating.toString(), style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                            SizedBox(width: 2),
                            Icon(Icons.star, color: Colors.white, size: 22)
                          ],
                        ),
                        Text('${widget.game.ratingsCount.toString()} reviews', style: TextStyle(fontSize: 14, color: Colors.white))
                      ],
                    ),
                  ),
                  VerticalDivider(color: Colors.white),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Icon(Icons.eighteen_up_rating_outlined, color: Colors.white, size: 35),
                      SizedBox(height: 2),
                      Text(widget.game.esrbRating.name, style: TextStyle(fontSize: 14, color: Colors.white))
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(
                    children: [
                      Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
                      SizedBox(height: 2),
                      Text('Playtime: ${widget.game.playtime.toString()} hours', style: TextStyle(fontSize: 14, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ',
            )
          ],
        ),
      ),
    );
  }
}
