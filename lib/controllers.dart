import 'package:get/get.dart';

import 'controller/cart_controller.dart';

class Controllers {
    
    initializeController(){
      Get.put(CartController());
    }

}