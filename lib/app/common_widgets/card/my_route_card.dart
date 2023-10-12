
import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/status_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class MyRouteCard extends StatelessWidget {
  final String shopname;
  final String location;
  final String gps;
  final String number;
  final String status;
  final String visitStatus;
  final Function onTapGps;
  final Function onTapCall;
  const MyRouteCard({
    super.key,
    required this.shopname,
    required this.location,
    required this.number,
    required this.status,
    required this.visitStatus,
    required this.onTapGps,
    required this.onTapCall,
    required this.gps,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          blackText(shopname, 16, fontWeight: FontWeight.w500),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              svgWidget('assets/svg/location.svg'),
              const SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  greyText(location, 12),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  svgWidget('assets/svg/Call.svg', size: 15),
                  const SizedBox(
                    width: 5,
                  ),
                  greyText(number, 12),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    onTapGps();
                  },
                  child: Container(
                    height: 30,
                    // width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffE1F8FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                          style: const TextStyle(color: Color(0xff4F9AB5)),
                        ),
                        const SizedBox(
                          width: 2,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                    gradient: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      onTapCall();
                    },
                    icon: svgWidget('assets/svg/Call.svg',
                        color: const Color(0xffffffff),
                        blendMode: BlendMode.srcIn),
                  ),
                )
              ],
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  gradient: primaryColor,
                  shape: BoxShape.circle,
                )),
            SizedBox(
              width: size.width * 0.005,
            ),
            blackText(status, 12, fontWeight: FontWeight.w500),
            SizedBox(
              width: size.width * 0.0185,
            ),
            const Spacer(),
            orderButtonFunction(visitStatus)
          ]),
        ]));
  }
}
