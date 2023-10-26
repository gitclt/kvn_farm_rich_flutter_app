import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/home_card/home_item_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/modules/home/controllers/home_controller.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';

class CategoryView extends GetView<HomeController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        label: "Categories",
        visibility: false,
      ),
      body: Obx(
        () => controller.isloading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.categoryList.isEmpty
                ? const NoDataWidget()
                : SingleChildScrollView(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.bounceInOut,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0.0,
                          childAspectRatio: 1.9,
                          mainAxisSpacing: 0.0,
                        ),
                        itemCount: controller.categoryList.length,
                        itemBuilder: (BuildContext context, index) {
                          return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              columnCount: 6,
                              child: ScaleAnimation(
                                  child: FadeInAnimation(
                                      child: HomeCategories(
                                label: controller.categoryList[index],
                                onClick: () {
                                  Get.toNamed(Routes.PRODUCT,
                                      arguments:
                                          controller.categoryList[index]);
                                },
                              ))));
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
