import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ExpiryHomeCard extends StatelessWidget {
  final String shopname;
  final String location;
  final Function ontap;
  final bool visible;

  const ExpiryHomeCard(
      {super.key,
      required this.shopname,
      required this.location,
      required this.ontap,
      required this.visible});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText(shopname, 16, fontWeight: FontWeight.bold)
                  .paddingOnly(left: 2),
              const SizedBox(
                height: 10,
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
            ],
          ),
          Visibility(
            visible: visible,
            child: const Icon(
              Icons.arrow_forward_ios,
              color: redColor,
              size: 14,
            ),
          ).paddingOnly(right: 10),
        ],
      ).paddingOnly(top: 8, left: 12),
    );
  }
}
