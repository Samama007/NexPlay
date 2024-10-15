import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nexplay/services/api/api_service.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/views/pages/game_detail.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:get/get.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color backgroundColor = Theme.of(context).primaryColor;
    // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return FutureBuilder<List<GameModel>>(
      future: GameApi().fetchGames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            effect: ShimmerEffect(baseColor: backgroundColor, highlightColor: foregroundColor),
            child: Card(
              margin: const EdgeInsets.all(10),
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.28,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: foregroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      BoneMock.longParagraph,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.03),
                  Container(
                    width: Get.width * 0.23,
                    height: MediaQuery.of(context).size.height * 0.28,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: foregroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      BoneMock.longParagraph,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.28),
            child: CarouselView(
              backgroundColor: foregroundColor,
              onTap: (value) {
                PriceModel priceModel = PriceModel();
                Random random = Random();
                int index = random.nextInt(100);
                String price = priceModel.price[index].toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetail(
                      game: snapshot.data![value],
                      price: price,
                    ),
                  ),
                );
              },
              itemExtent: 280,
              shrinkExtent: 230,
              children: snapshot.data!
                  .map((game) => Card(
                        margin: const EdgeInsets.all(10),
                        color: foregroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                game.backgroundImage,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: foregroundColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                game.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
