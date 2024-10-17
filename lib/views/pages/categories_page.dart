import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/models/my_categories_model.dart';
import 'package:nexplay/services/api/api_service.dart';
import 'package:nexplay/views/pages/cart.dart';
import 'package:nexplay/views/pages/category_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<CategoriesModel>> _categoriesFuture;
  CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
    _categoriesFuture = GameApi().fetchCategory();
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
        toolbarHeight: 40,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: foregroundColor,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CartPage()),
        backgroundColor: foregroundColor,
        child: Badge(
          backgroundColor: tertiaryColor,
          label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Color(0xFFF1D3B2), fontSize: 13, fontWeight: FontWeight.bold))),
          child: Icon(Icons.shopping_cart_outlined, size: 30, color: backgroundColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor,
              tertiaryColor,
              foregroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: FutureBuilder<List<CategoriesModel>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                  effect: ShimmerEffect(
                    baseColor: backgroundColor,
                    highlightColor: foregroundColor,
                  ),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 4 / 3,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        color: backgroundColor,
                        child: const Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load categories'));
              } else {
                var categories = snapshot.data!.first.results;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 4 / 3,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    var category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CatDetails(id: category.id),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                category.imageBackground,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                color: Colors.black.withOpacity(0.4),
                                colorBlendMode: BlendMode.darken,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Center(
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
