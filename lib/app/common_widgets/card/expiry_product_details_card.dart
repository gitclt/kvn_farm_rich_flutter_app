import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ExpiryProductDetailsCard extends StatelessWidget {
  final String shopname;
  final String location;
  final Function ontap;
  final String qty;
  final bool visible;
  const ExpiryProductDetailsCard(
      {super.key,
      required this.shopname,
      required this.location,
      required this.ontap,
      required this.qty,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 235, 233, 233),
                blurRadius: 3.0,
                spreadRadius: 3),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          blackText(shopname, 15, fontWeight: FontWeight.bold)
              .paddingOnly(left: 0),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              svgWidget('assets/svg/location.svg'),
              const SizedBox(
                width: 5,
              ),
              greyText(location, 12),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: visible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    blackText("Total Qty : ", 12, fontWeight: FontWeight.w600),
                    redText(qty, 12, fontWeight: FontWeight.w600)
                  ],
                ),
                InkWell(
                  onTap: () {
                    ontap();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      redText("Transfer", 12, fontWeight: FontWeight.w600),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: redColor,
                        size: 10,
                      ).paddingAll(3),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ).paddingAll(10),
    ).paddingOnly(left: 15, top: 10, right: 15);
  }
}
