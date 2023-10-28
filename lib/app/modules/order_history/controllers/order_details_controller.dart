import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/order_details_model.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/my_order_controller.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/order_history_controller.dart';

class OrderDetailsController extends GetxController {
  final isLoading = false.obs;
  final OrderHistoryController orderController = Get.find();
  final MyOrderController myorderController = Get.find();

  final argument = Get.arguments;
  var orderbyorderno = <OrderDetail>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await getOrderByOrderNo(argument.orderNo);
  }

  getOrderByOrderNo(String orderno) async {
    isLoading(true);
    orderbyorderno.clear();
    try {
      final response = await ApiProvider().getorderbyOrderNo(orderno);
      if (response != null) {
        orderbyorderno.addAll(response.data);
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  deleteOrderbyitem(String orderid) async {
    isLoading(true);

    try {
      final response = await ApiProvider().deletebyitem(orderid);
      if (response != null) {
        toast(response.message);
        orderController.getOrderByLead();
        myorderController.getMyOrder();
        await getOrderByOrderNo(argument.orderNo);
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
