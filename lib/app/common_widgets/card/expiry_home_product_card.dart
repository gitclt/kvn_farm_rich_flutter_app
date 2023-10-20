import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ExpiryHomeProductCard extends StatelessWidget {
  final String shopname;
  final String location;
  final Function ontap;
  final String image;
  final bool visible;

  const ExpiryHomeProductCard(
      {super.key,
      required this.shopname,
      required this.location,
      required this.ontap,
      required this.visible,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 65,
            width: 50,
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greyText(shopname, 12, fontWeight: FontWeight.w400),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  blackText(location, 14, fontWeight: FontWeight.w600),
                ],
              ),
            ],
          ),
          const Spacer(),
          Visibility(
            visible: visible,
            child: const Icon(
              Icons.arrow_forward_ios,
              color: redColor,
              size: 15,
            ),
          ).paddingOnly(right: 25),
        ],
      ).paddingOnly(left: 15, top: 5),
    );
  }
}
