import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class MyVisitPopup extends StatefulWidget {
  final String type;
  final String remark;
  final String location;
  final String? tour;
  final String? credit;
  //final bool? visible;
  const MyVisitPopup({
    super.key,
    required this.type,
    required this.remark,
    required this.location,
    this.tour,
    this.credit,
    // this.visible = false
  });

  @override
  State<MyVisitPopup> createState() => _MyVisitPopupState();
}

class _MyVisitPopupState extends State<MyVisitPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Stack(children: [
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.15,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.15),
              child: Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              blackText('Visit Type : ', 16,
                                  fontWeight: FontWeight.w500),
                              greyText(widget.type, 15)
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          blackText('Remarks', 16, fontWeight: FontWeight.w500),
                          const SizedBox(
                            height: 5,
                          ),
                          greyText(widget.remark, 14,
                              textOverflow: TextOverflow.visible),

                          // Visibility(
                          //   visible: widget.visible!,
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 50),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceEvenly,
                          //       // crossAxisAlignment: CrossAxisAlignment.,
                          //       children: [
                          //         blackText(widget.tour!, 16,
                          //             fontWeight: FontWeight.w500),
                          //         // Spacer(),
                          //         blackText(widget.credit!, 16,
                          //             fontWeight: FontWeight.w500)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              svgWidget('assets/svg/location.svg',
                                  color: redColor),
                              const SizedBox(
                                width: 4,
                              ),
                              blackText(widget.location, 12)
                            ],
                          )
                        ]),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
