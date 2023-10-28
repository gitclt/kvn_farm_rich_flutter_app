import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class OrderHistoryCardWidget extends StatelessWidget {
  final Function onClick;
  final VoidCallback deleteonClick;
  final bool? visible;
  final String location, qnty, ordernmbr,date;
  const OrderHistoryCardWidget(
      {super.key,
      required this.onClick,
      required this.location,
      required this.qnty,
      required this.ordernmbr,
      required this.deleteonClick,
      this.visible, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                greyText('Item Quantity : $qnty', 12),
                Row(
                  children: [
                    svgWidget('assets/svg/calendar.svg'),
                    const SizedBox(
                      width: 2,
                    ),
                    greyText(date, 12)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackText(ordernmbr, 16, fontWeight: FontWeight.w600),
                Visibility(
                  visible: visible!,
                  child: InkWell(
                    onTap: () {
                      deleteonClick();
                    },
                    child: svgWidget("assets/svg/delete.svg",
                        size: 25, color: red2Color),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ]),
        ),
      ).paddingAll(5),
    );
  }
}
