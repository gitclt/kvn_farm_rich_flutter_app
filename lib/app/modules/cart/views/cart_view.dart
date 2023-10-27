import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/delete_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/card_iteam.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        label: "Cart",
        visibility: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Obx(() => controller.isloading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.cartlist.isEmpty
                    ? const NoDataWidget()
                    : Expanded(
                        child: ListView.separated(
                            itemCount: controller.cartlist.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  controller.qtycontroller =
                                      TextEditingController(
                                          text: controller.cartlist[index].qty);
                                  await showDialog(
                                    context: context,
                                    builder: (_) => ProductPopup(
                                      image: controller.cartlist[index].image1,
                                      name: controller.cartlist[index].name,
                                      code: controller.cartlist[index].mrp
                                          .toString(),
                                      qtycontroller: controller.qtycontroller,
                                      isloading: controller.isloading.value,
                                      ontap: () async {
                                        await controller.addqty(index);
                                        await controller.saveData();

                                        Get.back();
                                      },
                                    ),
                                  );
                                },
                                child: CartItemCard(
                                  image: controller.cartlist[index].image1,
                                  name: controller.cartlist[index].name,
                                  code:
                                      controller.cartlist[index].mrp.toString(),
                                  qty: controller.cartlist[index].qty,
                                  ontap: () async {
                                    deletePopup(() async {
                                      controller.cartlist
                                          .remove(controller.cartlist[index]);
                                      await controller.saveData();
                                    }, () {
                                      Get.back();
                                    });
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (c, i) {
                              return divider1();
                            }),
                      )),
            controller.cartlist.isEmpty
                ? const SizedBox()
                : Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        blackText("TOTAL QUANTITY", 16,
                            fontWeight: FontWeight.w500),
                        Text(
                          controller.cartlist
                              .map((e) {
                                final total = (double.parse(e.qty.toString()));
                                return total;
                              })
                              .toList()
                              .reduce((value, element) => value + element)
                              .toStringAsFixed(0),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: Color(0xFFD80005),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ))
          ],
        ),
      ),
      bottomNavigationBar: controller.cartlist.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
              child: CommonButtonWidget(
                label: "CHECKOUT",
                onClick: () {
                  controller.checkOut();
                },
              ),
            ),
    );
  }
}
