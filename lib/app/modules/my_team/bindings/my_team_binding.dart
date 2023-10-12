import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/my_team/controllers/shop_assign_controller.dart';

import '../controllers/my_team_controller.dart';

class MyTeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTeamController>(
      () => MyTeamController(),
    );
    Get.lazyPut<ShopAssignController>(
      () => ShopAssignController(),
    );
  }
}
