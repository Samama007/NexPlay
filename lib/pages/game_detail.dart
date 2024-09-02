import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/description_model.dart';
import 'package:nexplay/models/game_model.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:nexplay/pages/ss_detail.dart';

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
    DescriptionModel fetchedDetails = await gameApi.fetchDescription(widget.game.id);
    setState(() {
      description = fetchedDetails;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: TextButton(onPressed: () {}, child: Text('BUY')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.game.backgroundImage,
                    fit: BoxFit.cover,
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
              SizedBox(height: 12),
              ListTile(
                title: Text(
                  widget.game.name,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                subtitle: isLoading ? Center(child: CircularProgressIndicator()) : Text(description!.developers.first.name, style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    Column(
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
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text('About this game', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900)),
              ),
              // SizedBox(height: 5),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: AnimatedReadMoreText(
                        description!.description.toString(),
                        maxLines: 3,
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        buttonTextStyle: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    ),
              SizedBox(height: 15),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox(
                        width: double.infinity,
                        height: 170,
                        child: ListView.builder(
                            itemCount: widget.game.shortScreenshots.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenShotDetail(game: widget.game, index: index)));
                                },
                                child: Card(
                                  clipBehavior: Clip.hardEdge,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  margin: EdgeInsets.only(right: 15),
                                  child: Image.network(
                                    widget.game.shortScreenshots[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
