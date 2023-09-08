import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:get/get.dart';

class ExpiryProductsController extends GetxController {
  RxString date = ''.obs;
  DateTime selectedDate = DateTime.now();
  RxString totalWkHour = '00:00:00'.obs;

  @override
  void onInit() {
    date.value = dateToFormattedDate(selectedDate);
    super.onInit();
  }

  incrementDay() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1);
    date.value = dateToFormattedDate(selectedDate);
  }

  decrementDay() {
    selectedDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day - 1);
    date.value = dateToFormattedDate(selectedDate);
  }
}
