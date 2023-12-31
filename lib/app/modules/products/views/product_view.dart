import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/product_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/product_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

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
                          1 / 1.3,
                        ),
                        const WovenGridTile(
                          7.1 / 8.9,
                          crossAxisRatio: 0.9,
                          alignment: AlignmentDirectional.topEnd,
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
                      code: controller.productList[index].code.toString(),
                      image: controller.productList[index].image1,
                      mrp: controller.productList[index].mrp.toString(),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => ProductPopup(
                            image: controller.productList[index].image1,
                            name: controller.productList[index].name,
                            code: controller.productList[index].code.toString(),
                            qtycontroller: controller.qtycontroller,
                            isloading: controller.cartloading.value,
                            prunit: controller.productList[index].priunit
                                .toString(),
                            secunit: controller.productList[index].secunit
                                .toString(),
                            mfdate: formatDateString2(controller
                                .productList[index].mfgdate
                                .toString()),
                            exdate: formatDateString2(controller
                                .productList[index].expdate
                                .toString()),
                            batchno:
                                controller.productList[index].batch.toString(),
                            ontap: () async {
                              controller.cartloading(true);
                              await controller.addqty(index);
                              await controller.saveData();
                              Get.back();
                              await controller
                                  .getProductList(controller.subcatname.value);
                              toast("Successfully added to cart");

                              controller.cartloading(false);
                            },
                            mrp: controller.productList[index].mrp.toString(),
                          ),
                        );
                      },
                    );
                  }, childCount: controller.productList.length),
                ),
              ));
  }
}
