import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
// import 'package:nexplay/pages/cart.dart';
import 'package:nexplay/pages/categories_page.dart';
import 'package:nexplay/widgets/search.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/categories.dart';

class ExplorePage extends StatelessWidget {
  final String username;
  ExplorePage({super.key, required this.username});

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF1B2838),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Welcome, $username', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
              background: Image.asset(
                'assets/images/ss1.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarr(),
                  const SizedBox(height: 24),
                  const Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const MyCarousel(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const CategoriesPage()),
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Color(0xFF66C0F4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Categories(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
