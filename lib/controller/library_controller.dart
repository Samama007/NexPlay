import 'package:get/get.dart';

class LibraryItem {
  final String name;
  final double price;
  int quantity;

  LibraryItem({required this.name, required this.price, this.quantity = 1});
}

class LibraryController extends GetxController {
  var cartItems = <LibraryItem>[].obs;

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(LibraryItem item) {
    cartItems.add(item);
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }
}
