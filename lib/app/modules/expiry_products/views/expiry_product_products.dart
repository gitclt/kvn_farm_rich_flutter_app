import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/expiry_home_product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/date_picker/attendance_date_picker.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

import '../controllers/expiry_products_controller.dart';

class ExpiryProductProductsView extends GetView<ExpiryProductsController> {
  const ExpiryProductProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      child: FlipAnimation(
                        duration: const Duration(milliseconds: 1000),
                        child: Column(
                          children: [
                            ExpiryHomeProductCard(
                              visible: true,
                              location: "Turmeric Powder",
                              ontap: () {
                                Get.toNamed(
                                    Routes.EXPIRY_PRODUCT_PRODUCTS_DETAILS);
                              },
                              shopname: '#1236',
                              image: "assets/image/product.png",
                            ),
                            const Divider(
                              color: Color(0xffE2E2E2),
                              thickness: 1.5,
                            )
                          ],
                        ),
                      ));
                }),
          ),
        ],
      )),
    );
  }
}
