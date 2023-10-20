import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/home_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/home_card/home_item_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/home/views/drawer/drawer_view.dart';
import 'package:kvn_farm_rich/app/modules/home/widget/emp_checkin_card.dart';
import 'package:kvn_farm_rich/app/modules/home/widget/emp_checkout_card.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var sizedBox = const SizedBox(
      height: 12,
    );

    return Scaffold(
        key: controller.dashBoardController.dashboardScaffoldkey,
        drawer: const DrawerView(),
        appBar: HomeAppBar(
          label: 'Home',
          onClick: () {
            controller.dashBoardController.dashboardScaffoldkey.currentState
                ?.openDrawer();
          },
        ),
        backgroundColor: scaffoldBgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => controller.isLoadingAttendance.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: redColor,
                              ))
                            : controller.attendance.checkindate == null
                                ? const EmpCheckInCard()
                                : const EmpCheckOutCard(),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      blackText(
                        'Menu',
                        22,
                        fontWeight: FontWeight.w700,
                      ),
                      sizedBox,
                      const MenuItems(),

                      const SizedBox(
                        height: 20,
                      ),
                      blackText('Categories', 22, fontWeight: FontWeight.w700),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeCategories(
                            path: 'assets/image/blend_masala.png',
                            label: 'BLENDED \nMASALA',
                            onClick: () async {
                              Get.toNamed(Routes.PRODUCT);
                            },
                          ),
                          HomeCategories(
                            path: 'assets/image/spice_powder.png',
                            label: 'SPICES \nPOWDER',
                            onClick: () {
                              Get.toNamed(Routes.PRODUCT);
                            },
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // blackText('Explore Brands', 22, fontWeight: FontWeight.w700),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.10,
                      //   child: ListView.builder(
                      //       itemCount: 3,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (context, index) {
                      //         return BrandCard(
                      //           path: controller.brands[index],
                      //         );
                      //       }),
                      // )
                    ]),
              ),
            ],
          ),
        ));
  }
}

class TopWidget extends GetView<HomeController> {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Text(
            controller.label.value.isEmpty
                ? controller.selectedValue
                : controller.label.value,
            style: const TextStyle(
                color: redColor,
                fontFamily: "Manrope",
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        IconButton(
            onPressed: () {
              Get.bottomSheet(
                      SelectDivision(divisions: controller.divisionItems),
                      elevation: 20.0,
                      enableDrag: false,
                      isDismissible: true,
                      backgroundColor: scaffoldBgColor,
                      shape: bottomSheetShape())
                  .then((value) {
                if (value != null) {
                  controller.updateSelectedValue(value);
                }
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: redColor,
            ))
      ],
    );
  }
}

class MenuItems extends GetView<HomeController> {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 15,
      children: [
        HomeCardItem(
          path: 'assets/svg/home_shop.svg',
          label: 'Shops',
          ontap: () {
            Get.toNamed(Routes.SHOPS);
          },
        ),
        if (Session.roleId != '5' && Session.roleId != '3')
          HomeCardItem(
            path: 'assets/svg/route.svg',
            label: 'My Route',
            ontap: () {
              Get.toNamed(Routes.MYROUTE, arguments: "");
            },
          ),
        HomeCardItem(
          path: 'assets/svg/home_user.svg',
          label: 'Attendance',
          ontap: () {
            Get.toNamed(Routes.ATTENDANCE_REPORT, arguments: "");
          },
        ),
        if (Session.roleId != '5' && Session.roleId != '3')
          HomeCardItem(
            path: 'assets/svg/home_list.svg',
            label: 'My Visit',
            ontap: () {
              Get.toNamed(Routes.MYVISIT, arguments: "");
            },
          ),
        if (Session.roleId == '3')
          HomeCardItem(
            path: 'assets/svg/expiryproduct.svg',
            label: 'My Teams',
            ontap: () {
              Get.toNamed(Routes.MY_TEAM);
            },
          ),
        HomeCardItem(
          path: 'assets/svg/home_checklist.svg',
          label: 'My Orders',
          ontap: () {
            Get.toNamed(Routes.ORDER_HISTORY);
          },
        ),
        HomeCardItem(
          path: 'assets/svg/expiryproduct.svg',
          label: 'Expiry Products',
          ontap: () {
            Get.toNamed(Routes.EXPIRY_PRODUCTS);
          },
        ),
      ],
    );
  }
}


// SizedBox(
//   width: Get.width * 0.9,
//   child: Wrap(
//     spacing: 10,
//     runSpacing: 10,
//     children: [
//       HomeCardItem(
//         path: 'assets/svg/home_user.svg',
//         label: 'Attendance',
//         ontap: () {
//           Get.toNamed(Routes.ATTENDANCE_REPORT);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/route.svg',
//         label: 'My Route',
//         ontap: () {
//           Get.toNamed(Routes.MYROUTE);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/home_shop.svg',
//         label: 'Shops',
//         ontap: () {
//           Get.toNamed(Routes.SHOPS);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/home_list.svg',
//         label: 'My Visit',
//         ontap: () {
//           Get.toNamed(Routes.MYVISIT);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/home_checklist.svg',
//         label: 'My Order',
//         ontap: () {
//           Get.toNamed(Routes.ORDER_HISTORY);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/home_profile.svg',
//         label: 'Profile',
//         ontap: () {
//           // Get.toNamed(Routes.ProfileView);
//         },
//       ),
//       HomeCardItem(
//         path: 'assets/svg/call_center.svg',
//         label: 'Support',
//         ontap: () {
//           Get.toNamed(Routes.SUPPORT);
//         },
//       ),
//     ],
//   ),
// ),
