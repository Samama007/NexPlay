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
import '../controller/cart_controller.dart' as cartitem;
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
  cartitem.CartController cartController = Get.find();

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
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: cart(backgroundColor, tertiaryColor, foregroundColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35, bottom: 10),
          child: Column(children: [
            Stack(children: [
              gameCover(context, backgroundColor, foregroundColor),
              Padding(
                padding: const EdgeInsets.only(top: 221),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      gameName(foregroundColor, tertiaryColor),
                      const SizedBox(height: 5),
                      summaryBar(foregroundColor),
                      const SizedBox(height: 12),
                      buyPage(foregroundColor, context, backgroundColor),
                      const SizedBox(height: 12),
                      gameDescription(foregroundColor, tertiaryColor),
                      const SizedBox(height: 15),
                      ratings(foregroundColor, tertiaryColor),
                      const SizedBox(height: 15),
                      gameSS(),
                      const SizedBox(height: 15),
                      
                    ],
                  ),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Padding ratings(Color foregroundColor, Color tertiaryColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
        child: Column(
          children: [
            Row(
              children: [
                isLoading ? Text(BoneMock.name) : Text('Ratings and reviews', style: TextStyle(fontSize: 20, color: foregroundColor, fontWeight: FontWeight.w500)),
                const Spacer(),
                IconButton(onPressed: () => Get.to(() => RatingsPage(id: widget.game.id)), icon: Icon(Icons.arrow_forward_outlined, color: foregroundColor, size: 25))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      isLoading ? Text(BoneMock.name) : Text(widget.game.rating.toString(), style: TextStyle(fontSize: 60, color: foregroundColor, fontWeight: FontWeight.w700)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: isLoading ? Text(BoneMock.name) : Text('${widget.game.ratingsCount.toString()} reviews', style: TextStyle(fontSize: 16, color: foregroundColor, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: RatingBar.readOnly(
                      filledIcon: Icons.star,
                      isHalfAllowed: true,
                      filledColor: foregroundColor,
                      halfFilledColor: tertiaryColor,
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

  Padding gameDescription(Color foregroundColor, Color tertiaryColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Skeletonizer(
        enabled: isLoading,
        effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('About this game', style: TextStyle(fontSize: 20, color: foregroundColor, fontWeight: FontWeight.w900)),
            ),
            const SizedBox(height: 5),
            isLoading
                ? Text(BoneMock.paragraph, maxLines: 3)
                : AnimatedReadMoreText(
                    description!.description.replaceAll('<p>', '').replaceAll('<br />', '\n').replaceAll('</p>', '').toString(),
                    maxLines: 3,
                    textStyle: TextStyle(fontSize: 16, color: foregroundColor),
                    buttonTextStyle: TextStyle(fontSize: 16, color: tertiaryColor),
                  ),
          ],
        ),
      ),
    );
  }

  Padding buyPage(Color foregroundColor, BuildContext context, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          TextButton(
            style: ButtonStyle(
                shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)))),
                backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
                side: WidgetStatePropertyAll(BorderSide(color: foregroundColor)),
                minimumSize: WidgetStatePropertyAll(
                  Size(Get.width * 0.4, 50),
                )),
            onPressed: () {},
            child: Text('\$${widget.price}', style: TextStyle(fontSize: 25, color: foregroundColor)),
          ),
          TextButton(
            style: ButtonStyle(shape: const WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20)))), backgroundColor: WidgetStatePropertyAll(foregroundColor), minimumSize: WidgetStatePropertyAll(Size(Get.width * 0.5, 50))),
            onPressed: () {
              var newItem = cartitem.CartItem(
                name: widget.game.name,
                price: double.parse(widget.price),
                backgroundImage: widget.game.backgroundImage,
                rating: widget.game.rating,
                released: widget.game.released,
                playtime: widget.game.playtime,
                ratingsCount: widget.game.ratingsCount,
                id: widget.game.id,
                esrbRating: cartitem.EsrbRating(id: widget.game.esrbRating.id, name: widget.game.esrbRating.name, slug: widget.game.esrbRating.slug),
                shortScreenshots: widget.game.shortScreenshots.map((screenshot) => cartitem.ShortScreenshot(id: screenshot.id, image: screenshot.image)).toList(),
              );
              cartController.addItem(newItem);
              Get.snackbar(
                newItem.name,
                'Added to cart',
                backgroundColor: backgroundColor,
                duration: const Duration(seconds: 2),
                isDismissible: true,
                maxWidth: MediaQuery.sizeOf(context).width * 0.8,
                snackPosition: SnackPosition.TOP,
                borderRadius: 15,
                colorText: foregroundColor,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              );
            },
            child: Text('Add to Cart', style: TextStyle(fontSize: 25, color: backgroundColor)),
          ),
        ],
      ),
    );
  }

  Padding summaryBar(Color foregroundColor) {
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
                Column(
                  children: [
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.computer,
                          size: 27,
                          color: foregroundColor,
                        ),
                        const SizedBox(width: 10),
                        FaIcon(
                          FontAwesomeIcons.playstation,
                          size: 27,
                          color: foregroundColor,
                        ),
                        const SizedBox(width: 10),
                        FaIcon(
                          FontAwesomeIcons.xbox,
                          size: 27,
                          color: foregroundColor,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text('Available for', style: TextStyle(fontSize: 14, color: foregroundColor))
                  ],
                ),
                const SizedBox(width: 10),
                Container(width: 2, height: 30, color: foregroundColor),
                const SizedBox(width: 20),
                Column(
                  children: [
                    Icon(Icons.eighteen_up_rating_outlined, color: foregroundColor, size: 35),
                    const SizedBox(height: 2),
                    isLoading ? Text(BoneMock.subtitle) : Text(widget.game.esrbRating.name, style: TextStyle(fontSize: 14, color: foregroundColor))
                  ],
                ),
                const SizedBox(width: 20),
                Container(width: 2, height: 30, color: foregroundColor),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Icon(Icons.hourglass_bottom, color: foregroundColor, size: 35),
                    const SizedBox(height: 2),
                    Text('${widget.game.playtime.toString()} hours', style: TextStyle(fontSize: 14, color: foregroundColor))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer gameName(Color foregroundColor, Color tertiaryColor) {
    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(baseColor: Colors.grey.shade400, highlightColor: Colors.grey.shade50, duration: const Duration(seconds: 1)),
      child: ListTile(
        title: Center(child: Text(widget.game.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: foregroundColor))),
        subtitle: Row(
          children: [
            isLoading
                ? Text(BoneMock.subtitle)
                : Text(
                    description!.developers.first.name,
                    style: TextStyle(fontSize: 18, color: tertiaryColor),
                  ),
            const Spacer(),
            isLoading ? Text(BoneMock.subtitle) : Text(description!.released!.year.toString(), style: TextStyle(fontSize: 18, color: tertiaryColor))
          ],
        ),
      ),
    );
  }

  FloatingActionButton cart(Color backgroundColor, Color tertiaryColor, Color foregroundColor) {
    return FloatingActionButton(
      onPressed: () => Get.to(() => CartPage()),
      backgroundColor: foregroundColor,
      child: Badge(
        backgroundColor: tertiaryColor,
        label: Obx(() => Text(cartController.cartItems.length.toString(), style: const TextStyle(color: Color(0xFFF1D3B2), fontSize: 13, fontWeight: FontWeight.bold))),
        child: Icon(Icons.shopping_cart_outlined, size: 30, color: backgroundColor),
      ),
    );
  }

  Stack gameCover(BuildContext context, Color backgroundColor, Color foregroundColor) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
          child: Hero(
            tag: '${widget.game.id}',
            child: Image.network(
              widget.game.backgroundImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
            ),
          ),
        ),
        IconButton(
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(backgroundColor)),
          icon: Icon(Icons.arrow_back_ios_new, color: foregroundColor, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
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
                          child: Hero(
                            tag: '${widget.game.shortScreenshots[index].id}',
                            child: Image.network(
                              widget.game.shortScreenshots[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
