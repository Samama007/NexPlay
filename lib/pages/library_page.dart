import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/library_controller.dart';
import 'package:nexplay/models/my_game_model.dart' as gamemodel;
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/pages/game_detail.dart';

class FavoriteProductsScreen extends StatelessWidget {
  final LibraryController _libraryController = Get.find();

  FavoriteProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(child: Text("Favorite")),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: _libraryController.isLibraryEmpty.value
                ? GridView.builder(
                    itemCount: _libraryController.libraryItems.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      double width = 140;
                      double aspectRetio = 1.02;
                      final item = _libraryController.libraryItems[index];
                      if (_libraryController.libraryItems.isNotEmpty) {
                        return InkWell(
                          onTap: () {
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
                          child: SizedBox(
                            width: width,
                            child: GestureDetector(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AspectRatio(
                                    aspectRatio: aspectRetio,
                                    child: Container(
                                      // padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF979797).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Hero(
                                        tag: '${item.id}',
                                        child: Image.network(
                                          item.backgroundImage,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item.name,
                                    style: Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return null;
                    })
                : const Center(child: Text('BUY SOME GAMES FIRST'))),
      ),
    );
  }
}
