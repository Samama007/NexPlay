// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/bestseller_model.dart' as bs;
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/models/released_model.dart';
import 'package:nexplay/pages/game_detail.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'package:get/get.dart';

class GameGraph extends StatefulWidget {
  const GameGraph({super.key});

  @override
  State<GameGraph> createState() => GgameGraphState();
}

class GgameGraphState extends State<GameGraph> {
  List<ReleasedModel> released = [];
  List<bs.BestsellerModel> bestSeller = [];
  // List<ReleasedModel> popularUpcoming = [];
  bool isLoading = true;

  @override
  void initState() {
    _fetchreleased();
    _fetchBestSeller();
    super.initState();
  }

  Future _fetchreleased() async {
    List<ReleasedModel> data = await GameApi().sortbyreleased();
    setState(() {
      released.addAll(data);
      isLoading = false;
    });
  }

  Future _fetchBestSeller() async {
    List<bs.BestsellerModel> data = await GameApi().sortbyBestSeller();
    setState(() {
      bestSeller.addAll(data);
      isLoading = false;
    });
  }

  String _getPrice() {
    PriceModel priceModel = PriceModel();
    Random random = Random();
    int randomIndex = random.nextInt(100);
    String price = priceModel.price[randomIndex].toString();
    return price;
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 800,
        maxWidth: Get.width,
      ),
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: ColoredBox(
          color: foregroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                indicatorColor: tertiaryColor,
                labelStyle: TextStyle(color: backgroundColor),
                unselectedLabelStyle: TextStyle(color: backgroundColor),
                tabs: [
                  Tab(
                    icon: Icon(Icons.generating_tokens_outlined),
                    text: 'Best Sellers',
                  ),
                  Tab(
                    icon: Icon(Icons.new_label),
                    text: 'New & Trending',
                  ),
                  Tab(
                    icon: Icon(Icons.brush),
                    text: 'Popular Upcoming',
                  ),
                ],
              ),
              SizedBox(
                height: 500,
                child: TabBarView(children: [
                  Skeletonizer(
                    enabled: isLoading,
                    effect: ShimmerEffect(
                      baseColor: backgroundColor,
                      highlightColor: foregroundColor,
                      duration: const Duration(seconds: 1),
                    ),
                    child: isLoading
                        ? ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) => ListTile(
                              leading: Container(height: 100, width: 100, color: tertiaryColor),
                              title: Container(width: 80, height: 20, color: Colors.grey),
                              subtitle: Container(width: 60, height: 16, color: Colors.grey.shade300),
                              trailing: Container(width: 40, height: 20, color: Colors.grey.shade300),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: bestSeller.length,
                            itemBuilder: (context, index) {
                              String price = _getPrice();
                              var game = bestSeller[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      DescriptionModel description = await GameApi().fetchDescription(game.id);
                                      GameModel gameModel = GameModel(
                                        id: description.id,
                                        name: description.name,
                                        backgroundImage: description.backgroundImage ?? '',
                                        rating: description.ratings.isNotEmpty ? description.ratings[0].percent : 0.0,
                                        released: description.released ?? DateTime.now(),
                                        playtime: 0,
                                        ratingsCount: description.ratings.isNotEmpty ? description.ratings[0].count : 0,
                                        shortScreenshots: [],
                                        esrbRating: EsrbRating(id: 0, name: 'Unknown', slug: 'unknown'),
                                      );
                                      Get.to(() => GameDetail(game: gameModel, price: (double.parse(price) / 2).toStringAsFixed(2)));
                                      // Get.to(() => GameDetail(game: gameModel, price: price));
                                    } catch (e) {
                                      Get.snackbar(
                                        'Error',
                                        e.toString(),
                                        backgroundColor: backgroundColor,
                                        colorText: foregroundColor,
                                      );
                                      throw Exception(e);
                                    }
                                  },
                                  child: Container(
                                    color: backgroundColor,
                                    child: Row(
                                      children: [
                                        game.backgroundImage != null
                                            ? Image.network(
                                                game.backgroundImage!,
                                                fit: BoxFit.cover,
                                                height: 100,
                                                width: 150,
                                              )
                                            : Container(
                                                height: 100,
                                                width: 150,
                                                color: Colors.grey,
                                                child: Icon(Icons.image_not_supported, size: 40, color: Colors.white),
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 150,
                                                  child: Text(
                                                    game.name!,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: foregroundColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                              SizedBox(height: 10),
                                              Text(
                                                '${game.released!.day}-${game.released!.month}-${game.released!.year}',
                                                style: TextStyle(
                                                  color: foregroundColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: [
                                              Text("\$$price",
                                                  style: TextStyle(
                                                    color: foregroundColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    decoration: TextDecoration.combine([
                                                      TextDecoration.lineThrough
                                                    ]),
                                                    decorationColor: tertiaryColor,
                                                    decorationThickness: 7,
                                                  )),
                                              Text("\$${(double.parse(price) / 2).toStringAsFixed(2)}", style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Skeletonizer(
                    enabled: isLoading,
                    effect: ShimmerEffect(
                      baseColor: backgroundColor,
                      highlightColor: foregroundColor,
                      duration: const Duration(seconds: 1),
                    ),
                    child: isLoading
                        ? ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) => ListTile(
                              leading: Container(height: 100, width: 100, color: tertiaryColor),
                              title: Container(width: 80, height: 20, color: Colors.grey),
                              subtitle: Container(width: 60, height: 16, color: Colors.grey.shade300),
                              trailing: Container(width: 40, height: 20, color: Colors.grey.shade300),
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: released.length,
                            itemBuilder: (context, index) {
                              String price = _getPrice();
                              var game = released[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                child: InkWell(
                                  onTap: () async {
                                    try {
                                      DescriptionModel description = await GameApi().fetchDescription(game.id);
                                      GameModel gameModel = GameModel(
                                        id: description.id,
                                        name: description.name,
                                        backgroundImage: description.backgroundImage ?? '',
                                        rating: description.ratings.isNotEmpty ? description.ratings[0].percent : 0.0,
                                        released: description.released ?? DateTime.now(),
                                        playtime: 0,
                                        ratingsCount: description.ratings.isNotEmpty ? description.ratings[0].count : 0,
                                        shortScreenshots: [],
                                        esrbRating: EsrbRating(id: 0, name: 'Unknown', slug: 'unknown'),
                                      );
                                      Get.to(() => GameDetail(game: gameModel, price: (double.parse(price) / 2).toStringAsFixed(2)));
                                      // Get.to(() => GameDetail(game: gameModel, price: price));
                                    } catch (e) {
                                      Get.snackbar(
                                        'Error',
                                        e.toString(),
                                        backgroundColor: backgroundColor,
                                        colorText: foregroundColor,
                                      );
                                      throw Exception(e);
                                    }
                                  },
                                  child: Container(
                                    color: backgroundColor,
                                    child: Row(
                                      children: [
                                        Image.network(
                                          game.backgroundImage,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: 150,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    game.name,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: foregroundColor,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )),
                                              SizedBox(height: 10),
                                              Text(
                                                '${game.released.day}-${game.released.month}-2024',
                                                style: TextStyle(
                                                  color: foregroundColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Column(
                                            children: [
                                              Text("\$$price",
                                                  style: TextStyle(
                                                    color: foregroundColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    decoration: TextDecoration.combine([
                                                      TextDecoration.lineThrough
                                                    ]),
                                                    decorationColor: tertiaryColor,
                                                    decorationThickness: 7,
                                                  )),
                                              Text("\$${(double.parse(price) / 2).toStringAsFixed(2)}", style: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold, fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Card(
                        color: backgroundColor,
                        child: ListTile(
                          // leading: Image.network('src'),
                          title: Text('name'),
                          subtitle: Text('esrb'),
                          trailing: Text('price'),
                        ),
                      );
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
