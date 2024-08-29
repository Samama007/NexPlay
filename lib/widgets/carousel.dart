import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_model.dart';

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
          // return ConstrainedBox(
          //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
          //   child: CarouselView(
          //     itemExtent: 330,
          //     children: snapshot.data!
          //         .map((game) => Card(
          //               margin: const EdgeInsets.all(10),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15),
          //               ),
          //               child: Stack(
          //                 alignment: Alignment.bottomCenter,
          //                 children: [
          //                   ClipRRect(
          //                     borderRadius: BorderRadius.circular(15),
          //                     child: Image.network(
          //                       game.backgroundImage,
          //                       width: double.infinity,
          //                       height: double.infinity,
          //                       fit: BoxFit.cover,
          //                     ),
          //                   ),
          //                   Container(
          //                     width: double.infinity,
          //                     padding: const EdgeInsets.all(8),
          //                     decoration: BoxDecoration(
          //                       color: Colors.black54,
          //                       borderRadius: BorderRadius.circular(15),
          //                     ),
          //                     child: Text(
          //                       game.name,
          //                       textAlign: TextAlign.center,
          //                       style: const TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 18,
          //                         fontWeight: FontWeight.bold,
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ))
          //         .toList(),
          //   ),
          // );

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
            child: CarouselView(
              itemExtent: 300,
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data![index].backgroundImage),
                        ),
                      ),
                      child: Text(snapshot.data![0].name),
                    );
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
