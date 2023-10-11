import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/shops/controllers/shop_profile_controller.dart';

import '../controllers/shops_controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsController>(
      () => ShopsController(),
    );

    Get.lazyPut<ShopProfileController>(
      () => ShopProfileController(),
    );
  }
}
