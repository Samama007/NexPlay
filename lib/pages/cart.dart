import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Cart'))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return ListTile(title: Text(item.name), subtitle: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'), trailing: IconButton(onPressed: () => cartController.removeItem(index), icon: Icon(Icons.delete_outline_outlined, color: Colors.red, size: 30)));
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => Text(
                    'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
            ElevatedButton(
              onPressed: cartController.cartItems.isEmpty
                  ? null
                  : () {
                      // Handle checkout logic
                    },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
