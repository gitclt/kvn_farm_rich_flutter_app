import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
// import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_route_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/my_team_assign_shop.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';
import 'package:kvn_farm_rich/constraints/pop-up.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../common_widgets/bottomsheet/myroute_bottomsheet.dart';
import '../../order_history/views/order_history_view.dart';
import '../controllers/myroute_controller.dart';

class MyrouteView extends GetView<MyrouteController> {
  const MyrouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    return Scaffold(
      appBar: const CommonAppBar(label: "My Route"),
      // backgroundColor: scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.argumet != "")
              EmployeeDetails(
                name: controller.argumet.name.toString(),
                number: controller.argumet.mobile.toString(),
                desig: controller.argumet.designationName,
              ),
            Calender(onChange: controller.changeDate),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Obx(
                  //   () => InkWell(
                  //     onTap: () {
                  //       showDialog(
                  //           context: context,
                  //           builder: (_) => RoutesPopup(
                  //               onClick: () async {
                  //                 final response =
                  //                     await controller.getAssignedPlaces();
                  //                 if (response != null) {
                  //                   String placename = response.join(',');
                  //                   controller.selectedRoute.value = placename;
                  //                 }
                  //               },
                  //               isLoading: controller.placeLoading.value,
                                
                  //               children: controller.routePlaceList));
                  //     },
                  //     child: Row(
                  //       children: [
                  //         svgWidget('assets/svg/location.svg',
                  //             color: Colors.red),
                  //         const SizedBox(
                  //           width: 5,
                  //         ),
                  //         greyText(
                  //           fontWeight: FontWeight.w400,
                  //           controller.selectedRoute.value == ""
                  //               ? 'Select Place'
                  //               : controller.selectedRoute.value,
                  //           15,
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  rectangleRedBg(Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 12.0),
                    child: Row(
                      children: [
                        blackText('Shops Visited', 14,
                            fontWeight: FontWeight.w500),
                        const SizedBox(
                          width: 5,
                        ),
                        Obx(() => redText(
                            ' ${controller.shopvisitlist.length}/${controller.aRouteList.length}',
                            14,
                            fontWeight: FontWeight.w600))
                      ],
                    ),
                  ))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 2,
            ),
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.aRouteList.isEmpty
                      ? const NoDataWidget()
                      : AnimationLimiter(
                          child: Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.aRouteList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final items = controller.aRouteList[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        controller.phoneNumber.value =
                                            items.mobile;
                                        if (items.visitstatus != 1) {
                                          if (today.year ==
                                                  controller
                                                      .selectedDate.value.year &&
                                              today.month ==
                                                  controller.selectedDate.value
                                                      .month &&
                                              today.day ==
                                                  controller
                                                      .selectedDate.value.day) {
                                            dynamic disValue =
                                                await controller.getLocation(
                                                    double.parse(
                                                        items.lat.toString()),
                                                    double.parse(items.longi
                                                        .toString()));
                                            if (disValue <= 3 ||
                                                controller
                                                    .leadCheckIn.isNotEmpty ||
                                                items.visitstatus == 1) {
                                              await controller.getTodayCheckIn(
                                                items.empId.toString(),
                                                items.leadId.toString(),
                                                items.visitType,
                                              );
                                              Get.bottomSheet(
                                                RouteBottomSheet(
                                                  kmDiff: disValue
                                                      .toStringAsFixed(2),
                                                  tittle: items.leadname,
                                                  // type: "Retailer",
                                                  location: items.place ?? "",
                                                  items: items,
                                                ),
                                                elevation: 20.0,
                                                enableDrag: false,
                                                backgroundColor: Colors.white,
                                                shape: bootomSheetShape(),
                                              );
                                            } else {
                                              dynamic status =
                                                  await routeDialog();
                                              if (status == true) {
                                                await controller
                                                    .getTodayCheckIn(
                                                  items.empId.toString(),
                                                  items.leadId.toString(),
                                                  items.visitType,
                                                );

                                                Get.bottomSheet(
                                                  RouteBottomSheet(
                                                    kmDiff: disValue.toString(),
                                                    tittle: items.leadname,
                                                    // type: "Retailer",
                                                    location: items.place ?? "",
                                                    items: items,
                                                  ),
                                                  elevation: 20.0,
                                                  enableDrag: false,
                                                  backgroundColor: Colors.white,
                                                  shape: bootomSheetShape(),
                                                );
                                              }
                                            }
                                          } else {
                                            toast(
                                                'Sorry!! This is not assigned for today');
                                          }
                                        } else {
                                          await controller.getTodayCheckIn(
                                            items.empId.toString(),
                                            items.leadId.toString(),
                                            items.visitType,
                                          );

                                          Get.bottomSheet(
                                            RouteBottomSheet(
                                              kmDiff: '',
                                              tittle: items.leadname,
                                              // type: "Retailer",
                                              location: items.place ?? '',
                                              items: items,
                                            ),
                                            elevation: 20.0,
                                            enableDrag: false,
                                            backgroundColor: Colors.white,
                                            shape: bootomSheetShape(),
                                          );
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyRouteCard(
                                            shopname: items.leadname,
                                            location:
                                                "${items.place},${items.gpsLoc}",
                                            number: items.mobile,
                                            status: items.visitType,
                                            visitStatus: items.visitstatus == 1
                                                ? 'Visited'
                                                : '',
                                            onTapGps: () async {
                                              await MapsLauncher
                                                  .launchCoordinates(
                                                      double.parse(controller
                                                          .aRouteList[index].lat
                                                          .toString()),
                                                      double.parse(controller
                                                          .aRouteList[index]
                                                          .longi
                                                          .toString()));
                                            },
                                            onTapCall: () {
                                              PhoneCallUtils.callPhoneNumber(
                                                  controller
                                                      .aRouteList[index].mobile
                                                      .toString());
                                            },
                                            gps: " MAP",
                                          ).paddingAll(5),
                                          divider1()
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class Calender extends StatefulWidget {
  final Function(DateTime)? onChange;

  // final DateTime selectDate;
  const Calender({
    super.key,
    this.onChange,
    // required this.selectDate,
  });

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  void changeDate(DateTime onDateChange) {
    widget.onChange!(onDateChange);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      disabledDates: previousDateDisable(),
      // headerProps: const EasyHeaderProps(
      //   selectedDateFormat: SelectedDateFormat.monthOnly,
      // ),

      onDateChange: (selectDate) {
        changeDate(selectDate);
      },
      activeColor: const Color(0xffD80005),
      dayProps: const EasyDayProps(
        height: 80.0,
        width: 65.0,
        borderColor: Color.fromARGB(255, 208, 208, 208),
        dayStructure: DayStructure.dayStrDayNum,
        todayHighlightStyle: TodayHighlightStyle.withBackground,
        todayHighlightColor: Color.fromARGB(255, 205, 227, 151),
      ),
    );
  }

  List<DateTime> previousDateDisable() {
    DateTime currentDate = DateTime.now();
    List<DateTime> disabledDates = [];
    for (int i = 1; i < currentDate.day; i++) {
      disabledDates.add(DateTime(currentDate.year, currentDate.month, i));
    }
    return disabledDates;
  }
}
