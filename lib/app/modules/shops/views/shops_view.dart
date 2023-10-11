import 'package:intl/intl.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/shop_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/filter_popup.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';
import 'package:kvn_farm_rich/constraints/text_fields/common_searchfield.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../controllers/shops_controller.dart';

class ShopsView extends GetView<ShopsController> {
  const ShopsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: const CommonAppBar(label: 'Shops'),
        body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: CommonSearchField(
                hintText: 'Search',
                textEditingController: controller.searchtype.value == "keyword"
                    ? controller.keywordsearchcontroller
                    : controller.placesearchcontroller,
                prefixIcon: const Icon(Icons.search),
                onChanged: (value) {
                  controller.searchTypeing(value);
                },
                suffixIcon: IconButton(
                  onPressed: () async {
                    final response = await filterPopup();
                    if (response != null) {
                      controller.keywordsearchcontroller.clear();
                      controller.placesearchcontroller.clear();
                      controller.getShops();
                      controller.searchtype.value = response;
                    }
                  },
                  icon: Image.asset(
                    "assets/image/filter.png",
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: const CircularProgressIndicator().paddingAll(100),
                    )
                  : controller.leadList.isEmpty
                      ? const NoDataWidget()
                      : AnimationLimiter(
                          child: Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                itemCount: controller.leadList.length,
                                physics: const ScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final item = controller.leadList[index];
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      child: SlideAnimation(
                                        duration:
                                            const Duration(milliseconds: 350),
                                        verticalOffset: 50.0,
                                        child: ShopCard(
                                          gps: double.parse(item.lat
                                                      .toString()) !=
                                                  0
                                              ? false
                                              : double.parse(item.longi
                                                          .toString()) !=
                                                      0
                                                  ? false
                                                  : true,
                                          geoTagClick: () {
                                            controller.shopid.value = item.id
                                                .toString();
                                            controller.picLocation(
                                                controller.shopid.value);
                                          },
                                          shopname:
                                              item.name,
                                          location:
                                              "${item.place},${item.gpsLoc}",
                                          number:
                                              item.mobile,
                                          gpsonClick: () async {
                                            await MapsLauncher
                                                .launchCoordinates(
                                                    double.parse(item.lat
                                                        .toString()),
                                                    double.parse(item.longi
                                                        .toString()));
                                          },
                                          callonClick: () {
                                            PhoneCallUtils.callPhoneNumber(
                                                item.mobile
                                                    .toString());
                                          },
                                          onClick: () {
                        //                     Get.bottomSheet(
                        //                       // ignore: prefer_const_constructors
                        //                       ShopBottomsheet(allLeads: item,
                        //                       editShopClick: () {
                        //                                                    controller
                        //     .viewLeadDetails(item.id.toString());
                        // // Get.back();
                        // Get.toNamed(Routes.SHOP_EDIT,
                        //     );
                        //                       },
                        //                       ),
                        //                       elevation: 20.0,
                        //                       enableDrag: false,
                        //                       backgroundColor: Colors.white,
                        //                       shape: bootomSheetShape(),
                        //                     );
                                          },
                                        ),
                                      ));
                                }),
                          ),
                        ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // controller.clear();
          Get.toNamed(Routes.ADD_LEADS);
          controller.datecontroller = TextEditingController(
              text: DateFormat("yyyy-MM-dd").format(controller.currentDate));
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: primaryColor,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> filterPopup() {
    return Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        PopupButton(
          name: controller.items[0],
          ontap: () {
            Get.back(result: controller.items[0]);
          },
        ),
        divider1(),
        PopupButton(
          name: controller.items[1],
          ontap: () {
            Get.back(result: controller.items[1]);
          },
        ),
      ]),
    ));
  }
}
