import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/home_controller.dart';
import 'package:kvn_farm_rich/app/pref/session.dart';

class EmpCheckInCard extends GetView<HomeController> {
  const EmpCheckInCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greyText('Hi, ${Session.userName}', 14),
                const SizedBox(
                  height: 10,
                ),
                blackText('Welcome', 20, fontWeight: FontWeight.w700),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: CommonButtonWidget(
                    label: 'LOGIN',
                    borderRadius: 15,
                    fontSize: 12,
                    onClick: () {
                      controller.getLocation(context);
                    },
                  ),
                )
              ],
            ),
            svgWidget('assets/svg/profile_circle.svg')
          ],
        ),
      ),
    );
  }
}
