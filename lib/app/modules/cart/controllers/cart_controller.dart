import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/models/product_model.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/support_page_view.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxList<ProductData> cartlist = <ProductData>[].obs;
  TextEditingController qtycontroller = TextEditingController();
  final isloading = false.obs;
  @override
  void onInit() async {
    super.onInit();
  }

  void checkOut() async {
    dynamic returnResponse = await openDialog(
        'Checkout', 'Are you sure you want to Checkout this orders ?');
    if (returnResponse == true) {
      Get.to(const SupportPageView());
    }
  }

  getData() async {
    isloading(true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("cartdata")) {
      cartlist.value = List<Map<String, dynamic>>.from(
              jsonDecode(sharedPreferences.getString("cartdata")!))
          .map((x) => ProductData.fromJson(x))
          .toList();
    }
    isloading(false);
  }

  saveData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("cartdata", jsonEncode(cartlist));
    getData();
  }

  void deleteData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("cartdata");
  }

  addqty(int index) async {
    cartlist[index].qty = qtycontroller.text;
  }
}
