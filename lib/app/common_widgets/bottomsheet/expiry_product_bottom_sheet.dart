
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/textfield_with_baorder.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ExpiryProductBottomSheet extends StatelessWidget {
  final String shopname;
  final String label;
  final String location;
  final int length;
  final Function ontap;

  const ExpiryProductBottomSheet(
      {super.key,
      required this.shopname,
      required this.location,
      required this.ontap,
      required this.length, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          decoration: const BoxDecoration(
              gradient: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: svgWidget('assets/svg/back_arrow.svg')),
               Text(
                label,
                style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ).paddingOnly(left: 80),
            ],
          ).paddingOnly(left: 15),
        ),
        const SizedBox(
          height: 4,
        ),
        BoarderTextField(
          hintText: "Search Shop....",
          onChanged: (String value) {},
        ).paddingAll(10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: FlipAnimation(
                    duration: const Duration(milliseconds: 800),
                    child: InkWell(
                      onTap: () {
                        ontap();
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            blackText(shopname, 15, fontWeight: FontWeight.w500)
                                .paddingOnly(left: 2),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                svgWidget('assets/svg/location.svg'),
                                const SizedBox(
                                  width: 5,
                                ),
                                greyText(location, 12,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Color(0xffE2E2E2),
                              thickness: 1.5,
                            ),
                          ],
                        ).paddingAll(5),
                      ).paddingOnly(left: 15, top: 5, right: 15),
                    ),
                  ));
            },
          ),
        ),
      ],
    );
  }
}

RoundedRectangleBorder bootomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
  );
}
