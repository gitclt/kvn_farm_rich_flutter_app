import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';

selectreport(BuildContext context, Function ontap, Function ontap1,
    Function ontap2, bool visible, Function tap3) {
  AlertDialog alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    title: const Padding(
      padding: EdgeInsets.only(left: 70.0, top: 0),
      child: Text("Choose Type"),
    ),
    content: Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          width: 300.0,
          // height: visible == true ? 200 : 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  ontap();
                },
                child: Container(
                    height: 35,
                    color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Attendance Report"),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )
                      ],
                    )),
              ).paddingAll(5),
              divider1(),
              InkWell(
                onTap: () {
                  Get.back();
                  ontap1();
                },
                child: Container(
                    height: 35,
                    color: Colors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Visit Report"),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 18,
                        )
                      ],
                    )),
              ).paddingAll(5),
              visible == true ? divider1() : const SizedBox(),
              visible == true
                  ? InkWell(
                      onTap: () {
                        Get.back();
                        ontap2();
                      },
                      child: Container(
                          height: 35,
                          color: Colors.white,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Assigned Route"),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 18,
                              )
                            ],
                          )),
                    ).paddingAll(5)
                  : const SizedBox(),
              if (Session.roleId == '3') divider1(),
              if (Session.roleId == '3')
                InkWell(
                  onTap: () {
                    Get.back();
                    tap3();
                  },
                  child: Container(
                      height: 35,
                      color: Colors.white,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Assign Route"),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 18,
                          )
                        ],
                      )),
                ).paddingAll(5),
              // if (Session.roleId == '4' || Session.roleId == '5') divider1(),
              // if (Session.roleId == '4' || Session.roleId == '5')
              //   InkWell(
              //     onTap: () {
              //       Get.back();
              //       ontap3();
              //     },
              //     child: Container(
              //         height: 35,
              //         color: Colors.white,
              //         child: const Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text("Newest Leads"),
              //             Icon(
              //               Icons.arrow_forward_ios,
              //               color: Colors.black,
              //               size: 18,
              //             )
              //           ],
              //         )),
              //   ).paddingAll(5)
            ],
          )),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
