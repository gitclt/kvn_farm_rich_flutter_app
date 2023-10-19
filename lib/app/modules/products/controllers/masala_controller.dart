import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';

class MasalaController extends GetxController {
  DashboardController dashBoardController = Get.find();
 // final tabController = TabController(length: 2, vsync: NavigatorState());
  final List<Color> colors = [Colors.white, Colors.black];
//  bool mounted = true;

  @override
  void onInit() {
    super.onInit();
  //  tabController.index = 0;
  }

  // void changeTab(int tabIndex) {
  //   if (tabController.indexIsChanging) {
  //     if (mounted) {
  //       tabController.index = tabIndex;
  //     }
  //   }
  // }

  // @override
  // void onClose() {
  //   tabController.dispose();
  //   mounted = false; // Set the flag to indicate the widget is no longer active
  //   super.onClose();
  // }
}
