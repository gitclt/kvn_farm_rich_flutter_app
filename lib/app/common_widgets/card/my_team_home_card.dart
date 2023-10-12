import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class MyTeamHomeCard extends StatelessWidget {
  final String name;
  final String number;
  final String desig;
  final Function ontap;
  const MyTeamHomeCard(
      {super.key,
      required this.name,
      required this.number,
      required this.desig,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        
        decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 240, 235, 235),
                  blurRadius: 3.0,
                  spreadRadius: 3),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackText(name, 14, fontWeight: FontWeight.w500)
                    .paddingOnly(left: 0),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    svgWidget('assets/svg/Call.svg', size: 15),
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
            greyText(desig, 12, fontWeight: FontWeight.w400)
          ],
        ).paddingAll(10),
      ).paddingOnly(left: 15, top: 12, right: 15),
    );
  }
}
