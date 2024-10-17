// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/views/pages/cart.dart';
import 'package:nexplay/views/pages/categories_page.dart';
import 'package:nexplay/views/pages/dev_hub.dart';
import 'package:nexplay/views/pages/graph.dart';
import 'package:nexplay/views/widgets/search.dart';
import 'package:nexplay/views/widgets/carousel.dart';
import 'package:nexplay/views/widgets/categories.dart';

class ExplorePage extends StatelessWidget {
  final String username;
  ExplorePage({super.key, required this.username});
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            // automaticallyImplyLeading: false,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('Welcome, $username', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                ]),
                background: Image.asset('assets/images/ss3.png', fit: BoxFit.fitWidth)),
            backgroundColor: foregroundColor,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SearchBarr(),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.to(() => CartPage()),
                        child: Badge(
                          backgroundColor: tertiaryColor,
                          label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Color(0xFFF1D3B2), fontSize: 14, fontWeight: FontWeight.bold))),
                          child: Icon(Icons.shopping_cart_outlined, size: 40, color: foregroundColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: foregroundColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const MyCarousel(),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Browse by Category', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: foregroundColor)),
                      TextButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(foregroundColor)),
                        onPressed: () => Get.to(() => const CategoriesPage()),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: backgroundColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Categories(),
                  const SizedBox(height: 16),
                  Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(50, 50),
                        bottomRight: Radius.elliptical(50, 50),
                      ),
                      child: InkWell(onTap: () => Get.to(() => DevelopersPage()), child: Image.asset('assets/images/dev.png')),
                    ),
                    Positioned(
                        top: 115,
                        left: 12,
                        child: Text(
                          'DEVELEPORS HUB',
                          style: TextStyle(
                            color: Color(0xFFF1D3B2),
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        )),
                  ]),
                  const SizedBox(height: 25),
                  GameGraph(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
