import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/dialog_helper.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/mark_visit_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/assigned_route_list_model.dart';
import 'package:kvn_farm_rich/app/models/mark_visit_types_model.dart';
import 'package:kvn_farm_rich/app/models/route_place_model.dart';
import 'package:kvn_farm_rich/app/models/shop_checkin_model.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:kvn_farm_rich/constraints/services/location.dart';

class MyrouteController extends GetxController {
  var selectedDate = DateTime.now().obs;
  DateTime currentDate = DateTime.now();
  // RxList<RouteList> routeList = <RouteList>[].obs;
  final aRouteList = <GetRouteDetails>[].obs;
  final shopvisitlist = <GetRouteDetails>[].obs;
  final routePlaceList = <Routes>[].obs;
  final String placeList = '';
  final placeLoading = false.obs;
  final RxString selectedRoute = 'Select Place'.obs;
  

  final isLoading = false.obs;
  final isVisitLoading = false.obs;

  var color = Colors.blue.obs;
  RxBool checkIn = false.obs;
  TextEditingController remarkController = TextEditingController();
  //String selcteditemdateormonth = 'Plan Tour';
  RxString phoneNumber = ''.obs;
  RxBool planChecked = false.obs;
  RxBool creditChecked = false.obs;
  final leadCheckIn = <ShopCheckInDetails>[].obs;
  TextEditingController itemController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final argumet = Get.arguments;
  final markTypes = <MarkVisitTypes>[].obs;
  final List<String> option = [
    'Exhibition',
    'Newspaper',
    'Ads',
    'Friends',
    'Online'
  ];

  @override
  void onInit() {
    super.onInit();
    assignRoute();
    getAssignedRoutes();
    getMarkTypes();
  }

  void changeDate(DateTime newDate) {
    selectedDate.value = newDate;
    getAssignedRoutes();
  }

