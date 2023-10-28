import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/product_model.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MasalaController extends GetxController {
  final isloading = false.obs;
  final cartloading = false.obs;
  var subcatname = "".obs;
  var subcatList = <String>[].obs;
  var productList = <ProductData>[].obs;
  final argument = Get.arguments;
  TextEditingController qtycontroller = TextEditingController();
  final CartController cartController = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await getsubcat();
    await getData();
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
        subcatname.value = subcatList.first;
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

  saveData() async {
    cartloading(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        "cartdata", jsonEncode(cartController.cartlist));
    getData();
    cartloading(false);
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("cartdata")) {
      cartController.cartlist.value = List<Map<String, dynamic>>.from(
              jsonDecode(sharedPreferences.getString("cartdata")!))
          .map((x) => ProductData.fromJson(x))
          .toList();
    }
  }

  void deleteData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("cartdata");
  }

  addqty(int index) async {
    String productId = productList[index].id.toString();
    if (cartController.cartlist.isNotEmpty) {
      var existingProduct = cartController.cartlist.firstWhereOrNull(
        (product) => product.id.toString() == productId,
      );
      if (cartController.cartlist
          .any((product) => product.id.toString() == productId)) {
        existingProduct!.qty = qtycontroller.text;
      } else {
        productList[index].qty = qtycontroller.text;
        cartController.cartlist.add(productList[index]);
      }
    } else {
      productList[index].qty = qtycontroller.text;
      cartController.cartlist.add(productList[index]);
    }
  }
}
