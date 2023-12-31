import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    bool shouldNavigateToFirstTab = false;
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value != 0) {
          shouldNavigateToFirstTab = true;
          controller.selectedIndex.value = 0;
          return false;
        } else if (shouldNavigateToFirstTab) {
          shouldNavigateToFirstTab = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Obx(() => Center(
            child: controller.widgetOptions
                .elementAt(controller.selectedIndex.value))),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedIndex.value,
              elevation: 0,
              onTap: (int index) async {
                controller.selectedIndex.value = index;
                if (index == 3) {
                  Get.put(MasalaController());

                  final CartController cartController = Get.find();
                  await cartController.getData();
                } else {
                  Get.delete<MasalaController>();
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: svgWidget('assets/svg/bottom_home.svg',
                          color: controller.selectedIndex.value == 0
                              ? redColor
                              : Colors.black),
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: svgWidget('assets/svg/bottom_search.svg',
                          color: controller.selectedIndex.value == 1
                              ? redColor
                              : Colors.black),
                    ),
                    label: 'Search'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: svgWidget('assets/svg/bottom_profile.svg',
                          color: controller.selectedIndex.value == 2
                              ? redColor
                              : Colors.black),
                    ),
                    label: 'Profile'),
                BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        svgWidget('assets/svg/shop_cart.svg',
                            color: controller.selectedIndex.value == 3
                                ? redColor
                                : Colors.black),
                        Obx(() => (cartController.cartlist.isNotEmpty)
                            ? Positioned(
                                bottom: 8,
                                left: 11,
                                child: circleWidgetWithText(
                                  20,
                                  red2Color,
                                  cartController.cartlist.length.toString(),
                                  Colors.white,
                                ),
                              )
                            : const SizedBox()),
                      ],
                    ),
                    label: 'Cart')
              ]),
        ),
      ),
    );
  }
}
