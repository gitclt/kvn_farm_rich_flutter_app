import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/masala_controller.dart';

class ProductView extends GetView<MasalaController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(pattern: [
          const WovenGridTile(
            1,
            // crossAxisRatio: 0.9,
          ),
          const WovenGridTile(
            8 / 8,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.topCenter,
          )
        ], crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return Obx(() => controller.isloading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.productList.isEmpty
                  ? const NoDataWidget()
                  : ProductCard(
                      iteam: controller.productList[index].name,
                      code: controller.productList[index].mrp.toString(),
                      image: "assets/image/powder.png",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ProductPopup(
                            image: "assets/image/largeproduct.png",
                            name: controller.productList[index].name,
                            code: controller.productList[index].mrp.toString(),
                          ),
                        );
                      },
                    ));
        }, childCount: controller.productList.length),
      ),
    );
  }
}
