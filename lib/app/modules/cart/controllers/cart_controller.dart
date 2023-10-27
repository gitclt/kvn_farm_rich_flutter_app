import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/bottomsheet/cart_shop_bottomsheet.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/dialog_helper.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/models/product_model.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/support_page_view.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxList<ProductData> cartlist = <ProductData>[].obs;
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  var leadList = <GetShopDetails>[].obs;
  GetShopListModel? leadresponse;
  final isloading = false.obs;
  var shopname = ''.obs;
  var shopid = ''.obs;
  final isLoading = false.obs;
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

  getShops() async {
    isLoading(true);

    try {
      final response = await ApiProvider()
          .fetchLeads("", "1", "", Session.userId, '', "customer");
      if (response != null) {
        if (response.status == true) {
          leadresponse = response;
          leadList.addAll(response.data);

          Get.bottomSheet(
            ShopBottomSheet(
              ontap: () {},
            ),
            elevation: 20.0,
            enableDrag: false,
            isDismissible: true,
            backgroundColor: Colors.white,
            shape: bootomSheetShape(),
          );
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  getOrderNumber() async {
    isLoading(true);
    DialogHelper.showLoading('Uploading .....');
    try {
      final response = await ApiProvider().getOrderNumber(shopid.value);
      if (response != null) {
        await addProducts(
          response.orderNo,
        );
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addProducts(
    String orderNo,
  ) async {
    isLoading(true);

    try {
      List<Map<String, dynamic>> ordersMaps = cartlist.map((item) {
        return {
          "lead_id": int.parse(shopid.value),
          "pro_id": item.id,
          "order_no": orderNo,
          "mrp": item.mrp,
          "qty": int.parse(item.qty),
          "total": (item.mrp * int.parse(item.qty)),
          "addedon": dateToFormattedTime5(DateTime.now()),
          "addedby": int.parse(Session.userId),
          "status": "pending",
          "emp_id": int.parse(Session.userId),
        };
      }).toList();

      final response = await ApiProvider().addOrder(ordersMaps);

      if (response != null) {
        if (response.status == true) {
          DialogHelper.hideLoading();
          toast("Order Successfully Added");
          shopid.value = "";
          shopname.value = "";
          cartlist.clear();
          saveData();
          Get.back(result: true);
        } else {}
      }
    } finally {
      isLoading(false);
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

  shopSearch() {
    leadList.clear();
    leadList.addAll(leadresponse!.data
        .where((element) => element.name.toUpperCase().toLowerCase().contains(
            searchcontroller.text.toUpperCase().toLowerCase().toString()))
        .toList());
    leadList.refresh();
  }
}
