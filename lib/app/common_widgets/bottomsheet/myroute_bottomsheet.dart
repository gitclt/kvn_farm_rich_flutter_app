import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/home_card/home_item_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/marqueetext_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/models/assigned_route_list_model.dart';
import 'package:kvn_farm_rich/app/modules/myroute/controllers/myroute_controller.dart';
import 'package:kvn_farm_rich/app/modules/myroute/views/custom_switch.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';

import '../../../constraints/common_widgets.dart';

class RouteBottomSheet extends GetView<MyrouteController> {
  final String tittle, location;
  final String kmDiff;
  final GetRouteDetails items;

  const RouteBottomSheet({
    super.key,
    required this.tittle,
    //  required this.type,
    required this.items,
    required this.location,
    required this.kmDiff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: MediaQuery.of(context).size.width * 0.85,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => controller.isVisitLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: blackText(tittle, 16,
                                    fontWeight: FontWeight.w600,
                                    textOverflow: TextOverflow.ellipsis),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: greyText(location, 12,
                                      textOverflow: TextOverflow.ellipsis)),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(
                                () => blackText(
                                    controller.leadCheckIn.isNotEmpty
                                        ? 'Check Out'
                                        : 'Check In',
                                    14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => CustomSwitch(
                                    value: controller.leadCheckIn.isNotEmpty,
                                    onChanged: (bool val) {
                                      if (controller.leadCheckIn.isEmpty ||
                                          (controller.leadCheckIn.isNotEmpty &&
                                              controller.leadCheckIn.first
                                                      .checkoutDate ==
                                                  "0001-01-01 12:00:00")) {
                                        controller.fetchLocation(
                                          context,
                                          val,
                                          kmDiff,
                                          items.visitType,
                                          items.empId.toString(),
                                          items.leadId.toString(),
                                          items.place ?? '',
                                        );
                                      } else if (val == false &&
                                          controller
                                                  .leadCheckIn.first.workhour !=
                                              "") {
                                        Get.back();
                                        toast('Already checkedin');
                                      }

                                      // items.isCheckIn!.value = val;
                                    }),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      divider1(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Wrap(
                        spacing: 12,
                        children: [
                          if (Session.roleId == '5')
                            HomeCardItem(
                              path: "assets/svg/order.svg",
                              label: "Orders",
                              ontap: () {
                                // Get.toNamed(Routes.ORDERS,
                                //     arguments: items.leadId.toString());
                              },
                            ),
                          HomeCardItem(
                            path: "assets/svg/activity.svg",
                            label: "Activity",
                            ontap: () {
                              // Get.toNamed(Routes.ACTIVITY,
                              //     arguments: items.leadId.toString());
                            },
                          ),
                          HomeCardItem(
                            path: "assets/svg/home_profile.svg",
                            label: "Profile",
                            ontap: () {
                              Get.toNamed(Routes.SHOP_PROFILE,
                                  arguments: items.leadId.toString());
                            },
                          ),
                          HomeCardItem(
                            path: "assets/svg/stock.svg",
                            label: "View Stock",
                            ontap: () {
                              Get.toNamed(Routes.STOCKS);
                            },
                          )
                        ],
                      ),

                      if (controller.leadCheckIn.isNotEmpty &&
                          controller.leadCheckIn.first.checkoutDate !=
                              "0001-01-01 12:00:00")
                        Padding(
                          padding: const EdgeInsets.only(top: 25, bottom: 10),
                          child: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: Row(
                                children: [
                                  if (controller.leadCheckIn.isNotEmpty)
                                    blackText(
                                        controller.leadCheckIn.isNotEmpty
                                            ? 'Last CheckOut : '
                                            : "",
                                        13),
                                  blackText(
                                      controller.leadCheckIn.isNotEmpty
                                          ? formatDateStr(controller
                                              .leadCheckIn.first.checkoutDate
                                              .toString())
                                          : "",
                                      13,
                                      fontWeight: FontWeight.bold),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  blackText(
                                    controller.leadCheckIn.isNotEmpty
                                        ? 'Working Hr : '
                                        : "",
                                    13,
                                  ),
                                  blackText(
                                      controller.leadCheckIn.isNotEmpty
                                          ? '${controller.leadCheckIn.first.workhour}'
                                          : "",
                                      13,
                                      fontWeight: FontWeight.bold)
                                ],
                              )),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            PhoneCallUtils.callPhoneNumber(
                                controller.phoneNumber.value.toString());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [Color(0xff6dfa56), Color(0xff31cd40)],
                              ),
                            ),
                            child: svgWidget('assets/svg/Call.svg',
                                size: 15,
                                color: Colors.white,
                                blendMode: BlendMode.srcIn),
                          ),
                        ),
                      ),

                      // Visibility(
                      //   visible: (controller.leadCheckIn.isNotEmpty &&
                      //           controller.leadCheckIn.first.checkoutDate !=
                      //               '0001-01-01 12:00:00')
                      //       ? true
                      //       : false,
                      //   child: Wrap(
                      //     children: [
                      //       if (controller.leadCheckIn.isNotEmpty)
                      //         blackText(
                      //             controller.leadCheckIn.isNotEmpty
                      //                 ? 'Last CheckOut : '
                      //                 : "",
                      //             15,
                      //             fontWeight: FontWeight.bold),
                      //       blackText(
                      //           controller.leadCheckIn.isNotEmpty
                      //               ? '${controller.leadCheckIn.first.checkoutDate}'
                      //               : "",
                      //           14),
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       blackText(
                      //           controller.leadCheckIn.isNotEmpty
                      //               ? 'Working Hr : '
                      //               : "",
                      //           15,
                      //           fontWeight: FontWeight.bold),
                      //       blackText(
                      //           controller.leadCheckIn.isNotEmpty
                      //               ? '${controller.leadCheckIn.first.workhour}'
                      //               : "",
                      //           14)
                      //     ],
                      //   ),
                      //  )
                    ]),
        ),
      ),
    );
  }
}
