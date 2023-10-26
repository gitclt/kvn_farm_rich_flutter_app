import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/state_model.dart';

class StateController extends GetxController {
  var isLoading = false.obs;
  var stateList = <StateDetails>[].obs;
  StateModel? stateresponse;
  TextEditingController searchcontroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    searchcontroller.clear();
    getState();
  }

  void getState() async {
    isLoading(true);

    try {
      final response = await ApiProvider().getState();
      if (response != null) {
        stateresponse = response;
        if (response.status == true) {
          stateList.addAll(response.data);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  stateSearch() {
    stateList.clear();
    stateList.addAll(stateresponse!.data
        .where((element) => element.name
            .toUpperCase()
            .toLowerCase()
            .contains(searchcontroller.text.toLowerCase().toString()))
        .toList());
    stateList.refresh();
  }
}
