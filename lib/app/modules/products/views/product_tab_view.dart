import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';

import 'package:kvn_farm_rich/app/modules/products/views/staggered_grid_view.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/masala_controller.dart';

class MasalaView extends GetView<MasalaController> {
  const MasalaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: const CommonAppBar(label: "Products"),
      body: Obx(() {
        if (controller.isClosed) {
          return const Center();
        }

        return DefaultTabController(
          length: controller.subcatList.length,
          initialIndex: 0,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  labelColor: redColor,
                  indicatorColor: redColor,
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black,
                  onTap: (int index) async {
                    String subcat = controller.subcatList[index];
                    await controller.getProductList(subcat);
                  },
                  tabs: controller.subcatList.map((subcat) {
                    return Tab(
                      text: subcat,
                    );
                  }).toList(),
                ),
              ),
              controller.isloading.value
                  ? const Center(child: CircularProgressIndicator())
                      .paddingOnly(top: 50)
                  : controller.subcatList.isEmpty
                      ? const Center()
                      : Expanded(
                          child: TabBarView(
                            children: controller.subcatList.map((subcat) {
                              return const ProductView();
                            }).toList(),
                          ),
                        )
            ],
          ),
        );
      }),
    );
  }
}
