
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class DrawerHeaderCard extends StatelessWidget {
  final String name;
  const DrawerHeaderCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFF8F8F8),
            border: Border.all(color: const Color(0xFFF8F8F8), width: 1)),
        child: Row(children: [
          svgWidget('assets/svg/profile_circle.svg'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText('Hi,', 12, fontWeight: FontWeight.w500),
              blackText(name, 12, fontWeight: FontWeight.w700),
              const SizedBox(
                height: 5,
              ),
              greyText('C-KL-000001', 12)
            ],
          ).paddingOnly(left: 7)
        ]).paddingSymmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
