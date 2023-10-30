import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/api_provider.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController passWordController = TextEditingController(text: "");
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  final isObscureText = true.obs;

   void login() async {
    isLoading(true);

    try {
      final response = await ApiProvider().login(
          userNameController.text.trim(), passWordController.text.trim());
      if (response != null) {
        if (response.status == true) {
          isLoading(false);
         // toast('Login successfully');
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('id', response.data.first.id.toString());
          // prefs.setString('name', response.data.first.name.toString());

          Get.offAllNamed(Routes.SPLASH);
        } else {
          isLoading(false);
          toast(response.message);
        }
      }
    } finally {
      isLoading(false);
    }
  }

}
