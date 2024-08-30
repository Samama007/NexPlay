import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_model.dart';
import 'package:nexplay/pages/game_detail.dart';

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GameModel>>(
      future: GameApi().fetchGames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.28),
            child: CarouselView(
              onTap: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameDetail(
                      game: snapshot.data![value],
                      
                    ),
                  ),
                );
              },
              itemExtent: 370,
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
