import 'dart:io';

import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController {

  final guestlogin = Get.arguments;
  // final aRouteList = <GetRouteDetails>[].obs;
  // final markTypes = <MarkVisitTypes>[].obs;
  // final offlinecheckoutList = <CheckOutModel>[].obs;
  var selectedDate = DateTime.now().obs;
  final isLoading = false.obs;
  @override
  void onInit() {
   
    super.onInit();

     Future.delayed(const Duration(seconds: 2), () async {
      checkAppVersion().then(
        (value) {
          checkLoginStatus();
        },
      );
    });
  }

  Future<void> checkAppVersion() async {
    // bool responses = await ApiProvider().checkInternet();
    // if (responses == false) {
    //   Get.offAndToNamed(Routes.OFFLINE_VIEW);
    // }
    final response = await ApiProvider().getAppVersion();
    if (response != null) {
      if (AppSettings().appVersionNo < int.parse(response.versioCode)) {
        return Get.offAllNamed(Routes.APP_VERSION);
      }
    }
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");

    if (id != null) {
      Session.userId = id;

      final response = await ApiProvider().getProfile(id);
      if (response != null) {
        if (response.status == true) {
          // getAssignedRoutes();
          // getMarkTypes();

          Session.userName = response.data.name.toString();
          Session.userMobile = response.data.mobile.toString();
          Session.code = response.data.code.toString();
          Session.roleId = response.data.roleId.toString();
          Session.zsmId = response.data.zsmId.toString();
          Get.offAndToNamed(Routes.HOME);
          checkLastCheckinDate();
        }
      } else {}
    } else {
      Get.offAndToNamed(Routes.RETAILER_LOGIN);
    }
  }

  Future<void> checkForUpdate() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid
          ? 'com.vkcparivar.mobileapp'
          : 'com.vkcparivar.mobileapp';
      final url = Uri.parse(
        Platform.isAndroid
            ? "https://play.google.com/store/apps/details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void checkLastCheckinDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('login_date') == false) {
      updateLastLoginDetails();
    } else if (DateTime.parse(prefs.getString('login_date')!).day !=
            DateTime.now().day ||
        DateTime.parse(prefs.getString('login_date')!).month !=
            DateTime.now().month ||
        DateTime.parse(prefs.getString('login_date')!).year !=
            DateTime.now().year) {
      updateLastLoginDetails();
    }
  }

  void updateLastLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String? token = await FirebaseMessaging.instance.getToken();
    final response = await ApiProvider().updateUserLoginStatus();

    if (response != null) {
      if (response.status) {
        prefs.setString("login_date", DateTime.now().toString());
      }
    }
  }
}
