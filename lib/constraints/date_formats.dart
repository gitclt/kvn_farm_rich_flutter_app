import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormat2(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String dateFormat3(DateTime dateTime) {
  return DateFormat.yMMMM().format(dateTime);
}

dateFormate4(DateTime dateTime) {
  return DateFormat.yMMMM().format(dateTime);
}

String returnMonth(DateTime date) {
  return DateFormat.MMMM().format(date);
}

String getDate(DateTime dateTime) {
  return DateFormat.M().format(dateTime);
}

String getYear(DateTime dateTime) {
  return DateFormat.y().format(dateTime);
}

dateToFormattedDate(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

dateToFormattedTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

String dateFormat5(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String dateTimeFormat(String inputString) {
  DateTime dateTime = DateTime.parse(inputString);
  String formattedDate = DateFormat('dd/MM/yy hh:mm a').format(dateTime);
  return formattedDate;
}

String formatTimeString(String inputTimeString) {
  DateTime dateTime = DateTime.parse(inputTimeString);
  String formattedTime = DateFormat('h:mm a').format(dateTime);
  return formattedTime;
}

String dateFormat(DateTime date) {
  return DateFormat('dd/MM/yy hh:mm a').format(date);
}

DateTime getFormatedDate6(String date) {
  var inputFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
  var inputDate = inputFormat.parse(date);
  return inputDate;
}

String formatDateString5(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(dateTime);
  return formattedDate;
}

String formatDateStr(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  return formattedDate;
}

String formatDateString2(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  return formattedDate;
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendar,
    firstDate: DateTime(1900, 8),
    lastDate: DateTime(2050),
  );
  if (pickedDate != null && pickedDate != DateTime.now()) {
    return pickedDate;
  }
  return null;
}

String formatDateStringDates(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('EEEE').format(dateTime);
  return formattedDate;
}

String formatDateString(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('d/MM/yyyy').format(dateTime);
  return formattedDate;
}
String formatDateString3(String inputDateString) {
  DateTime dateTime = DateTime.parse(inputDateString);
  String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  return formattedDate;
}

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}
