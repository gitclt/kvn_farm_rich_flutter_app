import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/auth_model.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';

class ProfileController extends GetxController {
  DashboardController dashBoardController = Get.find();
  var isLoading = false.obs;
  var editLoading = false.obs;
  var profileList = <AuthData>[].obs;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  void getProfile() async {
    isLoading(true);
    profileList.clear();

    clear();
    try {
      final response = await ApiProvider().getProfile(Session.userId);
      if (response != null) {
        if (response.status == true) {
          profileList.add(response.data);
          // updateTextValue();
        } else {
          isLoading(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  updateTextValue() {
    namecontroller = TextEditingController(text: profileList.first.name);
    emailcontroller = TextEditingController(text: profileList.first.email);
  }

  void editProfile() async {
    editLoading(true);

    try {
      final response = await ApiProvider().editProfile(
          id: Session.userId,
          name: namecontroller.text == ''
              ? profileList.first.name
              : namecontroller.text,
          code: profileList.first.code,
          password: profileList.first.password,
          mobile: profileList.first.mobile,
          email: emailcontroller.text == ''
              ? profileList.first.email
              : emailcontroller.text,
          state: profileList.first.state,
          place: profileList.first.address);
      if (response != null) {
        if (response.status == true) {
          toast(
            response.message,
          );
          getProfile();
          Get.back();
        } else {
          editLoading(false);
        }
      }
    } finally {
      editLoading(false);
    }
  }

  clear() {
    namecontroller.clear();
    emailcontroller.clear();
  }
}
