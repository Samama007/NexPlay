// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/models/released_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'package:get/get.dart';

class GameGraph extends StatefulWidget {
  const GameGraph({super.key});

  @override
  State<GameGraph> createState() => GgameGraphState();
}

class GgameGraphState extends State<GameGraph> {
  List<ReleasedModel> released = [];
  bool isLoading = true;

  @override
  void initState() {
    _fetchreleased();
    super.initState();
  }

  Future _fetchreleased() async {
    List<ReleasedModel> data = await GameApi().sortbyreleased();
    setState(() {
      released.addAll(data);
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
        maxHeight: 400,
        maxWidth: 400,
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
                    icon: Icon(Icons.new_label),
                    text: 'New & Trending',
                  ),
                  Tab(
                    icon: Icon(Icons.generating_tokens_outlined),
                    text: 'Top Sellers',
                  ),
                  Tab(
                    icon: Icon(Icons.brush),
                    text: 'Popular Upcoming',
                  ),
                ],
              ),
              SizedBox(
                height: 326,
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
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              String price = _getPrice();
                              var game = released[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
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
                                                width: 150,
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
                                              '${game.released.day}-${game.released.month}-${game.released.year}',
                                              style: TextStyle(
                                                color: foregroundColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Text("\$$price")
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
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
