import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/textfield_with_baorder.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/my_order_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class OrderShopBottomsheet extends GetView<MyOrderController> {
  final Function ontap;

  const OrderShopBottomsheet({
    super.key,
    required this.ontap,
  });

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
              const Text(
                "Shops",
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ).paddingOnly(left: 120),
            ],
          ).paddingOnly(left: 15),
        ),
        const SizedBox(
          height: 4,
        ),
        BoarderTextField(
          hintText: "Search Shop....",
          textEditingController: controller.searchcontroller,
          onChanged: (String value) async {
            await controller.shopSearch();
          },
        ).paddingAll(10),
        Obx(
          () => Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.leadList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    controller.shopname.value = controller.leadList[index].name;
                    controller.shopid.value =
                        controller.leadList[index].id.toString();

                    Get.back();
                    if (controller.shopid.value != "") {
                      controller.leadoptioncontroller = TextEditingController(
                          text: controller.shopname.value);
                      await controller.getMyOrder();
                    }
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        blackText(controller.leadList[index].name, 15,
                                fontWeight: FontWeight.w500)
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
                            greyText(controller.leadList[index].address, 12,
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
                );
              },
            ),
          ),
        )
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
