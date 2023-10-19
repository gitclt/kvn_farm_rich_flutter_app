import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';

class MasalaController extends GetxController {
  DashboardController dashBoardController = Get.find();
  final tabController = TabController(length: 2, vsync: NavigatorState());
  final List<Color> colors = [Colors.white, Colors.black];


  @override
  void onInit() {
    super.onInit();
    
  }
  
}
