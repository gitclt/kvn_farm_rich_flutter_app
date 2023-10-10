import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/home_controller.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class EmpCheckOutCard extends GetView<HomeController> {
  const EmpCheckOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadingAttendance.value
          ? const Center(child: CircularProgressIndicator())
          : Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Date : ${dateToFormattedDate(controller.attendance.checkindate!)}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Time : ${dateToFormattedTime(controller.attendance.checkindate!)}",
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (controller.attendance.workhour != '')
                            Text(
                              " Working Hr: ${controller.attendance.workhour}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.045,
                            child: CommonButtonWidget(
                              label: "Log out",
                              borderRadius: 15,
                              onClick: () {
                                if (controller.attendance.workhour != '') {
                                  Get.snackbar("", "Already Logout");
                                } else {
                                  controller.marklogout();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  controller.attendance.photo!,
                                ),
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey.shade400,
                                size: 15,
                              ),
                              Text(
                                controller.attendance.checkinLoc!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
