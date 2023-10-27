import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/modules/cart/controllers/cart_controller.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';

import '../../../constraints/app_colors.dart';
import '../svg_icons/svg_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String label;
  final bool? visibility;
  const CommonAppBar({super.key, required this.label, this.visibility = true});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return AppBar(
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: primaryColor),
      ),
      centerTitle: false,
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: svgWidget('assets/svg/back_arrow.svg')),
      title: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      actions: [
        Visibility(
          visible: visibility!,
          child: IconButton(
            onPressed: () {
              Get.toNamed(Routes.CART);
            },
            icon: Stack(clipBehavior: Clip.none, children: [
              svgWidget('assets/svg/shop_cart.svg', color: Colors.white),
              Obx(() => (cartController.cartlist.isNotEmpty)
                  ? Positioned(
                      bottom: 8,
                      left: 11,
                      child: circleWidgetWithText(
                        20,
                        Colors.white,
                        cartController.cartlist.length.toString(),
                        red2Color,
                      ),
                    )
                  : const SizedBox())
            ]),
          ),
          //  IconButton(onPressed: () {}, icon: svgWidget('assets/svg/search.svg')),
        ).paddingOnly(right: 10)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
