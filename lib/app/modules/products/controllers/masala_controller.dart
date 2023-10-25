import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/product_model.dart';

class MasalaController extends GetxController {
  final isloading = false.obs;
  var subcatList = <String>[].obs;
  var productList = <ProductData>[].obs;
  final argument = Get.arguments;

  @override
  void onInit() async {
    super.onInit();
    await getsubcat();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getsubcat() async {
    isloading(true);
    try {
      final response = await ApiProvider().getProduct();
      if (response != null) {
        if (response.status == true) {
          for (var item in response.data
              .where((element) => element.catName == argument)) {
            String subCatName = item.subCatName;
            if (!subcatList.any((category) => category == subCatName)) {
              subcatList.add(subCatName);
            }
          }
        }
        await getProductList(subcatList.first);
      }
    } finally {
      isloading(false);
    }
  }

  Future<void> getProductList(String subcat) async {
    productList.clear();
    isloading(true);
    try {
      final response = await ApiProvider().getProduct();
      if (response != null) {
        if (response.status == true) {
          for (var item in response.data.where((element) =>
              element.catName == argument && element.subCatName == subcat)) {
            productList.add(item);
          }
        }
      }
    } finally {
      isloading(false);
    }
  }
}
