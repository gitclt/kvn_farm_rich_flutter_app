import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/cart_view.dart';
import 'package:kvn_farm_rich/app/modules/home/model/drawer_model.dart';
import 'package:kvn_farm_rich/app/modules/home/views/home_view.dart';
import 'package:kvn_farm_rich/app/modules/home/views/profile/profile_view.dart';
import 'package:kvn_farm_rich/app/modules/home/views/search_view.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  final CartController cartController = Get.find();
  RxInt selectedIndex = 0.obs;
  RxList<Widget> widgetOptions = <Widget>[
    const HomeView(),
    const SearchView(),
    const ProfileView(),
    const CartView()
  ].obs;
  final drawerItems = <DrawerItem>[].obs;
  final GlobalKey<ScaffoldState> dashboardScaffoldkey =
      GlobalKey<ScaffoldState>();

  @override
  void onInit() async {
    super.onInit();
    await cartController.getData();

    drawerItems.addAll([
      DrawerItem('assets/svg/bottom_home.svg', 'Home', () {
        selectedIndex(0);
        Get.back();
      }),
      DrawerItem('assets/svg/home_user.svg', 'Attendance', () {
        Get.toNamed(Routes.ATTENDANCE_REPORT, arguments: "");
      }),
      DrawerItem('assets/svg/route.svg', 'My Route', () {
        Get.toNamed(Routes.MYROUTE, arguments: "");
        // Get.back();
      }),
      DrawerItem('assets/svg/home_shop.svg', 'Shops', () {
        Get.toNamed(Routes.SHOPS);
        // Get.back();
      }),
      DrawerItem('assets/svg/home_list.svg', 'My Visit', () {
        Get.toNamed(Routes.MYVISIT, arguments: "");
      }),
      DrawerItem('assets/svg/order.svg', 'My Orders', () {
        Get.toNamed(Routes.ORDER_HISTORY);
      }),
      DrawerItem('assets/svg/logout.svg', 'Logout', () {
        Get.back();
        logOut();
      }),
    ]);
  }

  void logOut() async {
    dynamic returnResponse =
        await openDialog('Logout', 'Are you sure you want to Logout ?');
    if (returnResponse == true) {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.offAllNamed(Routes.SPLASH);
    }
  }
}
