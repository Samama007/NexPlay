import 'package:get/get.dart';

import 'controller/cart_controller.dart';

class Controllers {
  void initializeControllers() {
    Get.put(CartController());
    // Add other controllers here if needed
  }
}