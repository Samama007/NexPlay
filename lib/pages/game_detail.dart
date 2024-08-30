import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/description_model.dart';
import 'package:nexplay/models/game_model.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';

class GameDetail extends StatefulWidget {
  final GameModel game;

  const GameDetail({super.key, required this.game});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  GameApi gameApi = GameApi();
  DescriptionModel? description;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    List<DescriptionModel> fetchedDetails = await gameApi.fetchdetails(widget.game.id);
    setState(() {
      description = fetchedDetails.first;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Stack(
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
            ),
            SizedBox(height: 12),
            Center(
              child: ListTile(
                title: Text(
                  widget.game.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                subtitle: isLoading ? Center(child: CircularProgressIndicator()) : Text(description!.developers.first.name, style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
            ),
            // SizedBox(height: 1),
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
                  // VerticalDivider(color: Colors.white),
                  SizedBox(width: 30),
                  Container(width: 2, height: 30, color: Colors.white),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Icon(Icons.eighteen_up_rating_outlined, color: Colors.white, size: 35),
                      SizedBox(height: 2),
                      Text(widget.game.esrbRating.name, style: TextStyle(fontSize: 14, color: Colors.white))
                    ],
                  ),
                  SizedBox(width: 30),
                  Container(width: 2, height: 30, color: Colors.white),
                  SizedBox(width: 30),
                  Column(
                    children: [
                      Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
                      SizedBox(height: 2),
                      Text('${widget.game.playtime.toString()} hours', style: TextStyle(fontSize: 14, color: Colors.white))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text('About this game', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: AnimatedReadMoreText(
                      description!.description.toString(),
                      maxLines: 6,
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      buttonTextStyle: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ),
          ]),
        ),
      ),
    );
  }
}
