
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ShopCard extends StatelessWidget {
  final String shopname;
  final String location;
  final String? number;
  final bool? visible;
  final String? date;
  // final bool? visibles;
  final String? time;
  final String? timer;
  final Function? onClick;
  final Function gpsonClick;
  final Function geoTagClick;
  final Function callonClick;
  final bool gps;
  const ShopCard({
    super.key,
    required this.shopname,
    required this.location,
    this.number,
    this.visible = false,
    this.time,
    this.timer,
    this.onClick,
    required this.gpsonClick,
    required this.callonClick,
    required this.gps,
    required this.geoTagClick,
    this.date,
    // this.visibles = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
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
        child: InkWell(
          onTap: () {
            onClick!();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  blackText(shopname, 16, fontWeight: FontWeight.w600),
                  const Spacer(),
                  Visibility(
                    visible: visible!,
                    child: RichText(
                      text: TextSpan(children: [
                        const WidgetSpan(
                          child: Icon(
                            Icons.calendar_today_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const WidgetSpan(
                          child: SizedBox(width: 5),
                        ),
                        TextSpan(
                            text: date,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                      ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  svgWidget('assets/svg/location.svg', size: 15),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: greyText(
                      location,
                      12,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  svgWidget('assets/svg/Call.svg', size: 15),
                  const SizedBox(
                    width: 5,
                  ),
                  greyText(number.toString(), 12),
                  const Spacer(),
                  gps == false
                      ? Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xffE1F8FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              gpsonClick();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                svgWidget('assets/svg/pin_drop.svg',
                                    color: const Color(0xff4F9AB5),
                                    blendMode: BlendMode.srcIn),
                                const Text(
                                  'MAP',
                                  style: TextStyle(color: Color(0xff4F9AB5)),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(
                          height: 30,
                          width: 65,
                          decoration: BoxDecoration(
                            color: const Color(0xffE1F8FF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              geoTagClick();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Geo Tag',
                                  style: TextStyle(color: Color(0xff4F9AB5)),
                                )
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        callonClick();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          svgWidget('assets/svg/Call.svg',
                              size: 17,
                              color: const Color(0xffffffff),
                              blendMode: BlendMode.srcIn),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 12, top: 15, bottom: 15, right: 12),
        ),
      ),
    );
  }
}
