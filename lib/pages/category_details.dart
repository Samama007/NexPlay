import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_category_description.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/pages/game_detail.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:nexplay/models/my_category_description.dart' as cd;
import 'package:nexplay/models/my_game_model.dart' as gm;

gm.ShortScreenshot convertScreenshot(cd.ShortScreenshot screenshot) {
  return gm.ShortScreenshot(id: screenshot.id, image: screenshot.image);
}

class CatDetails extends StatefulWidget {
  final int id;
  const CatDetails({super.key, required this.id});

  @override
  State<CatDetails> createState() => _CatDetailsState();
}

class _CatDetailsState extends State<CatDetails> {
  late Future<List<CategoryDescriptionModel>> categoryDescriptionModel;

  @override
  void initState() {
    super.initState();
    categoryDescriptionModel = GameApi().fetchCateDetails(widget.id);
  }

  gm.GameModel convertCategoryToGame(cd.CategoryDescriptionModel category) {
    return gm.GameModel(
      id: category.id,
      name: category.name,
      backgroundImage: category.backgroundImage,
      released: category.released,
      playtime: category.playtime,
      ratingsCount: category.ratingsCount,
      rating: category.rating,
      shortScreenshots: category.shortScreenshots.map(convertScreenshot).toList(),
      esrbRating: category.esrbRating != null
          ? gm.EsrbRating(
              id: category.esrbRating!.id,
              name: category.esrbRating!.name,
              slug: category.esrbRating!.slug,
            )
          : gm.EsrbRating(id: 0, name: "Unknown", slug: "unknown"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: FutureBuilder<List<CategoryDescriptionModel>>(
        future: categoryDescriptionModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
                effect: ShimmerEffect(baseColor: Colors.grey.shade800, highlightColor: Colors.grey.shade50),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      title: Text(BoneMock.name),
                      subtitle: Row(
                        children: [
                          Text(BoneMock.phone),
                          Skeleton.ignore(child: Icon(Icons.star, color: Colors.yellow, size: 15))
                        ],
                      ),
                      trailing: Text(BoneMock.title),
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final game = convertCategoryToGame(snapshot.data![index]);
                return InkWell(
                  onTap: () {
                    PriceModel priceModel = PriceModel();
                    Random random = Random();
                    int index = random.nextInt(100);
                    String price = priceModel.price[index].toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameDetail(game: game, price: price)),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(game.name),
                      subtitle: Row(
                        children: [
                          Text(game.rating.toString()),
                          Icon(Icons.star, color: Colors.yellow, size: 15)
                        ],
                      ),
                      trailing: Image.network(game.backgroundImage),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
