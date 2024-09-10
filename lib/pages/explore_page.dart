// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/cart_controller.dart';
import 'package:nexplay/pages/cart.dart';
import 'package:nexplay/pages/categories_page.dart';
import 'package:nexplay/widgets/carousel.dart';
import 'package:nexplay/widgets/categories.dart';
import 'package:nexplay/widgets/search_bar.dart';

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
                      Text("Welcome,", style: TextStyle(color: Colors.white, fontSize: 22)),
                      SizedBox(width: 5),
                      Text(widget.username, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 22),
                          child: Badge(
                            backgroundColor: Colors.red,
                            label: Obx(() => Text(cartController.cartItems.length.toString(), style: TextStyle(color: Colors.white, fontSize: 13))),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () => Get.to(() => CartPage()),
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 30,
                                )),
                          ))
                    ],
                  ),
                ),
                Mysearchbar(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Trending now',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: MyCarousel(),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: Row(
                    children: [
                      Text(
                        'Categories',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage())),
                        child: Text(
                          'View all',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Categories(),
                ),
              ],
            ),
          ),
        ));
  }
}
