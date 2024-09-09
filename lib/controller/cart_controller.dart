import 'package:get/get.dart';

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(CartItem item) {
    cartItems.add(item);
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
