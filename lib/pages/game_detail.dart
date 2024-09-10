import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/api/api_service.dart';
import 'package:nexplay/models/my_game_description_model.dart';
import 'package:nexplay/models/my_game_model.dart';
import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:nexplay/pages/cart.dart';
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
              gameCover(context),
              SizedBox(height: 12),
              gameName(),
              gameRating(),
              SizedBox(height: 12),
              buyPage(),
              SizedBox(height: 12),
              gameDescription(),
              SizedBox(height: 15),
              gameSS(),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton cartButton() {
    return FloatingActionButton(
      onPressed: () => Get.to(() => CartPage()),
      backgroundColor: Colors.white,
      shape: CircleBorder(eccentricity: 1),
      child: Badge(
        backgroundColor: Colors.red,
        label: Obx(() => Text(cartController.cartItems.length.toString(), style: TextStyle(color: Colors.white, fontSize: 13))),
        child: Icon(
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
        Image.network(
          widget.game.backgroundImage,
          fit: BoxFit.cover,
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 25,
          ),
          onPressed: () => Navigator.pop(context),
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white38)),
        )
      ],
    );
  }

  Center gameSS() {
    return Center(
      child: isLoading
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                width: double.infinity,
                height: 170,
                child: ListView.builder(
                    itemCount: widget.game.shortScreenshots.length,
                    physics: BouncingScrollPhysics(),
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
                          margin: EdgeInsets.only(right: 15),
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
        effect: ShimmerEffect(baseColor: Colors.grey.shade800, highlightColor: Colors.grey.shade50, duration: Duration(seconds: 1)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('About this game', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900)),
            ),
            isLoading
                ? Text(BoneMock.paragraph, maxLines: 3)
                : AnimatedReadMoreText(
                    description!.description.toString(),
                    maxLines: 3,
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    buttonTextStyle: TextStyle(fontSize: 16, color: Colors.red),
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
        style: ButtonStyle(
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
            duration: Duration(seconds: 2),
            isDismissible: true,
            maxWidth: MediaQuery.sizeOf(context).width * 0.8,
            snackPosition: SnackPosition.TOP,
            borderRadius: 15,
            colorText: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10),
          );
        },
        child: Text('\$${widget.price}', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Padding gameRating() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(widget.game.rating.toString(), style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(width: 2),
                      Icon(Icons.star, color: Colors.yellow, size: 25)
                    ],
                  ),
                  Text('${widget.game.ratingsCount.toString()} reviews', style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              ),
              SizedBox(width: 30),
              Container(width: 2, height: 30, color: Colors.white),
              SizedBox(width: 30),
              Column(
                children: [
                  Icon(Icons.eighteen_up_rating_outlined, color: Colors.white, size: 35),
                  SizedBox(height: 2),
                  Text(widget.game.esrbRating.name, style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              ),
              SizedBox(width: 30),
              Container(width: 2, height: 30, color: Colors.white),
              SizedBox(width: 30),
              Column(
                children: [
                  Icon(Icons.hourglass_bottom, color: Colors.white, size: 35),
                  SizedBox(height: 2),
                  Text('${widget.game.playtime.toString()} hours', style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Skeletonizer gameName() {
    return Skeletonizer(
      enabled: isLoading,
      effect: ShimmerEffect(baseColor: Colors.grey.shade800, highlightColor: Colors.grey.shade50, duration: Duration(seconds: 1)),
      child: ListTile(
        title: Text(widget.game.name, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
        subtitle: isLoading ? Text(BoneMock.subtitle) : Text(description!.developers.first.name, style: TextStyle(fontSize: 18, color: Colors.red)),
      ),
    );
  }
}
