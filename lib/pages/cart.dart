import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/pages/Purchased.dart';
// import 'package:nexplay/pages/add_card.dart';
import '../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Cart',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return Card(
                        color: Colors.blue.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          // contentPadding: const EdgeInsets.all(15),
                          leading: Image.network(item.backgroundimage),
                          title: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 19,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () => cartController.removeItem(index),
                            icon: const Icon(
                              Icons.delete_outline_outlined,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                        subtitle: Obx(
                          () => Text(
                            '\$${cartController.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 25,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ), 
                      onPressed: () {
                        if (cartController.cartItems.isNotEmpty) {
                          Get.to(() => const Purchased());
                          Future.delayed((const Duration(seconds: 4)), () {
                            cartController.clearCart();
                            Get.back();
                          });
                        } else {
                          Get.snackbar(
                            'EMPTY CART!',
                            'Add some games to the cart first',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.grey.shade500,
                            colorText: Colors.white,
                            duration: const Duration(seconds: 2),
                            borderRadius: 10,
                            margin: const EdgeInsets.all(10),
                            overlayBlur: 1,
                            isDismissible: true,
                          );
                        }
                      },
                      child: const Text(
                        'PLACE ORDER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
