
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/support_page_view.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';

class CartController extends GetxController {

  void checkOut() async {
    dynamic returnResponse = await openDialog(
        'Checkout', 'Are you sure you want to Checkout this orders ?');
    if (returnResponse == true) {
      Get.to(const SupportPageView());
    }
  }
}
