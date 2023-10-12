import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_team_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/textfield_with_baorder.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/my_team/controllers/shop_assign_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';

import 'package:maps_launcher/maps_launcher.dart';

class MyTeamAssigShopView extends GetView<ShopAssignController> {
  const MyTeamAssigShopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(label: "Assign Shop"),
      body: Obx(
        () => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.800,
                      child: BoarderTextField(
                        hintText: "Search Leads....",
                        textEditingController:
                            controller.searchResponse.value == "keyword"
                                ? controller.keywordController
                                : controller.placeController,
                        onChanged: (value) {
                          controller.onSearch(value);
                        },
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            final value = await searchPopup();
                            if (value != null) {
                              controller.keywordController.clear();
                              controller.placeController.clear();
                              controller.getNotAssignedRoutes();
                              controller.searchResponse.value = value;
                            }
                          },
                        ),
                      ).paddingOnly(top: 5),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: redColor),
                      child: IconButton(
                        onPressed: () async {
                          final res = await filterPopup();
                          if (res != null) {
                            controller.filterresponse.value = res;
                            controller.getNotAssignedRoutes();
                          }
                        },
                        icon: Image.asset(
                          "assets/image/filter.png",
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                controller.filterresponse.value == ''
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FilterItem(
                            name: controller.filterresponse.value,
                            visible: controller.filterresponse.value ==
                                    'Prospective1'
                                ? false
                                : true,
                            ontap: () {
                              controller.filterresponse.value = 'Prospective1';
                              controller.getNotAssignedRoutes();
                            },
                          ),
                        ],
                      ).paddingOnly(top: 15),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.notrouteListResponse.isEmpty
                          ? const SizedBox(child: NoDataWidget())
                          : Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount:
                                      controller.notrouteListResponse.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final item =
                                        controller.notrouteListResponse[index];
                                    return Obx(() => MyTeamAssignCard(
                                          shopname: item.name,
                                          location: item.place ?? '',
                                          number: item.mobile,
                                          selectItem: item.isSelect.value,
                                          items: item,
                                          ontap: () {
                                            item.isSelect.value =
                                                !item.isSelect.value;
                                          },
                                          onTapGps: () async {
                                            await MapsLauncher
                                                .launchCoordinates(
                                                    double.parse(
                                                        item.lat.toString()),
                                                    double.parse(
                                                        item.longi.toString()));
                                          },
                                          onTapCall: () {
                                            PhoneCallUtils.callPhoneNumber(
                                                item.mobile.toString());
                                          },
                                        ).paddingAll(5));
                                  }),
                            ),
                )
              ],
            ).paddingAll(5),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => CommonButtonWidget(
            isLoading: controller.isAssignLoading.value,
            label: "ASSIGN",
            onClick: () {
              controller.assiginRoute();
            }),
      ).paddingAll(15),
    );
  }

  Future<dynamic> filterPopup() {
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        PopupButton(
          name: controller.fitems[0],
          ontap: () {
            Get.back(result: controller.fitems[0]);
          },
        ),
        divider1(),
        PopupButton(
          name: controller.fitems[1],
          ontap: () {
            Get.back(result: controller.fitems[1]);
          },
        ),
        divider1(),
      ]),
    ));
  }

  Future<dynamic> searchPopup() {
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        PopupButton(
          name: controller.kitems[0],
          ontap: () {
            Get.back(result: controller.kitems[0]);
          },
        ),
        divider1(),
        PopupButton(
          name: controller.kitems[1],
          ontap: () {
            Get.back(result: controller.kitems[1]);
          },
        ),
      ]),
    ));
  }
}

class EmployeeDetails extends StatelessWidget {
  final String name;
  final String number;
  final String desig;
  const EmployeeDetails(
      {super.key,
      required this.name,
      required this.number,
      required this.desig});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            blackText(name, 16, fontWeight: FontWeight.w500),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                greyText(desig, 14, fontWeight: FontWeight.w400)
                    .paddingOnly(left: 0),
                const SizedBox(
                  width: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    svgWidget('assets/svg/Call.svg', size: 14),
                    const SizedBox(
                      width: 5,
                    ),
                    greyText(number, 12),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    ).paddingAll(10);
  }
}

class PopupButton extends StatelessWidget {
  final String name;
  final Function ontap;
  const PopupButton({super.key, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: Column(
          children: [
            blackText(name, 15,
                    fontWeight: FontWeight.w500, textAlign: TextAlign.center)
                .paddingAll(15),
          ],
        ),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String name;
  final Function ontap;
  final bool? visible;
  const FilterItem(
      {super.key,
      required this.name,
      required this.ontap,
      this.visible = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 2)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          blackText(name, 14, fontWeight: FontWeight.w500),
          const SizedBox(
            width: 5,
          ),
          Visibility(
            visible: visible!,
            child: InkWell(
                onTap: () {
                  ontap();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  // size: 20,
                )),
          )
        ],
      ).paddingOnly(left: 12, right: 12, top: 6, bottom: 6),
    );
  }
}
