import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_team_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/routes_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/textfield_with_baorder.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/my_team/controllers/shop_assign_controller.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MyTeamAssigShopView extends GetView<ShopAssignController> {
  const MyTeamAssigShopView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(label: "Assign Shop"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoarderTextField(
                hintText: "Search Shops....",
                textEditingController: controller.keywordController,
                // controller.searchResponse.value == "keyword"

                onChanged: (value) {
                  controller.onSearch(value);
                },
                // suffixIcon: IconButton(
                //   icon: Image.asset(
                //     "assets/image/filter.png",
                //     //color: Colors.white,
                //     width: 20,
                //     height: 20,
                //   ),
                //   onPressed: () async {
                //     final value = await searchPopup();
                //     if (value != null) {
                //       controller.keywordController.clear();
                //       //  controller.placeController.clear();
                //       controller.getNotAssignedRoutes();
                //       // controller.searchResponse.value = value;
                //     }
                //   },
                // ),
              ).paddingOnly(top: 5),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => RoutesPopup(
                                  onClick: () async {
                                    final response =
                                        await controller.getAssignedPlaces();
                                    if (response != null) {
                                      String placename = response.join(',');
                                      controller.selectedRoute.value =
                                          placename;
                                      controller.getNotAssignedRoutes();
                                    }
                                  },
                                  isLoading: controller.placeLoading.value,
                                  children: controller.routePlaceList));
                        },
                        child: Row(
                          children: [
                            svgWidget('assets/svg/location.svg',
                                color: Colors.red),
                            const SizedBox(
                              width: 5,
                            ),
                            greyText(
                              fontWeight: FontWeight.w400,
                              controller.selectedRoute.value == ""
                                  ? 'Select Place'
                                  : controller.selectedRoute.value,
                              15,
                            )
                          ],
                        ),
                      ),
                    ),
                    rectangleRedBg(Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
                      child: Row(
                        children: [
                          blackText('Shops', 14, fontWeight: FontWeight.w500),
                          const SizedBox(
                            width: 5,
                          ),
                          Obx(() => redText(
                              ' ${controller.notrouteListResponse.length}', 14,
                              fontWeight: FontWeight.w600))
                        ],
                      ),
                    ))
                  ],
                ),
              ),
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
                                itemBuilder: (BuildContext context, int index) {
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
                                          await MapsLauncher.launchCoordinates(
                                              double.parse(item.lat.toString()),
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
