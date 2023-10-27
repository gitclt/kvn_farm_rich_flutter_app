import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class ProductCard extends StatefulWidget {
  final String iteam;
  final String image;
  final int? itemId;
  final bool? visibles;
  final Function onTap;
  final String code;
  final String mrp;
  final Function? act;

  const ProductCard({
    Key? key,
    required this.iteam,
    required this.mrp,
    required this.image,
    required this.onTap,
    required this.code,
    this.act,
    required this.itemId,
    this.visibles,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final MasalaController productController = Get.find();
    final isCartItem = cartController.cartlist
        .indexWhere((element) => element.id == widget.itemId);
    return InkWell(
        child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(children: [
        Expanded(
          child: Center(
            child: Image.network(
              widget.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            blackText(widget.iteam, 16, fontWeight: FontWeight.w600)
                .paddingOnly(top: 5),
            Row(
              children: [
                greyText("Mrp :", 14).paddingOnly(top: 5),
                greyText(widget.mrp, 14).paddingOnly(top: 5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                greyText(widget.code, 14),
                const Spacer(),
                if (isCartItem >= 0)
                  InkWell(
                    onTap: () {
                      setState(() {
                        productController.qtycontroller = TextEditingController(
                            text: cartController.cartlist[isCartItem].qty);

                        widget.onTap();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 10,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                productController.qtycontroller =
                                    TextEditingController(
                                        text: cartController
                                            .cartlist[isCartItem].qty);

                                widget.onTap();
                              });
                            },
                            child: svgWidget('assets/svg/cart.svg',
                                color: Colors.black, size: 20),
                          ),
                          Obx(() => (cartController.cartlist.isNotEmpty)
                              ? Positioned(
                                  bottom: 8,
                                  left: 5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        productController.qtycontroller =
                                            TextEditingController(
                                                text: cartController
                                                    .cartlist[isCartItem].qty);

                                        widget.onTap();
                                      });
                                    },
                                    child: circleWidgetWithText(
                                      20,
                                      red2Color,
                                      cartController.cartlist[isCartItem].qty
                                          .toString(),
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const SizedBox()),
                        ],
                      ),
                    ).paddingOnly(top: 5),
                  ),
                if (isCartItem < 0)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 10,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            productController.qtycontroller.clear();
                            widget.onTap();
                          });
                        },
                        child: svgWidget('assets/svg/shop_cart.svg',
                            color: redColor)),
                  ).paddingOnly(top: 5),
              ],
            ).paddingOnly(top: 0),
          ],
        ),
      ]),
    ));
  }
}

Container circleWidgetWithText(
    double size, Color color, String text, Color fontColor) {
  return Container(
    margin: const EdgeInsets.all(5),
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
    child: Center(
        child: Text(
      text,
      style: TextStyle(fontSize: 10, color: fontColor),
    )),
  );
}
