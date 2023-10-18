import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';

class ShopProfileController extends GetxController{
  GetShopListModel? leadDetailsResponse;
   final formKey2 = GlobalKey<FormState>();
  var leadList = <GetShopDetails>[].obs;
  var isDetailsLoading = false.obs;
  var value = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (value != null) {
      viewShopDetails(value);
    }
  }

  viewShopDetails(String shopId) async{
     isDetailsLoading(true);

    try {
      final response = await ApiProvider().getShopDetails(shopId);
      if (response != null) {
        leadDetailsResponse = response;
        if (response.status == true) {
          leadList.addAll(response.data);
        } else {
          isDetailsLoading(false);
        }
      }
    } finally {
      isDetailsLoading(false);
    }

  }

  
}