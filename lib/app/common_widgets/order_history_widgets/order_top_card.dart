import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/status_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class OrderTopWidget extends StatelessWidget {
  final String no;
  final String orderNo;
  final String date;
  final String type;
  final String name;
  const OrderTopWidget(
      {super.key,
      required this.no,
      required this.orderNo,
      required this.type,
      required this.date,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            greyText("Item Quantity  : $no", 12),
            const SizedBox(
              height: 6,
            ),
            blackText("#$orderNo", 16, fontWeight: FontWeight.w600),
            const SizedBox(
              height: 8,
            ),
            greyText(name, 16,
                fontWeight: FontWeight.w400, color: const Color(0xff8C8C8C)),
            const SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: mapColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    blackText('Ordered', 12, fontWeight: FontWeight.w400),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.03),
                  child: greyText(date, 12),
                )
              ],
            ),
          ],
        ).paddingSymmetric(vertical: 8),
        Column(
          children: [
            blackText('Order Status :', 12),
            const SizedBox(
              height: 8,
            ),
            orderButtonFunction(type),
          ],
        )
      ],
    );
  }
}
