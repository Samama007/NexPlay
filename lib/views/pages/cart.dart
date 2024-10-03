import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexplay/controller/library_controller.dart' as libraryitem;
import 'package:nexplay/views/pages/purchased.dart';
import '../../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController _cartController = Get.find();
  final libraryitem.LibraryController _libraryController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;
    Color foregroundColor = Theme.of(context).colorScheme.secondary;
    Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: foregroundColor,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: foregroundColor),
        ),
        centerTitle: true,
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: _cartController.cartItems.isNotEmpty
                    ? Obx(
                        () => ListView.builder(
                          itemCount: _cartController.cartItems.length,
                          itemBuilder: (context, index) {
                            final item = _cartController.cartItems[index];
                            return Card(
                              color: backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                leading: Image.network(item.backgroundImage, width: 100, height: 100, fit: BoxFit.cover),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: foregroundColor,
                                  ),
                                ),
                                subtitle: Text(
                                  '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: foregroundColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () => _cartController.removeItem(index),
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: tertiaryColor,
                                    size: 40,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 45),
                          SvgPicture.asset(
                            'assets/svg/empty.svg',
                            height: 300,
                            width: Get.width * 0.7,
                          ),
                          const SizedBox(height: 15),
                          Text('Oops, Cart is empty 😖', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: backgroundColor, fontStyle: FontStyle.normal))
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 20,
                            color: backgroundColor,
                          ),
                        ),
                        subtitle: Obx(
                          () => Text(
                            '\$${_cartController.totalPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        if (_cartController.cartItems.isNotEmpty) {
                          for (int i = 0; i < _cartController.cartItems.length; i++) {
                            var newItem = libraryitem.LibraryItem(
                              id: _cartController.cartItems[i].id,
                              name: _cartController.cartItems[i].name,
                              backgroundImage: _cartController.cartItems[i].backgroundImage,
                              rating: _cartController.cartItems[i].rating,
                              released: _cartController.cartItems[i].released,
                              playtime: _cartController.cartItems[i].playtime,
                              ratingsCount: _cartController.cartItems[i].ratingsCount,
                              shortScreenshots: _cartController.cartItems[i].shortScreenshots.map((screenshot) => libraryitem.ShortScreenshot(id: _cartController.cartItems[i].shortScreenshots[i].id, image: _cartController.cartItems[i].shortScreenshots[i].image)).toList(),
                              esrbRating: libraryitem.EsrbRating(id: _cartController.cartItems[i].esrbRating.id, name: _cartController.cartItems[i].esrbRating.name, slug: _cartController.cartItems[i].esrbRating.slug),
                            );
                            _libraryController.addItem(newItem);
                          }
                          // print(newItem);
                          Get.to(() => const Purchased());
                          Future.delayed((const Duration(seconds: 4)), () {
                            _cartController.clearCart();
                            Get.back();
                          });
                        } else {
                          Get.snackbar(
                            'EMPTY CART!',
                            'Add some games to the cart first',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: backgroundColor,
                            colorText: foregroundColor,
                            duration: const Duration(seconds: 2),
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            overlayBlur: 1,
                            isDismissible: true,
                          );
                        }
                      },
                      child: Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: foregroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
