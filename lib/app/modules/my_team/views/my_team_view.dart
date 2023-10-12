import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_team_home_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/report_choose_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/textfield_with_baorder.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';


import '../controllers/my_team_controller.dart';

class MyTeamView extends GetView<MyTeamController> {
  const MyTeamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: const CommonAppBar(label: "My Team"),
      body: Center(
        child: Column(
          children: [
            BoarderTextField(
              hintText: "Search Employee....",
              focusNode: focusNode,
              onChanged: (String value) {
                focusNode.requestFocus();
                controller.search(value);
              },
            ).paddingAll(10),
            Obx(
              () => controller.isLoading.value
                  // ignore: prefer_const_constructors
                  ? Center(child: const CircularProgressIndicator())
                  : controller.teamlist.isEmpty
                      ? const NoDataWidget()
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.teamlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                final teamiteam = controller.teamlist[index];
                                return InkWell(
                                  onTap: () {
                                    // Get.toNamed(
                                    //     Routes.MY_TEAM_ASSIGN_SHOP);
                                  },
                                  child: MyTeamHomeCard(
                                    name: teamiteam.name.toString(),
                                    number: teamiteam.mobile.toString(),
                                    desig: teamiteam.designationName,
                                    ontap: () {
                                      selectreport(
                                          context,
                                          () {
                                            Get.toNamed(
                                                Routes.ATTENDANCE_REPORT,
                                                arguments: teamiteam);
                                          },
                                          () {
                                            Get.toNamed(Routes.MYVISIT,
                                                arguments: teamiteam);
                                          },
                                          () {
                                            Get.toNamed(Routes.MYROUTE,
                                                arguments: teamiteam);
                                          },
                                          // () {
                                          //   Get.toNamed(Routes.NEWEST_LEAD,
                                          //       arguments: teamiteam);
                                          // },
                                          Session.roleId == "4"
                                              ? true
                                              : Session.roleId == "3"
                                                  ? true
                                                  : false,
                                          () {
                                            Get.toNamed(Routes.ASSIGNEDROUTE,
                                                arguments: teamiteam);
                                          });
                                    },
                                  ),
                                );
                              }),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
