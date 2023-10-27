import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/bottomsheet/order_shop_bottomsheet.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/models/order_by_date_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class MyOrderController extends GetxController {
  TextEditingController leadoptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController searchcontroller = TextEditingController();
  var myOrderList = <Message>[].obs;
  var isLoading = false.obs;
  RxString fromDate = formatDateString8(DateTime.now().toString()).obs;
  RxString toDate =
      formatDateString8(DateTime.now().add(const Duration(days: 30)).toString())
          .obs;

  var invoiceDate = ''.obs;
  String invDate = '';
  var shopname = ''.obs;
  var shopid = ''.obs;
  DateTime? selectfrom;
  var leadList = <GetShopDetails>[].obs;
  GetShopListModel? leadresponse;
  @override
  void onInit() {
    getMyOrder();
    super.onInit();
  }

  getMyOrder() async {
    isLoading(true);
    myOrderList.clear();
    try {
      final response = await ApiProvider().getorderbyDate(
        fromDate.value,
        toDate.value,
        shopid.value,
      );
      if (response != null) {
        myOrderList.addAll(response.message);
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
        await getMyOrder();
      } else {
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }

  getShops() async {
    try {
      final response = await ApiProvider()
          .fetchLeads("", "1", "", Session.userId, '', "customer");
      if (response != null) {
        if (response.status == true) {
          leadresponse = response;
          leadList.addAll(response.data);

          Get.bottomSheet(
            OrderShopBottomsheet(
              ontap: () {},
            ),
            elevation: 20.0,
            enableDrag: false,
            isDismissible: true,
            backgroundColor: Colors.white,
            shape: bootomSheetShape(),
          );
        } else {}
      }
    } finally {}
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
