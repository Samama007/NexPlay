import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/models/my_category_description.dart';
import 'package:nexplay/models/price_model.dart';
import 'package:nexplay/pages/cart.dart';
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
  CartController cartController = Get.find();

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
      ratings: category.ratings.map((rating) => gm.Rating(id: rating.id, title: rating.title, count: rating.count, percent: rating.percent)).toList(),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        toolbarHeight: 32,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CartPage()),
        backgroundColor: Colors.white,
        shape: CircleBorder(eccentricity: 1),
        child: Badge(
          backgroundColor: Colors.red,
          label: Obx(() => Text(cartController.cartItems.length.toString(), style: TextStyle(color: Colors.white, fontSize: 13))),
          child: Icon(
            Icons.shopping_cart_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.deepPurple.shade900,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: FutureBuilder<List<CategoryDescriptionModel>>(
            future: categoryDescriptionModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                  effect: ShimmerEffect(
                    baseColor: Colors.grey.shade800,
                    highlightColor: Colors.grey.shade50,
                  ),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Container(
                          height: 20,
                          width: 100,
                          color: Colors.grey.shade300,
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              height: 15,
                              width: 60,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.star, color: Colors.yellow, size: 15),
                          ],
                        ),
                        trailing: Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 6,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            game.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                game.rating.toString(),
                                style: const TextStyle(color: Colors.white70, fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.star, color: Colors.yellow, size: 15),
                            ],
                          ),
                          trailing: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              game.backgroundImage,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
