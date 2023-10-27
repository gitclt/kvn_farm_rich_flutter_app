import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/my_order_controller.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/order_details_controller.dart';

import '../controllers/order_history_controller.dart';

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryController>(
      () => OrderHistoryController(),
    );
       Get.lazyPut<MyOrderController>(
      () => MyOrderController(),
    );
      Get.lazyPut<OrderDetailsController>(
      () => OrderDetailsController(),
    );
    
    
  }
}
