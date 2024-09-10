import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/models/my_categories_model.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/pages/cart.dart';
import 'package:nexplay/pages/category_details.dart';
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => Get.to(() => CartPage()),
        backgroundColor: Colors.white,
        child: Badge(
          backgroundColor: Colors.red,
          label: Obx(() => Text(
                cartController.cartItems.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              )),
          child: const Icon(
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: FutureBuilder<List<CategoriesModel>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Skeletonizer(
                  effect: ShimmerEffect(
                    baseColor: Colors.grey.shade800,
                    highlightColor: Colors.grey.shade50,
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
                        color: Colors.grey.shade700,
                        child: const Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.white70,
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
