import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/shops/controllers/shop_profile_controller.dart';

class ShopsProfile extends GetView<ShopProfileController> {
  const ShopsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(
          label: 'Profile',
        ),
        body: Obx(
          () => controller.isDetailsLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  decoration: const BoxDecoration(color: Colors.white
                      // color: scaffoldBgColor,
                      ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 10, right: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [svgWidget("assets/svg/edit.svg")],
                          //   ),
                          // ),
                          const SizedBox(
                            height: 40,
                          ),
                          svgWidget("assets/svg/shop_icon.svg"),

                          const SizedBox(
                            height: 5,
                          ),
                          blackText(controller.leadList.first.name, 16,
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            height: 30,
                          ),

                          ShopDetailsWidget(
                            location: controller.leadList.first.place ?? "",
                            mobile: controller.leadList.first.mobile,
                            state: controller.leadList.first.state,
                            address: controller.leadList.first.address,
                            pincode: controller.leadList.first.pincode,
                            cPerson: controller.leadList.first.contactPerson,
                            cNumber: controller.leadList.first.mobile,
                            cGrade: controller.leadList.first.currentGrade,
                          )
                        ],
                      ),
                    ],
                  )),
        ));
  }
}

class ShopDetailsWidget extends StatelessWidget {
  final String location;
  final String mobile;
  final String state;
  final String address;
  final String pincode;
  final String cPerson;
  final String cNumber;
  final String cGrade;
  const ShopDetailsWidget(
      {super.key,
      required this.location,
      required this.mobile,
      required this.state,
      required this.address,
      required this.pincode,
      required this.cPerson,
      required this.cNumber,
      required this.cGrade});

  @override
  Widget build(BuildContext context) {
    var spacer = SizedBox(
      height: MediaQuery.of(context).size.height * .007,
    );
    var hSpace = SizedBox(
      height: MediaQuery.of(context).size.height * .03,
    );
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: double.infinity,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: Colors.white),
      child: AnimationConfiguration.staggeredList(
        position: 0,
        child: SlideAnimation(
          duration: const Duration(milliseconds: 400),
          horizontalOffset: 50.0,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacer,
                    Row(children: [
                      svgWidget('assets/svg/location.svg', size: 16),
                      const SizedBox(
                        width: 5,
                      ),
                      blackText(location, 16, fontWeight: FontWeight.w500)
                    ]),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(children: [
                      svgWidget('assets/svg/Call.svg', size: 16),
                      const SizedBox(
                        width: 5,
                      ),
                      blackText(mobile, 16, fontWeight: FontWeight.w500)
                    ]),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('State', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(state, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('Address', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(address, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('Pincode', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(pincode, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('Contact Person', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(cPerson, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('Contact Number', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(cNumber, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                    hSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyText('Current Grade', 14,
                            color: const Color(0xFF9A9A9A),
                            fontWeight: FontWeight.w500),
                        spacer,
                        blackText(cGrade, 16, fontWeight: FontWeight.w500)
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
