import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/home_card/home_item_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/models/get_shops_model.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:kvn_farm_rich/constraints/phone_call_utils.dart';

class ShopBottomsheet extends StatelessWidget {
  final GetLeadDetails allLeads;
  final VoidCallback? editShopClick;
  const ShopBottomsheet(
      {super.key,
      // required this.tittle,
      // required this.location,
      // required this.leadId,
      required this.allLeads,
       this.editShopClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.width * 2,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: blackText(allLeads.name, 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: greyText(allLeads.place.toString(), 14,
                              fontWeight: FontWeight.w400,
                              textOverflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ).paddingOnly(left: 10),
              const SizedBox(
                height: 14,
              ),
              divider(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    HomeCardItem(
                      path: "assets/svg/home_profile.svg",
                      label: "Profile",
                      ontap: () {
                        Get.back();
                        Get.toNamed(Routes.SHOP_PROFILE,
                            arguments: allLeads.id.toString());
                      },
                    ),
                    // HomeCardItem(
                    //   path: "assets/svg/add_products.svg",
                    //   label: "Add Products",
                    //   ontap: () {
                    //     Get.back();
                    //     Get.toNamed(Routes.VIEW_PRODUCT,
                    //         arguments: allLeads.id.toString());
                    //   },
                    // ),
                    HomeCardItem(
                      path: "assets/svg/shop_edit.svg",
                      label: "Edit",
                      ontap: 
                        editShopClick,
                      
                    ),
                    // HomeCardItem(
                    //   path: "assets/svg/covert_tocustumer.svg",
                    //   label: "Convert to \nCustomer",
                    //   ontap: () {
                    //     showDialog(
                    //         // barrierDismissible: true,
                    //         context: context,
                    //         builder: (_) => ConvertCoustomerPopup(
                    //             name: allLeads.name,
                    //             loc: allLeads.place,
                    //             flag: allLeads.flag,
                    //             id: allLeads.id.toString()));
                    //   },
                    // ),
                    // HomeCardItem(
                    //   path: "assets/svg/activity.svg",
                    //   label: "Activity",
                    //   ontap: () {
                    //     Get.toNamed(Routes.ACTIVITY,
                    //         arguments: allLeads.id.toString());
                    //   },
                    // ),
                    // HomeCardItem(
                    //   path: "assets/svg/orders.svg",
                    //   label: "Orders",
                    //   ontap: () {
                    //     Get.toNamed(Routes.ORDERS,
                    //         arguments: allLeads.id.toString());
                    //   },
                    // ),
                  ],
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     HomeCardItem(
              //       path: "assets/svg/home_profile.svg",
              //       label: "Profile",
              //       ontap: () {
              //         Get.toNamed(Routes.SHOP_PROFILE);
              //       },
              //     ),
              //     HomeCardItem(
              //       path: "assets/svg/add_products.svg",
              //       label: "Add Products",
              //       ontap: () {
              //         Get.toNamed(Routes.PRODUCT, arguments: true);
              //       },
              //     ),
              //     HomeCardItem(
              //       path: "assets/svg/shop_edit.svg",
              //       label: "Edit",
              //       ontap: () {
              //         Get.toNamed(Routes.SHOP_EDIT);
              //       },
              //     ),
              //     HomeCardItem(
              //       path: "assets/svg/covert_tocustumer.svg",
              //       label: "Convert to \nCustomer",
              //       ontap: () {
              //         showDialog(
              //             // barrierDismissible: true,
              //             context: context,
              //             builder: (_) => const ConvertCoustomerPopup(
              //                   name: "PRINCE AGENCIES",
              //                   loc: 'Palayam, Kozhikode',
              //                 ));
              //       },
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     HomeCardItem(
              //       path: "assets/svg/activity.svg",
              //       label: "Activity",
              //       ontap: () {
              //         Get.toNamed(Routes.ACTIVITY);
              //       },
              //     )
              //   ],
              // ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  PhoneCallUtils.callPhoneNumber(allLeads.mobile.toString());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0xff6dfa56), Color(0xff31cd40)],
                        ),
                      ),
                      child: svgWidget('assets/svg/Call.svg',
                          size: 15,
                          color: Colors.white,
                          blendMode: BlendMode.srcIn),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