  assignRoute() async {
     isLoading(true);
    try {
      final response = await ApiProvider().assignRoutePlace();
      if (response != null) {
        if (response.status) {
          routePlaceList.addAll(response.data);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  getAssignedPlaces() {
    placeLoading(true);
    try {
      final selectedPlace = routePlaceList
          .map((element) =>
              element.places.where((element) => element.isSelect.value == true))
          .toList();
      for (var item in selectedPlace) {
        final placeList = item.map((element) => element.name).toList();
        return placeList;
      }
    } finally {
      placeLoading(false);
    }
  }

  Future<void> getMarkTypes() async {
    // final databaseHelper = DatabaseHelper();
    // await databaseHelper.clearMarType();
    isLoading(true);
    try {
      final response = await ApiProvider().getMarkVisitTypes();
      if (response != null) {
        if (response.status == true) {
          markTypes.addAll(response.data);
          // for (var e in markTypes) {
          //   await databaseHelper.addmarkvisttypes(e.id.toString(), e.name);
          // }
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAssignedRoutes() async {
    isLoading(true);
    aRouteList.clear();
    shopvisitlist.clear();
    // final databaseHelper = DatabaseHelper();
    // await databaseHelper.clearRoutes();
    try {
      final response = await ApiProvider().assignedRoutes(
        argumet == null || argumet == ''
            ? Session.userId
            : argumet.id.toString(),
        dateFormat5(selectedDate.value),
      );
      if (response != null) {
        if (response.status == true) {
          aRouteList.addAll(response.data);
          shopvisitlist.addAll(aRouteList.where((e) => e.visitstatus == 1));
          // for (var element in aRouteList) {
          //   await DatabaseHelper.getaddRoutes(
          //       element.date,
          //       element.visitstatus.toString(),
          //       element.visitType,
          //       element.empId.toString(),
          //       element.leadId.toString(),
          //       element.leadname,
          //       element.place,
          //       element.flag,
          //       element.mobile,
          //       element.lat,
          //       element.longi,
          //       element.gpsLoc,"","");
          // }
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getTodayCheckIn(
      String empId, String leadId, String visitType) async {
    DialogHelper.showLoading("Please wait while loading data...");
    leadCheckIn.clear();
    try {
      final response = await ApiProvider().checkInStatus(empId, leadId);
      if (response != null) {
        if (response.status == true) {
          leadCheckIn.addAll(response.data);
        } else {
          DialogHelper.hideLoading();
        }
      }
    } catch (e) {
      contactAdministrationSnackBar('Something went wrong', e.toString());
    } finally {
      DialogHelper.hideLoading();
    }
  }

  Future<double> getLocation(
    double lati,
    double longi,
  ) async {
    // if (value != 1) {
    DialogHelper.showLoading("fetching Location ...");
    final location = await determinePosition();
    DialogHelper.hideLoading();
    if (location == null) return 0.0;

    final locStatus = await getCurrentPos(location);

    if (!locStatus) return 0.0;

    var distance = checkDistance(
      lati,
      longi,
      double.parse(crlatitude),
      double.parse(crlongitude),
    );

    return distance;
  }

  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  double earthRadius = 6371;
  double checkDistance(
    double lat,
    double longi,
    double curLat,
    double curlong,
  ) {
    final double curLatitude = degreesToRadians(curLat);
    final double curLongitude = degreesToRadians(curlong);
    final double latitude = degreesToRadians(lat);
    final double longitude = degreesToRadians(longi);
    double dLat = latitude - curLatitude;
    double dLon = longitude - curLongitude;
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(curLatitude) * cos(latitude) * sin(dLon / 2) * sin(dLon / 2);
    // double a = sin(dLat / 2) * sin(dLat / 2) +
    //     cos(curLat * pi / 180.0) *
    //         cos(lat * pi / 180.0) *
    //         sin(dLon / 2) *
    //         sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  Future<void> fetchLocation(
    BuildContext context,
    bool status,
    String kmDiff,
    String visitType,
    String empId,
    String leadId,
    String place,
  ) async {
    itemController.clear;
    remarkController.clear;
    DialogHelper.showLoading("fetching Location ...");
    final location = await determinePosition();
    DialogHelper.hideLoading();
    if (location == null) return;

    final locStatus = await getCurrentPos(location);

    if (!locStatus) return;

    if (status) {
      markCheckIn(kmDiff, visitType, empId, leadId, place);
    } else if (status == false && leadCheckIn.first.workhour == "") {
      Get.back();

      final workHour = workingHours(getFormatedDate6(leadCheckIn.first.date),
          getFormatedDate6(DateTime.now().toString()));

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => MarkVisitPopup(
          location: place,
          onClick: () {
            if (formKey.currentState!.validate()) {
              getCheckOutMarkVisit(
                  leadCheckIn.first.id.toString(),
                  place,
                  crlongitude,
                  crlatitude,
                  Session.userId,
                  leadId,
                  workHour,
                  kmDiff,
                  visitType);
            }
          },
        ),
      );
    }
    // else if (status == false && leadCheckIn.first.workhour != '') {
    //   toast('Already checkedin');
    // }
  }

  // final databaseHelper = DatabaseHelper();
  Future<void> markCheckIn(String kmDiff, String visitType, String empId,
      String leadId, String place) async {
    DialogHelper.showLoading("Please wait while marking Check In...");
    leadCheckIn.clear();
    try {
      final response = await ApiProvider().checkInVisit(
          kmDiff, place, crlatitude, crlongitude, empId, leadId, visitType);
      if (response != null) {
        if (response.status == true) {
          Get.back();

          leadCheckIn.addAll(response.data);

          toast(response.message);
          getTodayCheckIn(empId, leadId, visitType);

          //  await databaseHelper.checkAlreadyCheckedin(leadId, "true", "");
        } else {
          DialogHelper.hideLoading();
        }
      }
    } catch (e) {
      contactAdministrationSnackBar('Something went wrong', e.toString());
    } finally {
      DialogHelper.hideLoading();
    }
  }

  String place = '';
  String locality = '';

  String crlatitude = '';
  String crlongitude = '';

  Future<bool> getCurrentPos(Position position) async {
    try {
      crlatitude = position.latitude.toString();
      crlongitude = position.longitude.toString();

      // List<Placemark> coordinates = await placemarkFromCoordinates(
      //     double.parse(crlatitude), double.parse(crlongitude));

      // Placemark geoAddress = coordinates.first;
      // place = geoAddress.locality!;
      // locality = geoAddress.subLocality!;

      return true;
    } catch (e) {
      //  print(e.toString());
      return false;
    }
  }

  String workingHours(DateTime from, DateTime to) {
    Duration difference = to.difference(from);
    String hours = (difference.inHours % 12).toString().padLeft(2, '0');
    String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');

    return ('$hours:$minutes');
  }

  Future<void> getCheckOutMarkVisit(
      String checkinId,
      String place,
      String longi,
      String crlatitude,
      String empId,
      String leadId,
      String workHour,
      String kmDiff,
      String visitType) async {
    isVisitLoading(true);
    try {
      final response = await ApiProvider().checkOutVisit(
          itemController.text,
          remarkController.text,
          place,
          crlongitude,
          crlatitude,
          empId,
          leadId,
          workHour,
          kmDiff,
          '0',
          '0',
          Session.roleId,
          "",
          checkinId,
          visitType);
      if (response != null) {
        if (response.status == true) {
          itemController.clear;
          remarkController.clear;
          toast(response.message);

          Get.back();

          getAssignedRoutes();
        } else {
          isVisitLoading(false);
        }
      }
    } finally {
      isVisitLoading(false);
    }
  }
}
