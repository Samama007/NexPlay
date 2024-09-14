import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/pages/cart.dart';
import 'package:nexplay/pages/categories_page.dart';
import 'package:nexplay/widgets/search.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/categories.dart';

class ExplorePage extends StatefulWidget {
  final String username;
  const ExplorePage({super.key, required this.username});

  @override
  State<ExplorePage> createState() => _ExplorePagState();
}

class _ExplorePagState extends State<ExplorePage> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 10, top: 20),
                  child: Row(
                    children: [
                      const Text("Welcome,", style: TextStyle(color: Colors.white, fontSize: 22)),
                      const SizedBox(width: 5),
                      Text(widget.username, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: Badge(
                            backgroundColor: Colors.red,
                            label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Colors.white, fontSize: 13))),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () => Get.to(() => CartPage()),
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 30,
                                )),
                          ))
                    ],
                  ),
                ),
                const SearchBarr(),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    'Trending now',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 20),
                  child: MyCarousel(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Categories',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesPage())),
                        child: const Text(
                          'View all',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Categories(),
                ),
              ],
            ),
          ),
        ));
  }
}
