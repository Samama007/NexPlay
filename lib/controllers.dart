import 'package:get/get.dart';
import 'package:nexplay/controller/library_controller.dart';

import 'controller/cart_controller.dart';

class Controllers {
  void initializeControllers() {
    Get.put(CartController());
    Get.put(LibraryController());
  }
}