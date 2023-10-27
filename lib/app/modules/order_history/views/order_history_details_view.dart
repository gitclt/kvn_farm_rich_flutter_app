import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kvn_farm_rich/app/api/base_url.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/order_history_widgets/order_details_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/order_history_widgets/order_top_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/delete_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/order_details_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/constraints/date_formats.dart';

class OrderHistoryDetailsView extends GetView<OrderDetailsController> {
  const OrderHistoryDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(label: 'Order History'),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: OrderTopWidget(
                      no: controller.orderbyorderno.first.qty.toString(),
                      orderNo:
                          controller.orderbyorderno.first.orderNo.toString(),
                      date: formatDateString3(
                          controller.orderbyorderno.first.date.toString()),
                      type: controller.orderbyorderno.first.status.toString(),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: scaffoldBgColor,
                  ),
                  blackText('Order Details', 16, fontWeight: FontWeight.w600)
                      .paddingAll(10),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.orderbyorderno.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                duration: const Duration(milliseconds: 350),
                                verticalOffset: 50.0,
                                child: OrderDetailsWidget(
                                  image:
                                      "${BaseUrl().imgUrl}${controller.orderbyorderno[index].image1}",
                                  name: controller.orderbyorderno[index].name,
                                  code: controller.orderbyorderno[index].id
                                      .toString(),
                                  qty: controller.orderbyorderno[index].qty
                                      .toString(),
                                  mrp: controller.orderbyorderno[index].qty
                                      .toString(),
                                  deleteonClick: () async {
                                    if (controller.orderbyorderno.length == 1) {
                                      toast("Cannot Delete One Quantity Item");
                                    } else {
                                      deleteOrderPopup(() async {
                                        await controller.deleteOrderbyitem(
                                            controller.orderbyorderno[index].id
                                                .toString());
                                      });
                                    }
                                  },
                                ).paddingAll(5),
                              ));
                        }),
                  ),

                  // const Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  //   child: OrderInvoiceDetailsWidget(
                  //     invNo: 'KVN/ENQ/026536',
                  //     number: '9856254147',
                  //     place:
                  //         'Crystal Building, Malad, Rathodi, Mankavu, Calicut',
                  //   ),
                  // )
                ],
              )));
  }
}
