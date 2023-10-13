import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_visit_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/date_picker/attendance_date_picker.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/my_visit_popup.dart';
import 'package:kvn_farm_rich/app/modules/my_team/views/my_team_assign_shop.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../controllers/myvisit_controller.dart';

class MyvisitView extends GetView<MyvisitController> {
  const MyvisitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(label: 'My Visit'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.argumet != "")
              EmployeeDetails(
                name: controller.argumet.name.toString(),
                number: controller.argumet.mobile.toString(),
                desig: controller.argumet.designationName,
              ),
            Obx(() => AttendanceDatePicker(
                  date: controller.date.value,
                  changeDate: () {
                    controller.changeDate(context);
                  },
                  decrement: () {
                    controller.decrementDay();
                  },
                  increment: () {
                    controller.incrementDay();
                  },
                )),
            const Divider(
              thickness: 5,
              color: visitDividerColor,
            ),
            Obx(
              () => controller.isLoading.value
                  // ignore: prefer_const_constructors
                  ? Center(child: const CircularProgressIndicator())
                  : controller.myVisisitList.isEmpty
                      ? const NoDataWidget()
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 15, right: 15, bottom: 8),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.myVisisitList.length,
                              itemBuilder: (context, index) {
                                final visit = controller.myVisisitList[index];
                                final km = double.parse(visit.kmDiff.toString())
                                    .toStringAsFixed(2);
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: VisitCardWidget(
                                    visible: controller.myVisisitList[index]
                                                .visitType ==
                                            'Live'
                                        ? false
                                        : true,
                                    name: visit.lead.toString(),
                                    location: visit.visitLoc.toString(),
                                    place: visit.place.toString(),
                                    km: km,
                                    onTapGps: () async {
                                      await MapsLauncher.launchCoordinates(
                                          double.parse(visit.lat.toString()),
                                          double.parse(visit.longi.toString()));
                                    },
                                    gps: " MAP",
                                    checkInTime: dateFormat(visit.date),
                                    checkOutTime: dateTimeFormat(
                                        visit.checkoutDate.toString()),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => MyVisitPopup(
                                                type: visit.type,
                                                remark: visit.remark.toString(),
                                                location: visit.place!,
                                              ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ],
        ));
  }
}

Container visitDivider() {
  return Container(
    height: 1.5,
    color: const Color(0xFFE2E2E2),
    width: double.infinity,
  );
}
