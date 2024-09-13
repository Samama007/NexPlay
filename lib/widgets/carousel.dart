import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/pages/game_detail.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameModel>>(
      future: GameApi().fetchGames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50),
            child: Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  BoneMock.longParagraph,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.28),
            child: CarouselView(
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
              shrinkExtent: 200,
              children: snapshot.data!
                  .map((game) => Card(
                        margin: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.black54,
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
