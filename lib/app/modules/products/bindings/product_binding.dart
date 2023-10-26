import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/product_controller.dart';

class MasalaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasalaController>(
      () => MasalaController(),
    );
     Get.lazyPut<CartController>(
      () => CartController(),
    );
    
  }
}
