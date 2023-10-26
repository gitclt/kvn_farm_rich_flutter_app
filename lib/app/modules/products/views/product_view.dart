import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';

class ProductView extends GetView<MasalaController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isloading.value
        ? const Center(child: CircularProgressIndicator())
        : controller.productList.isEmpty
            ? const NoDataWidget()
            : Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.custom(
                  gridDelegate: SliverWovenGridDelegate.count(
                      pattern: [
                        const WovenGridTile(
                          1,
                        ),
                        const WovenGridTile(
                          8 / 8,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.topCenter,
                        )
                      ],
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  childrenDelegate:
                      SliverChildBuilderDelegate((context, index) {
                    return ProductCard(
                      iteam: controller.productList[index].name,
                      itemId: controller.productList[index].id,
                      code: controller.productList[index].mrp.toString(),
                      image:
                          "${BaseUrl().imgUrl}${controller.productList[index].image1}",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ProductPopup(
                            image:
                                "${BaseUrl().imgUrl}${controller.productList[index].image1}",
                            name: controller.productList[index].name,
                            code: controller.productList[index].mrp.toString(),
                            qtycontroller: controller.qtycontroller,
                            isloading: controller.cartloading.value,
                            ontap: () async {
                              await controller.addqty(index);
                              await controller.saveData();
                              await controller
                                  .getProductList(controller.subcatname.value);
                              Get.back();
                            },
                          ),
                        );
                      },
                    );
                  }, childCount: controller.productList.length),
                ),
              ));
  }
}
