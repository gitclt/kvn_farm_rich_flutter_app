import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
     Get.lazyPut<MasalaController>(
      () => MasalaController(),
    );
    
  }
}
