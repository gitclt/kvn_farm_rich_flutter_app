import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/profile_controller.dart';
import 'package:kvn_farm_rich/app/modules/home/views/profile/profile_view.dart';

class EditProfileView extends GetView<ProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(label: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
          child: Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      const ProfileImgWidget(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            blackText('Name', 18, fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 5,
                            ),
                            CommonTextFeild(
                              hintText: 'Name',
                              // labelText: controller.profileList.first.name,
                              textEditingController: controller.namecontroller,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            blackText('Email', 18, fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 5,
                            ),
                            CommonTextFeild(
                              hintText: 'Email',
                              // labelText: controller.profileList.first.email,
                              textEditingController: controller.emailcontroller,
                            ),
                          ],
                        ),
                      ),
                      //  const Spacer(),
                    ],
                  ),
                )),
        ),
      ),
      bottomNavigationBar: Obx(() => controller.editLoading.value
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: CommonButtonWidget(
                label: "SAVE",
                isLoading: controller.editLoading.value,
                onClick: () {
                  FocusScope.of(context).unfocus();
                  if (controller.formKey.currentState!.validate()) {
                    controller.editProfile();
                  }
                },
              ),
            )),
    );
  }
}
