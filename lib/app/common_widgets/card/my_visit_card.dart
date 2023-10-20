import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class VisitCardWidget extends StatelessWidget {
  final String name;
  final Function onTap;
  final String location;
  final String place;
  final String km;
  final String checkInTime;
  final String checkOutTime;
  final bool? visible;
  final Function onTapGps;
  final String gps;
  const VisitCardWidget(
      {super.key,
      required this.name,
      required this.location,
      required this.km,
      required this.checkInTime,
      required this.checkOutTime,
      this.visible,
      required this.onTap,
      required this.onTapGps,
      required this.gps,
      required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(2),

      decoration: BoxDecoration(
          color: scaffoldBgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ]),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: visible!,
              child: Container(
                height: 25,
                //  padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xffFEA500),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 14,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    blackText('You’re check in from $location,', 10,
                        fontWeight: FontWeight.w400),
                    blackText(
                      ' $km KM ',
                      10,
                      fontWeight: FontWeight.w700,
                    ),
                    blackText(' Distance', 10)
                  ],
                ).paddingOnly(left: 8),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText(name, 15,
                      fontWeight: FontWeight.w600,
                      textOverflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      svgWidget('assets/svg/location.svg',
                          color: const Color(0xFF6C6C6C), size: 15),
                      const SizedBox(
                        width: 2,
                      ),
                      Expanded(
                          child: greyText(place, 12,
                              textOverflow: TextOverflow.ellipsis)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          onTapGps();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffE1F8FF),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  width: 2,
                                ),
                                svgWidget('assets/svg/pin_drop.svg',
                                    color: const Color(0xff4F9AB5),
                                    blendMode: BlendMode.srcIn),
                                Text(
                                  gps,
                                  style:
                                      const TextStyle(color: Color(0xff4F9AB5)),
                                ),
                                const SizedBox(
                                  width: 2,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: 'Checkin ',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: greyTextColor)),
                          TextSpan(
                              text: checkInTime,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: greyTextColor)),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: 'Checkout ',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: greyTextColor)),
                          TextSpan(
                              text: checkOutTime,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: greyTextColor)),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container verticalDivider() {
  return Container(
      decoration: const BoxDecoration(
          border:
              Border(right: BorderSide(color: Color(0xFFE2E2E2), width: 1.5))));
}

SizedBox header(BuildContext context, String label, {double? width}) {
  return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * .10,
      child: Text(
        label,
        textAlign: TextAlign.center,
      ));
}
