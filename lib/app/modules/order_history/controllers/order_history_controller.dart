import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/order_list.model.dart';

class OrderHistoryController extends GetxController {
    final isLoading = false.obs;
  var orderbylead = <OrderData>[].obs;
  final argument = Get.arguments;
  @override
  void onInit() async {
    super.onInit();
    await getOrderByLead();
  }

  getOrderByLead() async {
    isLoading(true);
    orderbylead.clear();
    try {
      final response = await ApiProvider().getorderbylead(argument.toString());
      if (response != null) {
        orderbylead.addAll(response.data);
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  deleteOrder(String orderno) async {
    isLoading(true);

    try {
      final response = await ApiProvider().deletebyOrderNo(orderno);
      if (response != null) {
        toast(response.message);
        await getOrderByLead();
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
