
import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class OrderHistoryCardWidget extends StatelessWidget {
  final Function onClick;
  final String location, qnty, ordernmbr;
  const OrderHistoryCardWidget(
      {super.key,
      required this.onClick,
      required this.location,
      required this.qnty,
      required this.ordernmbr});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
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
                    greyText('May 27, 2023', 12)
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            blackText(ordernmbr, 16, fontWeight: FontWeight.w600),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                svgWidget('assets/svg/location.svg'),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: greyText(location, 12,
                      textOverflow: TextOverflow.ellipsis),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
