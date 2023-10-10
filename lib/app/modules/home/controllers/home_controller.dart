import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/dialog_helper.dart';
import 'package:kvn_farm_rich/app/models/attendance_report_model.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';
import 'package:kvn_farm_rich/app/modules/home/model/drawer_model.dart';
import 'package:kvn_farm_rich/app/modules/home/views/camera_view.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:kvn_farm_rich/constraints/services/location.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  DashboardController dashBoardController = Get.find();
  final isLoadingAttendance = false.obs;
  AttendenceResponse attendance = AttendenceResponse();
  TextEditingController remarkController = TextEditingController();
  String curlat = '';
  String curlog = '';
  String? place;
  String? locality;
  late XFile image;
  int direction = 1;

  final menuItems = <DrawerItem>[].obs;
  final label = ''.obs;
  final brands = [
    'assets/image/winheels.png',
    'assets/image/aqualite.png',
    'assets/image/lunars.png'
  ];

  final divisionItems = [
    '#AMINA ENTERPRICES',
    '#TRENDZ INDIA MARKETING',
    '#AMINA TRADING.CO',
    '#MADEWELL MARKETING'
  ];
  String selectedValue = '#AMINA ENTERPRICES';

  late List<CameraDescription> cameras;
  // ignore: prefer_typing_uninitialized_variables
  late final firstCamera;

  @override
  void onInit() {
    super.onInit();
    menuItems.addAll([
      DrawerItem('assets/svg/home_shop.svg', 'Shops', () {
        Get.toNamed(Routes.SHOPS);
      }),
      DrawerItem('assets/svg/route.svg', 'My Route', () {
        Get.toNamed(Routes.MYROUTE);
      }),
      DrawerItem('assets/svg/home_user.svg', 'Attendance', () {
        Get.toNamed(Routes.ATTENDANCE_REPORT);
      }),

      DrawerItem('assets/svg/home_list.svg', 'My Visit', () {
        Get.toNamed(Routes.MYVISIT);
      }),
      DrawerItem('assets/svg/home_checklist.svg', 'My Orders', () {
        Get.toNamed(Routes.ORDER_HISTORY);
      }),
      DrawerItem('assets/svg/expiryproduct.svg', 'Expiry Products', () {
        Get.toNamed(Routes.EXPIRY_PRODUCTS);
      }),
      // DrawerItem('assets/svg/payments.svg', 'Payments', () {
      //   Get.bottomSheet(const PaymentBottomSheet(),
      //       backgroundColor: Colors.white,
      //       enableDrag: false,
      //       elevation: 4,
      //       shape: bottomSheetShape());
      // }),
    ]);

    startCamera();
  }

  void onClickDivision(String value) {
    selectedValue = value;
    //  print(value);
    update();
  }

  void updateSelectedValue(String value) {
    label.value = value;
  }

  void startCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  void getLocation(BuildContext context) async {
    DialogHelper.showLoading('Fetching Location');
    final position = await determinePosition();
    if (position == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please grant Location permission in app settings'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Open Settings',
          onPressed: () {
            openAppSettings();
          },
        ),
      ));
    }
    DialogHelper.hideLoading();
    if (position != null) {
      final locationStatus = await getCurrentPos(position);

      if (locationStatus) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CameraView(camera: cameras[direction])));
      }
    }
  }

  Future<bool> getCurrentPos(Position position) async {
    try {
      curlat = position.latitude.toString();
      curlog = position.longitude.toString();

      List<Placemark> coordinates = await placemarkFromCoordinates(
          double.parse(curlat), double.parse(curlog));
      // print(coordinates);

      Placemark geoAddress = coordinates.first;
      place = geoAddress.locality ?? 'No Location';
      locality = geoAddress.subLocality ?? '';

      return true;
    } catch (e) {
      //  print(e.toString());
      return false;
    }
  }

  Future<void> getAttendance() async {
    isLoadingAttendance(true);
    try {
      final response = await ApiProvider().viewAttendance(Session.userId);
      if (response != null && response.data.isNotEmpty) {
        attendance = response.data.first;
      }
    } catch (e) {
      contactAdministrationSnackBar('Something Went Wrong', e.toString());
    } finally {
      isLoadingAttendance(false);
    }
  }

  void markAttendance(String imagePath) async {
    dynamic returnResponse = await openDialog(
        "Are you sure want to Login?", "Login for Today's attendance");
    if (returnResponse == true) {
      uploadAttendance(imagePath);
    }
  }

  Future<void> uploadAttendance(String imagePath) async {
    isLoadingAttendance(true);
    try {
      final response = await ApiProvider().markSignIn(
          Session.userId,
          curlat,
          curlog,
          "${locality ?? 'No location'}, ${place ?? ''}",
          imagePath.split('/').last,
          File(imagePath));
      if (response != null) {
        getAttendance();
        if (response.status) {
          attendance = response.data.first;

          Get.back();
          getAttendance();
        }
      }
    } catch (e) {
      contactAdministrationSnackBar('Something Went Wrong', e.toString());
    } finally {
      isLoadingAttendance(false);
    }
  }

  int hoursBetween(DateTime from, DateTime to) {
    return (to.difference(from).inHours);
  }

  String workingHours(DateTime from, DateTime to) {
    Duration difference = to.difference(from);
    String hours = (difference.inHours % 12).toString().padLeft(2, '0');
    String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');

    return ('$hours:$minutes');
  }

  String message(int hours) {
    String message = '';
    if (hours <= 2) {
      message =
          'Are you sure you want to End your Days Visit?. Are you not working today ?';
    } else if (hours <= 5) {
      message =
          'Are you sure you want to End your Days Visit?. Are you on half day leave ?';
    } else {
      message =
          'Are you sure you want to End your Days Visit?. Once Your logged out you cannot Login for the Day !';
    }
    return message;
  }

  bool isVisibleRemarkField(int hours) {
    bool isVisible = false;
    if (hours <= 2) {
      isVisible = true;
    } else if (hours <= 5) {
      isVisible = true;
    } else {
      isVisible = false;
    }
    return isVisible;
  }

  void marklogout() async {
    final hourCount = hoursBetween(
        getFormatedDate6(attendance.checkindate.toString()), DateTime.now());

    final workHour = workingHours(
        getFormatedDate6(attendance.checkindate.toString()), DateTime.now());

    dynamic returnResponse = await openMsgDialog(
        "End your Days Visit ?", message(hourCount),
        remark: isVisibleRemarkField(hourCount) ? remarkController : null);

    if (returnResponse == true) {
      DialogHelper.showLoading("fetching Location ...");
      final position = await determinePosition();

      if (position != null) {
        await getCurrentPos(position);
      }

      DialogHelper.hideLoading();

      checkOutAttendance(
          workHour, remarkController.text.trimLeft().trimRight());
    }
  }

  Future<void> checkOutAttendance(String workHour, String remark) async {
    isLoadingAttendance(true);
    try {
      final response = await ApiProvider().markSignOut(
          Session.userId,
          curlat,
          curlog,
          "${locality ?? 'No location'}, ${place ?? ''}",
          workHour,
          remark);
      if (response != null) {
        if (response.status) {
          await getAttendance();
          remarkController.clear();

          Get.back();
        }
      }
    } catch (e) {
      contactAdministrationSnackBar('Something Went Wrong', e.toString());
    } finally {
      isLoadingAttendance(false);
    }
  }
}
