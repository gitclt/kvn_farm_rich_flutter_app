import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
import 'package:kvn_farm_rich/app/modules/shops/controllers/shops_controller.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ShopEditView extends GetView<ShopsController> {
  const ShopEditView({super.key});

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
    return Scaffold(
      appBar: const CommonAppBar(label: 'Edit'),
      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Obx(() => controller.isDetailsLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: controller.formKey2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTextFeild(
                          readonly: true,
                          textEditingController: controller.statecontroller,
                          hintText: "State",
                          // onTap: () async {
                          //   final state = await Get.toNamed(Routes.STATE);
                          //   if (state != null) {
                          //     controller.statecontroller.text = state;
                          //   }
                          // },
                          onTap: () async {
                            controller.locationcontroller.clear();
                            final state = await Get.toNamed(Routes.STATE);
                            if (state != null) {
                              controller.statecontroller.text = state.name;
                              controller.stateid = state.id.toString();
                            }
                          },
                          // onTap: () {
                          //   Get.toNamed(Routes.STATE);
                          // },
                          suffixIcon: const Icon(
                            Icons.expand_more,
                            color: redColor,
                          ),
                        ),

                        spacer,
                        CommonTextFeild(
                          readonly: true,
                          hintText: "Place",
                          textEditingController: controller.locationcontroller,
                          onTap: () async {
                            final place = await Get.toNamed(Routes.PLACE,
                                arguments: controller.stateid.toString());
                            if (place != null) {
                              controller.locationcontroller.text = place;
                            }
                          },
                          suffixIcon: const Icon(
                            Icons.expand_more,
                            color: redColor,
                          ),
                        ),

                        spacer,
                        CommonTextFeild(
                            hintText: "Shop Name",
                            textEditingController: controller.namecontroller),
                        spacer,
                        CommonTextFeild(
                          hintText: "Address",
                          textEditingController: controller.addresscontroller,
                        ),
                        spacer,
                        CommonTextFeild(
                          hintText: "Pincode",
                          textEditingController: controller.pincodecontroller,
                        ),
                        spacer,
                        CommonTextFeild(
                          hintText: "Email",
                          textEditingController: controller.emailcontroller,
                        ),
                        spacer,
                        CommonTextFeild(
                          hintText: "Contact Person",
                          textEditingController:
                              controller.contactPersoncontroller,
                        ),
                        // spacer,
                        // CommonTextField(
                        //   hintText: 'Director',
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (_) => const UserPopup(),
                        //     );
                        //   },
                        //   suffixIcon: const Icon(
                        //     Icons.expand_more,
                        //     color: redColor,
                        //   ),
                        // ),

                        // spacer,
                        // CommonTextField(
                        //   hintText: 'Mobile',
                        //   textEditingController: controller.mobilecontroller,
                        // ),
                        // spacer,
                        // SizedBox(
                        //   height: 100,
                        //   child: CommonTextField(
                        //     hintText: 'Grade',
                        //     textEditingController: controller.currentGradecontroller,
                        //     expands: true,
                        //   ),
                        // ),
                        spacer,
                        spacer,
                        CommonButtonWidget(
                            label: 'UPDATE',
                            isLoading: controller.editLoading.value,
                            onClick: () {
                              FocusScope.of(context).unfocus();
                              if (controller.formKey2.currentState!
                                  .validate()) {
                                controller.editLeads(controller
                                    .shopDetailsResponse!.id
                                    .toString());
                              }
                            }),
                        // )
                      ],
                    ),
                  )),
          )),
    );
  }
}
