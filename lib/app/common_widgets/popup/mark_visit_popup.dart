import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/myroute/controllers/myroute_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class MarkVisitPopup extends StatefulWidget {
  final String location;
  final Function onClick;

  const MarkVisitPopup({
    Key? key,
    required this.location,
    required this.onClick,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddSalePopupState();
}

class AddSalePopupState extends State<MarkVisitPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;
  final MyrouteController routeController = Get.find();

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
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.1,
                          left: size.width * 0.04,
                          right: size.width * 0.04,
                          bottom: size.height * 0.18),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0))),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: routeController.formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      blackText("Mark Visit", 18,
                                          fontWeight: FontWeight.w600),
                                      InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: const Icon(Icons.close)
                                              .paddingOnly(
                                                  left: size.width * 0.21))
                                    ],
                                  ).paddingOnly(bottom: 25, left: 5, top: 10),
                                  blackText('Select Type', 16,
                                          fontWeight: FontWeight.w500)
                                      .paddingOnly(left: 5, bottom: 5),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F3F3),
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: DropdownButtonFormField(
                                        icon: const Icon(
                                          Icons.expand_more_outlined,
                                          size: 25,
                                          color: redColor,
                                        ),
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(
                                                borderSide: BorderSide.none)),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select an option';
                                          }
                                          return null;
                                        },
                                        items: routeController.markTypes
                                            .map((label) => DropdownMenuItem(
                                                  value: label.name,
                                                  child: Text(label.name),
                                                ))
                                            .toList(),
                                        hint: const Text(
                                          'Select Type',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        onChanged: (value) {
                                          routeController.itemController.text =
                                              value.toString();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      blackText('Remarks', 16,
                                          fontWeight: FontWeight.w500),
                                    ],
                                  ).paddingOnly(left: 5, bottom: 5),
                                  SizedBox(
                                    height: 100,
                                    child: TextFormField(
                                      maxLines: null,
                                      expands: true,
                                      autofocus: false,
                                      controller:
                                          routeController.remarkController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter remark';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xFFF3F3F3),
                                        filled: true,
                                        hintText: "Enter remark",
                                        hintStyle: const TextStyle(
                                          color: Color(0xff7b7b7b),
                                          fontSize: 16,
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w500,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFFFFFFFF)),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFFFFFFFF)),
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ).paddingOnly(left: 3, right: 3),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     containerBox(
                                  //       Row(
                                  //         children: [
                                  //           Obx(
                                  //             () => Checkbox(
                                  //               visualDensity:
                                  //                   VisualDensity.compact,
                                  //               activeColor: Colors.red,
                                  //               value: routeController
                                  //                   .planChecked.value,
                                  //               onChanged: (newValue) {
                                  //                 routeController.planChecked
                                  //                     .value = newValue!;
                                  //               },
                                  //             ),
                                  //           ),
                                  //           blackText('Plan Tour', 16)
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     containerBox(
                                  //       Row(
                                  //         children: [
                                  //           Obx(
                                  //             () => Checkbox(
                                  //               visualDensity:
                                  //                   VisualDensity.compact,
                                  //               activeColor: Colors.red,
                                  //               value: routeController
                                  //                   .creditChecked.value,
                                  //               onChanged: (newValue) {
                                  //                 routeController.creditChecked
                                  //                     .value = newValue!;
                                  //               },
                                  //             ),
                                  //           ),
                                  //           blackText('Credit Visit', 16)
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ).paddingOnly(left: 3, right: 3),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      svgWidget('assets/svg/location.svg',
                                          color: redColor,
                                          blendMode: BlendMode.srcIn),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      blackText(
                                        fontWeight: FontWeight.w400,
                                        widget.location,
                                        12,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(
                                    () => CommonButtonWidget(
                                      label: "MARK VISIT",
                                      isLoading:
                                          routeController.isVisitLoading.value,
                                      onClick: () {
                                        widget.onClick();
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }

  Widget containerBox(widget) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6, right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: boxGreyColor, width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: widget,
    );
  }
}
