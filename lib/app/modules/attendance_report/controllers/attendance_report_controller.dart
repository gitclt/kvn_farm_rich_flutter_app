import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/models/attendance_report_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class AttendanceReportController extends GetxController {
  RxString date = ''.obs;
  DateTime selectedDate = DateTime.now();
  RxString totalWkHour = '00:00:00'.obs;
  var isLoading = false.obs;
  var attendenceList = <AttendenceResponse>[].obs;
  var totalattendenceList = <AttendenceResponse>[].obs;
  var monthattendenceList = <AttendenceResponse>[].obs;
  var existingDates = <String>[].obs;
  final argumet = Get.arguments;

  @override
  void onInit() {
    date.value = dateFormat3(selectedDate);

    getAttendanceReport();
    super.onInit();
  }

  incrementMonth() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
    date.value = dateFormat3(selectedDate);
    getAttendanceReport();
  }

  decrementMonth() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
    date.value = dateFormat3(selectedDate);
    getAttendanceReport();
  }

  void changeDate(BuildContext context) async {
    final pickDate = await selectDate(context);

    if (pickDate != null) {
      selectedDate = pickDate;
      date.value = dateFormat3(pickDate);
    }
    getAttendanceReport();
  }

  Future<void> getAttendanceReport() async {
    isLoading(true);
    attendenceList.clear();
    monthattendenceList.clear();
    totalattendenceList.clear();
    totalWkHour.value = '00:00:00';
    try {
      final response = await ApiProvider().getAttendence(
          getDate(selectedDate),
          getYear(selectedDate),
          argumet != "" ? argumet.id.toString() : Session.userId);
      if (response != null) {
        if (response.status == true) {
          attendenceList.addAll(response.data);

          if (response.data.isNotEmpty) {
            addDatesToList(
                attendenceList, response.data.first.checkindate.toString());

            totalWkHour.value = monthattendenceList
                .map((e) {
                  final Duration total = parseDuration(e.workhour == "0"
                      ? '00:00:00'
                      : e.workhour == ""
                          ? '00:00:00'
                          : e.workhour.toString());
                  return total;
                })
                .toList()
                .reduce((value, element) => value + element)
                .toString()
                .split('.')
                .first
                .toString();
          } else {
            addDatesToList([], formatDateString5(selectedDate.toString()));
          }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void addDatesToList(
    List<AttendenceResponse> attendenceList,
    String inputDate,
  ) {
    DateTime currentDate = DateTime.parse(inputDate);
    int year = currentDate.year;
    int month = currentDate.month;

    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);

    for (var response in attendenceList) {
      // ignore: unnecessary_null_comparison
      if (response.checkindate != null) {
        existingDates.add(formatDateString2(response.checkindate.toString()));

        totalattendenceList.add(response);
      }
    }

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      DateTime dateToAdd = firstDayOfMonth.add(Duration(days: i));
      String formattedDateToAdd = formatDateString2(dateToAdd.toString());
      if (existingDates.contains(formatDateString2(dateToAdd.toString())) ==
          false) {
        monthattendenceList.add(AttendenceResponse(
          workhour: "",
          id: 0,
          empId: '',
          checkindate: dateToAdd,
          checkinLat: '',
          checkinLong: '',
          checkinLoc: '',
          checkoutdate: null,
          checkoutLat: '',
          checkoutLong: '',
          checkoutLoc: '',
          photo: '',
          remark: '',
        ));
      } else {
        int index = existingDates.indexOf(formattedDateToAdd);
        monthattendenceList.add(AttendenceResponse(
          workhour: totalattendenceList[index].workhour,
          id: totalattendenceList[index].id,
          empId: totalattendenceList[index].empId,
          checkindate: totalattendenceList[index].checkindate,
          checkinLat: totalattendenceList[index].checkinLat,
          checkinLong: totalattendenceList[index].checkinLong,
          checkinLoc: totalattendenceList[index].checkinLoc,
          checkoutdate: totalattendenceList[index].checkoutdate,
          checkoutLat: totalattendenceList[index].checkoutLat,
          checkoutLong: totalattendenceList[index].checkoutLong,
          checkoutLoc: totalattendenceList[index].checkoutLoc,
          photo: totalattendenceList[index].photo,
          remark: totalattendenceList[index].remark,
        ));
      }
    }
  }
}
