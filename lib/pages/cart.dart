import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexplay/pages/add_card.dart';

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
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = cartController.cartItems[index];
                      return ListTile(title: Text(item.name), subtitle: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'), trailing: IconButton(onPressed: () => cartController.removeItem(index), icon: Icon(Icons.delete_outline_outlined, color: Colors.red, size: 30)));
                    },
                  )),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Total:'),
                    subtitle: Obx(() => Text(
                          '\$${cartController.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                        )),
                  ),
                ),
                // Spacer(),
                TextButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    onPressed: () => Get.to(() => NoPaymentMethodsScreen()),
                    child: Text(
                      'Checkout',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
