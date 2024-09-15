// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nexplay/api/api_service.dart';
// import 'package:nexplay/controller/cart_controller.dart';
// import 'package:nexplay/models/my_category_description.dart';
// import 'package:nexplay/models/price_model.dart';
// import 'package:nexplay/pages/cart.dart';
// import 'package:nexplay/pages/game_detail.dart';
// import 'package:skeletonizer/skeletonizer.dart';
// import 'package:nexplay/models/my_category_description.dart' as cd;
// import 'package:nexplay/models/my_game_model.dart' as gm;

// class CatDetails extends StatefulWidget {
//   final int id;
//   const CatDetails({super.key, required this.id});

//   @override
//   State<CatDetails> createState() => _CatDetailsState();
// }

// class _CatDetailsState extends State<CatDetails> {
//   List<CategoryDescriptionModel> categoryList = [];
//   CartController cartController = Get.find();
//   int pageNumber = 1;
//   final _scrollController = ScrollController();
//   bool isLoading = true;
//   bool isPaginating = false;

//   @override
//   void initState() {
//     super.initState();
//     _populateCategoryDetails(pageNumber);

//     _scrollController.addListener(() {
//       if (_scrollController.position.maxScrollExtent == _scrollController.offset && !isPaginating) {
//         pageNumber++;
//         _populateCategoryDetails(pageNumber);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   Future<void> _populateCategoryDetails(int page) async {
//     setState(() {
//       if (page == 1) {
//         isLoading = true;
//       } else {
//         isPaginating = true;
//       }
//     });

//     List<CategoryDescriptionModel> data = await GameApi().fetchCateDetails(widget.id, page);

//     setState(() {
//       categoryList.addAll(data);
//       isLoading = false;
//       isPaginating = false;
//     });
//   }

// static gm.GameModel convertCategoryToGame(cd.CategoryDescriptionModel category) {
//   return gm.GameModel(
//     id: category.id,
//     name: category.name,
//     backgroundImage: category.backgroundImage,
//     released: category.released,
//     playtime: category.playtime,
//     ratingsCount: category.ratingsCount,
//     rating: category.rating,
//     shortScreenshots: category.shortScreenshots.map(convertScreenshot).toList(),
//     esrbRating: category.esrbRating != null
//         ? gm.EsrbRating(
//             id: category.esrbRating!.id,
//             name: category.esrbRating!.name,
//             slug: category.esrbRating!.slug,
//           )
//         : gm.EsrbRating(id: 0, name: "Unknown", slug: "unknown"),
//   );
// }

