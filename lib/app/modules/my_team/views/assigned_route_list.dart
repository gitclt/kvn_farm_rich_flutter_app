import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_route_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/modules/my_team/controllers/shop_assign_controller.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/my_team_assign_shop.dart';
import 'package:kvn_farm_rich/app/modules/myroute/views/myroute_view.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';
import 'package:maps_launcher/maps_launcher.dart';

class AssignedRouteView extends GetView<ShopAssignController> {
  const AssignedRouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(label: "My Route"),
      // backgroundColor: scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployeeDetails(
              name: controller.value.name.toString(),
              number: controller.value.mobile.toString(),
              desig: controller.value.designationName,
            ),
            const Divider(
              color: Color(0xffE2E2E2),
              thickness: 1.5,
            ),
            Calender(onChange: (DateTime value) {
              controller.changeDate(value);
            }),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 2,
            ),
            Obx(
              () => controller.isLoading.value
                  // ignore: prefer_const_constructors
                  ? Center(child: const CircularProgressIndicator())
                  : controller.routeListResponse.isEmpty
                      ? const NoDataWidget()
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.routeListResponse.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {},
                                      child: MyRouteCard(
                                        gps: " MAP",
                                        shopname: controller
                                            .routeListResponse[index].leadname,
                                        location:
                                            '${controller.routeListResponse[index].place},${controller.routeListResponse[index].gpsLoc}',
                                        number: controller
                                            .routeListResponse[index].mobile,
                                        status: controller
                                            .routeListResponse[index].visitType,
                                        visitStatus: 'Not visited',
                                        onTapGps: () async {
                                          await MapsLauncher.launchCoordinates(
                                              double.parse(controller
                                                  .routeListResponse[index].lat
                                                  .toString()),
                                              double.parse(controller
                                                  .routeListResponse[index]
                                                  .longi
                                                  .toString()));
                                        },
                                        onTapCall: () {
                                          PhoneCallUtils.callPhoneNumber(
                                              controller
                                                  .routeListResponse[index]
                                                  .mobile
                                                  .toString());
                                        },
                                      ).paddingAll(5),
                                    ),
                                    divider1()
                                  ],
                                );
                              }),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.selectedRoute.value = '';
          controller.getNotAssignedRoutes();
          controller.uncheckValues();

          await Get.toNamed(Routes.MY_TEAM_ASSIGN_SHOP);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // circular shape
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
}
