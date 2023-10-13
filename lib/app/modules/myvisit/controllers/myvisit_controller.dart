import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/my_visit_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class MyvisitController extends GetxController {
  RxString date = ''.obs;
  DateTime selectedDate = DateTime.now();
  var myVisisitList = <Date>[].obs;
  final argumet = Get.arguments;
  var isLoading = false.obs;
  @override
  void onInit() {
    date.value = dateFormat2(selectedDate);
    getMyVisit();
    super.onInit();
  }

  void changeDate(BuildContext context) async {
    final pickDate = await selectDate(context);

    if (pickDate != null) {
      selectedDate = pickDate;
      date.value = dateFormat2(pickDate);
    }
    getMyVisit();
  }

  incrementDay() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);
    date.value = dateFormat2(selectedDate);
    getMyVisit();
  }

  decrementDay() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 1);
    date.value = dateFormat2(selectedDate);
    getMyVisit();
  }

  Future<void> getMyVisit() async {
    isLoading(true);
    myVisisitList.clear();
    try {
      final response = await ApiProvider().getMyVisit(dateFormat5(selectedDate),
          argumet != "" ? argumet.id.toString() : Session.userId);
      if (response != null) {
        if (response.status == true) {
          myVisisitList.addAll(response.response);
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
