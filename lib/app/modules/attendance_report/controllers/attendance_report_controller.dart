
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class AttendanceReportController extends GetxController {
  RxString date = ''.obs;
  DateTime selectedDate = DateTime.now();
  RxString totalWkHour = '00:00:00'.obs;

  @override
  void onInit() {
    date.value = dateFormat3(selectedDate);
    super.onInit();
  }

  incrementMonth() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    date.value = dateFormat3(selectedDate);
  }

  decrementMonth() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
    date.value = dateFormat3(selectedDate);
  }

  void changeDate(BuildContext context) async {
    final pickDate = await selectDate(context);

    if (pickDate != null) {
      selectedDate = pickDate;
      date.value = dateFormat3(pickDate);
    }
  }
}
