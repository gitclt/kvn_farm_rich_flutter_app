import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/delete_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/cart/views/card_iteam.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
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
              Obx(() => controller.shopname.value != ""
                  ? ShopName(
                      name: controller.shopname.value,
                      ontap: () async {
                        controller.leadList.clear();
                        controller.searchcontroller.clear();
                        await controller.getShops();
                      },
                    )
                  : const SizedBox(
                      height: 0,
                    )),
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
                                            text:
                                                controller.cartlist[index].qty);
                                    await showDialog(
                                      context: context,
                                      builder: (_) => ProductPopup(
                                        image:
                                            controller.cartlist[index].image1,
                                        name: controller.cartlist[index].name,
                                        code: controller.cartlist[index].code
                                            .toString(),
                                        qtycontroller: controller.qtycontroller,
                                        isloading: controller.isloading.value,
                                        ontap: () async {
                                          await controller.addqty(index);
                                          await controller.saveData();

                                          Get.back();
                                        },
                                        mrp: controller.cartlist[index].mrp
                                            .toString(),
                                      ),
                                    );
                                  },
                                  child: CartItemCard(
                                      image: controller.cartlist[index].image1,
                                      name: controller.cartlist[index].name,
                                      code: controller.cartlist[index].code
                                          .toString(),
                                      qty: controller.cartlist[index].qty,
                                      ontap: () async {
                                        deletePopup(() async {
                                          controller.cartlist.remove(
                                              controller.cartlist[index]);
                                          await controller.saveData();
                                        }, () {
                                          Get.back();
                                        });
                                      },
                                      mrp: controller.cartlist[index].mrp
                                          .toString()),
                                );
                              },
                              separatorBuilder: (c, i) {
                                return divider1();
                              }),
                        )),
              Obx(() => controller.isloading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.cartlist.isEmpty
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            blackText("TOTAL QUANTITY", 16,
                                fontWeight: FontWeight.w500),
                            Text(
                              controller.cartlist
                                  .map((e) {
                                    final total =
                                        (double.parse(e.qty.toString()));
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
        bottomNavigationBar: Obx(
          () => controller.isloading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.cartlist.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 15, right: 15),
                      child: CommonButtonWidget(
                        label: "CHECKOUT",
                        onClick: () {
                          if (controller.shopid.value == "") {
                            controller.getShops();
                          } else {
                            controller.getOrderNumber();
                          }
                        },
                      ),
                    ),
        ));
  }
}

class ShopName extends StatelessWidget {
  final String name;
  final Function ontap;
  const ShopName({super.key, required this.name, g, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            blackText(name, 16, fontWeight: FontWeight.w500),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
        InkWell(
          onTap: () {
            ontap();
          },
          child: Container(
            decoration: BoxDecoration(
              color: red2Color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: greyText('CHANGE', 14,
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ).paddingAll(10);
  }
}
