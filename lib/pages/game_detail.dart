import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:nexplay/pages/cart.dart';
import 'package:nexplay/pages/ratings_page.dart';
import 'package:nexplay/pages/ss_detail.dart';
import '../controller/cart_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GameDetail extends StatefulWidget {
  final GameModel game;
  final String price;

  const GameDetail({super.key, required this.game, required this.price});

  @override
  State<GameDetail> createState() => _GameDetailState();
}

class _GameDetailState extends State<GameDetail> {
  GameApi gameApi = GameApi();
  DescriptionModel? description;
  bool isLoading = true;
  String price = '';
  CartController cartController = Get.find();

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    DescriptionModel fetchedDetails = await gameApi.fetchDescription(widget.game.id);
    setState(() {
      description = fetchedDetails;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: cartButton(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                gameCover(context),
                Padding(
                  padding: const EdgeInsets.only(top: 221),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    child: Container(
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
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          gameName(),
                          const SizedBox(height: 5),
                          summaryBar(),
                          const SizedBox(height: 12),
                          buyPage(),
                          const SizedBox(height: 12),
                          gameDescription(),
                          const SizedBox(height: 15),
                          ratings(),
                          const SizedBox(height: 15),
                          gameSS(),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Padding ratings() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
        child: Column(
          children: [
            Row(
              children: [
                isLoading ? Text(BoneMock.name) : const Text('Ratings and reviews', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500)),
                const Spacer(),
                IconButton(onPressed: () => Get.to(RatingsPage(id: widget.game.id)), icon: const Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 25))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      isLoading ? Text(BoneMock.name) : Text(widget.game.rating.toString(), style: const TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.w700)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: isLoading ? Text(BoneMock.name) : Text('${widget.game.ratingsCount.toString()} reviews', style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: RatingBar.readOnly(
                      filledIcon: Icons.star,
                      isHalfAllowed: true,
                      halfFilledColor: const Color.fromARGB(255, 255, 230, 7),
                      halfFilledIcon: Icons.star_half_sharp,
                      emptyIcon: Icons.star_border,
                      initialRating: widget.game.rating,
                      maxRating: 5,
                      size: 35,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton cartButton() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => CartPage()),
      backgroundColor: Colors.white,
      shape: const CircleBorder(eccentricity: 1),
      child: Badge(
        backgroundColor: Colors.red,
        label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Colors.white, fontSize: 13))),
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }

  Stack gameCover(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Image.network(
            widget.game.backgroundImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 220,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context),
          style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white38)),
        )
      ],
    );
  }

  Center gameSS() {
    return Center(
      child: isLoading
          ? Skeletonizer(
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(right: 15),
                child: Container(
                  height: Get.width,
                  width: 300,
                  color: Colors.grey.shade300,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 170,
                child: ListView.builder(
                    itemCount: widget.game.shortScreenshots.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenShotDetail(game: widget.game, index: index)));
                        },
                        child: Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.only(right: 15),
                          child: Image.network(
                            widget.game.shortScreenshots[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }

  Padding gameDescription() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('About this game', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            isLoading
                ? Text(BoneMock.paragraph, maxLines: 3)
                : AnimatedReadMoreText(
                    description!.description.toString(),
                    maxLines: 3,
                    textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                    buttonTextStyle: const TextStyle(fontSize: 16, color: Colors.red),
                  ),
          ],
        ),
      ),
    );
  }

  Padding buyPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.red),
            minimumSize: WidgetStatePropertyAll(
              Size(double.infinity, 50),
            )),
        onPressed: () {
          var newItem = CartItem(name: widget.game.name, price: double.parse(widget.price));
          cartController.addItem(newItem);
          Get.snackbar(
            newItem.name,
            'Added to cart',
            backgroundColor: Colors.black,
            duration: const Duration(seconds: 2),
            isDismissible: true,
            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
            snackPosition: SnackPosition.TOP,
            borderRadius: 15,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 10),
          );
        },
        child: Text('\$${widget.price}', style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Padding summaryBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Skeletonizer(
            enabled: isLoading,
            effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
            child: Row(
              children: [
                const Column(
                  children: [
                    SizedBox(height: 2),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.computer,
                          size: 27,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        FaIcon(
                          FontAwesomeIcons.playstation,
                          size: 27,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        FaIcon(
                          FontAwesomeIcons.xbox,
                          size: 27,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text('Available for', style: TextStyle(fontSize: 14, color: Colors.white))
                  ],
                ),
                const SizedBox(width: 10),
                Container(width: 2, height: 30, color: Colors.white),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Icon(Icons.eighteen_up_rating_outlined, color: Colors.white, size: 35),
                    const SizedBox(height: 2),
                    isLoading ? Text(BoneMock.subtitle) : Text(widget.game.esrbRating.name, style: const TextStyle(fontSize: 14, color: Colors.white))
                  ],
                ),
                const SizedBox(width: 20),
                Container(width: 2, height: 30, color: Colors.white),
                const SizedBox(width: 30),
                Column(
                  children: [
                    const Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
                    const SizedBox(height: 2),
                    Text('${widget.game.playtime.toString()} hours', style: const TextStyle(fontSize: 14, color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer gameName() {
    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
      child: ListTile(
        title: Center(child: Text(widget.game.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white))),
        subtitle: Row(
          children: [
            isLoading
                ? Text(BoneMock.subtitle)
                : Text(
                    description!.developers.first.name,
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
            const Spacer(),
            isLoading ? Text(BoneMock.subtitle) : Text(description!.released.year.toString(), style: const TextStyle(fontSize: 18, color: Colors.red))
          ],
        ),
      ),
    );
  }
}
