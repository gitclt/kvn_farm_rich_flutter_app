import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/date_picker/attendance_date_picker.dart';
import 'package:kvn_farm_rich/app/modules/attendance_report/views/image_view.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

import '../controllers/attendance_report_controller.dart';

class AttendanceReportView extends GetView<AttendanceReportController> {
  const AttendanceReportView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: const CommonAppBar(
          label: 'Attendance Report',
        ),
        body: Column(
          children: [
            Obx(() => AttendanceDatePicker(
                  date: controller.date.value,
                  changeDate: () {
                    controller.changeDate(context);
                  },
                  decrement: () {
                    controller.decrementMonth();
                  },
                  increment: () {
                    controller.incrementMonth();
                  },
                )),
            const Divider(
              thickness: 5,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                const Icon(
                  Icons.swipe,
                  color: Colors.grey,
                  size: 15,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text("Scroll table right to left",
                    style: TextStyle(fontSize: 10)),
                const Spacer(),
                const Text(
                  "Total Work Hours",
                ),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => Text(
                      "${controller.totalWkHour} hr",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ))
              ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.only(left: 10, right: 10),
              width: double.infinity,
              color: homeMenuColor,
              height: 30,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    header(context, 'Date'),
                    header(context, 'Working Hrs'),
                    header(context, 'login'),
                    header(context, 'log out'),
                    header(context, 'Photo'),
                  ]),
            ),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator().paddingOnly(top: 200)
                : Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  formatDateStringDates(controller
                                              .monthattendenceList[index]
                                              .checkindate
                                              .toString()) ==
                                          "Sunday"
                                      ? redfooter(
                                          context,
                                          formatDateStringDates(controller
                                              .monthattendenceList[index]
                                              .checkindate
                                              .toString()))
                                      : footer(
                                          context,
                                          formatDateString(controller
                                              .monthattendenceList[index]
                                              .checkindate
                                              .toString())),
                                  footer(
                                      context,
                                      controller.monthattendenceList[index]
                                                  .workhour ==
                                              '0'
                                          ? ''
                                          : controller
                                              .monthattendenceList[index]
                                              .workhour
                                              .toString()),
                                  Column(
                                    children: [
                                      footer(
                                          context,
                                          controller.monthattendenceList[index]
                                                      .checkinLat ==
                                                  ''
                                              ? ''
                                              : formatTimeString(controller
                                                  .monthattendenceList[index]
                                                  .checkindate
                                                  .toString())),
                                      footer(
                                          context,
                                          controller.monthattendenceList[index]
                                                      .checkinLat ==
                                                  ''
                                              ? ''
                                              : controller
                                                  .monthattendenceList[index]
                                                  .checkinLoc!)
                                    ],
                                  ),
                                  controller.monthattendenceList[index]
                                              .checkoutdate !=
                                          null
                                      ? Column(
                                          children: [
                                            footer(
                                                context,
                                                controller
                                                            .monthattendenceList[
                                                                index]
                                                            .checkinLat ==
                                                        ''
                                                    ? ''
                                                    : formatTimeString(controller
                                                        .monthattendenceList[
                                                            index]
                                                        .checkoutdate
                                                        .toString())),
                                            footer(
                                                context,
                                                controller
                                                            .monthattendenceList[
                                                                index]
                                                            .checkinLat ==
                                                        ''
                                                    ? ''
                                                    : controller
                                                        .monthattendenceList[
                                                            index]
                                                        .checkoutLoc
                                                        .toString())
                                          ],
                                        )
                                      : const SizedBox(
                                          width: 80,
                                        ),
                                  controller.monthattendenceList[index].photo ==
                                          ''
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            if (controller
                                                    .monthattendenceList[index]
                                                    .photo ==
                                                "") return;

                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CustomImageAlertBox(
                                                      image: controller
                                                          .monthattendenceList[
                                                              index]
                                                          .photo!);
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromRGBO(
                                                    255, 241, 207, 1)),
                                            child: const Text(
                                              'VIEW',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    199, 155, 36, 1),
                                                fontFamily: 'Roboto',
                                                fontSize: 8,
                                              ),
                                            ),
                                          ),
                                        )
                                ]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return divider1();
                        },
                        itemCount: controller.monthattendenceList.length)))
          ],
        ));
  }

  SizedBox header(BuildContext context, String label) {
    return SizedBox(
        child: Text(
      label,
      style: const TextStyle(color: redColor),
    ));
  }

  SizedBox footer(BuildContext context, String label) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .20,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ));
  }

  SizedBox redfooter(BuildContext context, String label) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * .20,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, color: redColor),
        ));
  }
}
