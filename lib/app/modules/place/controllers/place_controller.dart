import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/place_model.dart';

class PlaceController extends GetxController {
  var isplaceLoading = false.obs;
  var placeList = <LocationDetails>[].obs;
  LocationModel? placeresponse;
  TextEditingController searchcontroller = TextEditingController();
  final argument = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    searchcontroller.clear();
    getPlace();
  }

  void getPlace() async {
    isplaceLoading(true);

    try {
      final response = await ApiProvider().getLocation(argument.toString());
      if (response != null) {
        placeresponse = response;
        if (response.status == true) {
          placeList.addAll(response.data);
        } else {
          isplaceLoading(false);
        }
      }
    } finally {
      isplaceLoading(false);
    }
  }

  placeSearch() {
    placeList.clear();
    placeList.addAll(placeresponse!.data
        .where((element) => element.name
            .toUpperCase()
            .toLowerCase()
            .contains(searchcontroller.text.toLowerCase().toString()))
        .toList());
    placeList.refresh();
  }
}
