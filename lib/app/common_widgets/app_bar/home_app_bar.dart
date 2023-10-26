import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/dashboard_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class HomeAppBar extends GetView<DashboardController>
    implements PreferredSizeWidget {
  final Function onClick;
  final String label;

  const HomeAppBar({super.key, required this.onClick, required this.label});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: primaryColor),
      ),
      leading: InkWell(
        onTap: () {
          onClick();
        },
        child: svgWidget('assets/svg/menu.svg'),
      ),
      centerTitle: true,
      title: Text(
        label,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20),
      ),
      actions: const [
        // IconButton(
        //     onPressed: () {
        //       Get.toNamed(Routes.CART);
        //     },
        //     icon: svgWidget('assets/svg/shop_cart.svg')),
        //  IconButton(onPressed: () {}, icon: svgWidget('assets/svg/search.svg'))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
