import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/text_fields/common_searchfield.dart';

import '../controllers/place_controller.dart';

class PlaceView extends GetView<PlaceController> {
  const PlaceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CommonAppBar(label: 'Place'),
        body: Obx(
          () => (controller.isplaceLoading.value)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: CommonSearchField(
                        hintText: 'Search',
                        textEditingController: controller.searchcontroller,
                        prefixIcon: const Icon(Icons.search),
                        onChanged: (String value) {
                          controller.placeSearch();
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (c, i) {
                            return const Divider(
                              thickness: 1,
                            );
                          },
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 5),
                          itemCount: controller.placeList.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: InkWell(
                                onTap: () {
                                  Get.back(
                                      result: controller.placeList[index].name);
                                },
                                child: blackText(
                                        controller.placeList[index].name, 16)
                                    .paddingOnly(
                                        left: 15, right: 10, top: 8, bottom: 8),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
        ));
  }
}