// static gm.ShortScreenshot convertScreenshot(cd.ShortScreenshot screenshot) {
//   return gm.ShortScreenshot(id: screenshot.id, image: screenshot.image);
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         bottomOpacity: 0,
//         toolbarHeight: 32,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Get.to(() => CartPage()),
//         backgroundColor: Colors.white,
//         shape: const CircleBorder(),
//         child: Badge(
//           backgroundColor: Colors.red,
//           label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Colors.white, fontSize: 13))),
//           child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.black),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Colors.black,
//               Colors.deepPurple.shade900
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 10),
//           child: Column(
//             children: [
//               Expanded(
//                 child: isLoading
//                     ? Skeletonizer(
//                         effect: ShimmerEffect(
//                           baseColor: Colors.grey.shade400,
//                           highlightColor: Colors.grey.shade50,
//                         ),
//                         child: ListView.builder(
//                           itemCount: 10,
//                           itemBuilder: (context, index) => Card(
//                             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.all(16),
//                               title: Container(
//                                 height: 20,
//                                 width: 100,
//                                 color: Colors.grey.shade300,
//                               ),
//                               subtitle: Row(
//                                 children: [
//                                   Container(
//                                     height: 15,
//                                     width: 60,
//                                     color: Colors.grey.shade300,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   const Icon(Icons.star, color: Colors.yellow, size: 15),
//                                 ],
//                               ),
//                               trailing: Container(
//                                 height: 50,
//                                 width: 50,
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     : ListView.builder(
//                         controller: _scrollController,
//                         itemCount: categoryList.length + (isPaginating ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (index < categoryList.length) {
//                             final game = convertCategoryToGame(categoryList[index]);
//                             return InkWell(
//                               onTap: () {
//                                 PriceModel priceModel = PriceModel();
//                                 Random random = Random();
//                                 int randomIndex = random.nextInt(100);
//                                 String price = priceModel.price[randomIndex].toString();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(builder: (context) => GameDetail(game: game, price: price)),
//                                 );
//                               },
//                               child: Card(
//                                 color: Colors.blue.shade800,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 margin: const EdgeInsets.symmetric(vertical: 12),
//                                 elevation: 6,
//                                 child: ListTile(
//                                   contentPadding: const EdgeInsets.all(16),
//                                   title: Text(
//                                     game.name,
//                                     textAlign: TextAlign.start,
//                                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                                   ),
//                                   subtitle: Row(
//                                     children: [
//                                       Text(
//                                         game.rating.toString(),
//                                         style: const TextStyle(color: Colors.white70, fontSize: 20),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       const Icon(Icons.star, color: Colors.yellow, size: 18),
//                                     ],
//                                   ),
//                                   trailing: ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: Hero(
//                                       tag: '${game.id}',
//                                       child: Image.network(
//                                         game.backgroundImage,
//                                         height: double.infinity,
//                                         width: 150,
//                                         fit: BoxFit.fitWidth,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 32),
//                               child: Center(child: CircularProgressIndicator()),
//                             );
//                           }
//                         },
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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

class CatDetails extends StatefulWidget {
  final int id;
  const CatDetails({super.key, required this.id});

  @override
  State<CatDetails> createState() => _CatDetailsState();
}

class _CatDetailsState extends State<CatDetails> {
  List<CategoryDescriptionModel> categoryList = [];
  CartController cartController = Get.find();
  int pageNumber = 1;
  final _scrollController = ScrollController();
  bool isLoading = true;
  bool isPaginating = false;

  @override
  void initState() {
    super.initState();
    _populateCategoryDetails(pageNumber);

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.offset && !isPaginating) {
        pageNumber++;
        _populateCategoryDetails(pageNumber);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _populateCategoryDetails(int page) async {
    setState(() {
      if (page == 1) {
        isLoading = true;
      } else {
        isPaginating = true;
      }
    });

    List<CategoryDescriptionModel> data = await GameApi().fetchCateDetails(widget.id, page);

    setState(() {
      categoryList.addAll(data);
      isLoading = false;
      isPaginating = false;
    });
  }

  static gm.GameModel convertCategoryToGame(cd.CategoryDescriptionModel category) {
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

  static gm.ShortScreenshot convertScreenshot(cd.ShortScreenshot screenshot) {
    return gm.ShortScreenshot(id: screenshot.id, image: screenshot.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CartPage()),
        backgroundColor: Colors.red,
        child: Badge(
          backgroundColor: Colors.white,
          label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold))),
          child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.deepPurple.shade900
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Text(
            //     'Game Category',
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontSize: 28,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Expanded(
              child: isLoading
                  ? _buildSkeletonLoader()
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: categoryList.length + (isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < categoryList.length) {
                          return _buildGameCard(convertCategoryToGame(categoryList[index]));
                        } else {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade600,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => _buildSkeletonCard(),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Container(height: 24, color: Colors.grey.shade800),
        subtitle: Container(height: 16, color: Colors.grey.shade800),
        trailing: Container(height: 80, width: 80, color: Colors.grey.shade800),
      ),
    );
  }

  Widget _buildGameCard(gm.GameModel game) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.blue.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _navigateToGameDetail(game),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Hero(
                tag: '${game.id}',
                child: Image.network(
                  game.backgroundImage,
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToGameDetail(gm.GameModel game) {
    PriceModel priceModel = PriceModel();
    Random random = Random();
    int randomIndex = random.nextInt(100);
    String price = priceModel.price[randomIndex].toString();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetail(game: game, price: price)),
    );
  }
}
