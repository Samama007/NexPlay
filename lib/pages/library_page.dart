// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/library_controller.dart';
import 'package:nexplay/models/my_game_model.dart' as gamemodel;
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/pages/achievements.dart';
import 'package:nexplay/pages/game_detail.dart';

class Library extends StatelessWidget {
  final LibraryController _libraryController = Get.find();

  Library({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF46211A),
      appBar: AppBar(
        title: const Center(child: Text("Library", style: TextStyle(color: Color(0xFFF1D3B2), fontSize: 36, fontWeight: FontWeight.w900))),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _libraryController.isLibraryEmpty.value
            ? ListView.builder(
                itemCount: _libraryController.libraryItems.length,
                itemBuilder: (context, index) {
                  final item = _libraryController.libraryItems[index];
                  if (_libraryController.libraryItems.isNotEmpty) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ExpansionTile(
                        showTrailingIcon: false,
                        collapsedBackgroundColor: Color(0xFFA43820),
                        backgroundColor: Color(0xFFF1D3B2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(item.backgroundImage, height: 100, width: double.infinity, fit: BoxFit.cover, alignment: Alignment.topCenter),
                        ),
                        childrenPadding: EdgeInsets.all(20),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                      width: 150,
                                      child: Text(
                                        item.name.toString(),
                                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      )),
                                  Row(
                                    children: [
                                      Text('Played for ', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                      Text(item.playtime.toString(), style: TextStyle(color: Colors.red.shade500, fontSize: 18, fontWeight: FontWeight.w500)),
                                      Text(' hours', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(Color(0xFF46211A)),
                                    ),
                                    onPressed: () => Get.to(() => AchievementsPage(id: item.id)),
                                    child: Text('ACHIEVEMENTS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      minimumSize: WidgetStatePropertyAll(Size(130, 40)),
                                      backgroundColor: WidgetStatePropertyAll(Color(0xFF46211A)),
                                    ),
                                    onPressed: () {
                                      var game = _libraryController.libraryItems[index];
                                      PriceModel priceModel = PriceModel();
                                      Random random = Random();
                                      int randomIndex = random.nextInt(100);
                                      String price = priceModel.price[randomIndex].toString();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return (GameDetail(
                                          game: gamemodel.GameModel(
                                            id: game.id,
                                            name: game.name,
                                            backgroundImage: game.backgroundImage,
                                            released: game.released,
                                            playtime: game.playtime,
                                            ratingsCount: game.ratingsCount,
                                            rating: game.rating,
                                            shortScreenshots: game.shortScreenshots.map((screenshot) => gamemodel.ShortScreenshot(id: screenshot.id, image: screenshot.image)).toList(),
                                            esrbRating: gamemodel.EsrbRating(id: game.esrbRating.id, name: game.esrbRating.name, slug: game.esrbRating.slug),
                                          ),
                                          price: price,
                                        ));
                                      }));
                                    },
                                    child: Text('STORE PAGE', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  return null;
                })
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(
                    'assets/svg/no_game.svg',
                    height: 350,
                    width: Get.width * 0.8,
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Uhhh, no games bought yet. 🙊',
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color(0xFFF1D3B2), fontStyle: FontStyle.normal),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
