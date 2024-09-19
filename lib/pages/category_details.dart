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
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: foregroundColor, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CartPage()),
        backgroundColor: backgroundColor,
        child: Badge(
          backgroundColor: tertiaryColor,
          label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Color(0xFFF1D3B2), fontSize: 13, fontWeight: FontWeight.bold))),
          child: Icon(Icons.shopping_cart_outlined, size: 30, color: foregroundColor),
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Container(height: 24, color: foregroundColor),
        subtitle: Container(height: 16, color: foregroundColor),
        trailing: Container(height: 80, width: 80, color: foregroundColor),
      ),
    );
  }

  Widget _buildGameCard(gm.GameModel game) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: foregroundColor,
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: backgroundColor),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          game.rating.toStringAsFixed(1),
                          style: TextStyle(color: backgroundColor, fontSize: 16),
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
