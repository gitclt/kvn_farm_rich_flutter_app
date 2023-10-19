import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/bottomsheet/expiry_product_bottom_sheet.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/expiry_home_product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/expiry_product_details_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/date_picker/attendance_date_picker.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

import '../controllers/expiry_products_controller.dart';

class ExpiryProductsDetailsView extends GetView<ExpiryProductsController> {
  const ExpiryProductsDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: const CommonAppBar(
        label: "Expiry Products",
        visibility: true,
      ),
      body: Column(
        children: [
          Obx(() => AttendanceDatePicker(
                bgColor: visitDividerColor,
                date: controller.date.value,
                changeDate: () {},
                decrement: () {
                  controller.decrementDay();
                },
                increment: () {
                  controller.incrementDay();
                },
              )),
          const SizedBox(
            height: 15,
          ),
          ExpiryHomeProductCard(
            visible: false,
            location: "Turmeric Powder",
            ontap: () {},
            shopname: '#1236',
            image: "assets/image/product.png",
          ).paddingOnly(left: 10),
          const Divider(
            color: Color(0xffE2E2E2),
            thickness: 1.5,
          ),
          Row(
            children: [
              blackText("Total Qty : ", 16, fontWeight: FontWeight.w500),
              redText("607", 16, fontWeight: FontWeight.w600)
            ],
          ).paddingOnly(left: 20, top: 10),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 500),
                        horizontalOffset: 50.0,
                        child: ExpiryProductDetailsCard(
                          visible: true,
                          qty: "15",
                          location:
                              "Crystal Building, Malad, Rathodi, Mankavu, Calicut",
                          shopname: 'PRINCE AGENCIES',
                          ontap: () {
                            Get.bottomSheet(
                              ExpiryProductBottomSheet(
                                length: 10,
                                location:
                                    "Crystal Building, Malad, Rathodi, Mankavu, Calicut",
                                ontap: () {
                                  Get.back();
                                  Get.toNamed(
                                    Routes.EXPIRY_PRODUCT_TRANSFER_VIEW,
                                  );
                                },
                                shopname: 'PRINCE AGENCIES',
                              ),
                              elevation: 20.0,
                              enableDrag: false,
                              isDismissible: true,
                              backgroundColor: Colors.white,
                              shape: bootomSheetShape(),
                            );
                          },
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
