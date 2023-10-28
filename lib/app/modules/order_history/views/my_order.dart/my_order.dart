import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/order_history_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/nodata_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/popup/delete_popup.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
import 'package:kvn_farm_rich/app/modules/order_history/controllers/my_order_controller.dart';
import 'package:kvn_farm_rich/app/modules/shops/views/add_shop.dart';
import 'package:kvn_farm_rich/app/routes/app_pages.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../../constraints/date_formats.dart';

class MyOrder extends GetView<MyOrderController> {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(
          label: 'Order History',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        controller.invoiceDate.value = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                        return showModalBottomSheet(
                            context: context,
                            backgroundColor: Get.isDarkMode
                                ? const Color(0xff1F1F1F)
                                : Colors.white,
                            elevation: 10.0,
                            isDismissible: true,
                            shape: bootomSheetShapeType2(),
                            builder: (BuildContext context) {
                              return SizedBox(
                                child: TableCalendar(
                                    shouldFillViewport: true,
                                    calendarStyle: const CalendarStyle(
                                        selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        todayTextStyle: TextStyle(
                                          color: redColor,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                            color: redColor,
                                            shape: BoxShape.circle)),
                                    daysOfWeekVisible: true,
                                    daysOfWeekHeight: 40,
                                    headerStyle: const HeaderStyle(
                                      leftChevronVisible: true,
                                      rightChevronVisible: true,
                                      titleTextStyle: TextStyle(
                                          color: redColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      titleCentered: true,
                                      formatButtonVisible: false,
                                    ),
                                    onDaySelected: (date, focusday) {
                                      controller.invoiceDate.value =
                                          DateFormat('yyyy/MM/dd').format(date);
                                      controller.invDate =
                                          controller.invoiceDate.toString();
                                      controller.selectfrom = focusday;
                                      controller.fromDate.value =
                                          controller.invDate;
                                      controller.datecontroller.text =
                                          controller.invDate;
                                      Get.back();
                                      controller.toDate.value = ' To Date';
                                    },
                                    selectedDayPredicate: (day) =>
                                        isSameDay(day, controller.selectfrom),
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: controller.invoiceDate.value ==
                                            ""
                                        ? DateTime.now()
                                        : DateTime.parse(
                                            controller.selectfrom.toString())),
                              );
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .45,
                        height: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(215, 215, 215, 1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                            ),
                            Text(
                              controller.fromDate.value == ''
                                  ? "From Date"
                                  : controller.fromDate.value,
                            ),
                            const Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        controller.invoiceDate.value = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                        return showModalBottomSheet(
                            context: context,
                            backgroundColor: Get.isDarkMode
                                ? const Color(0xff1F1F1F)
                                : Colors.white,
                            elevation: 10.0,
                            isDismissible: true,
                            shape: bootomSheetShapeType2(),
                            builder: (BuildContext context) {
                              return SizedBox(
                                child: TableCalendar(
                                    shouldFillViewport: true,
                                    calendarStyle: const CalendarStyle(
                                        selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        todayTextStyle: TextStyle(
                                          color: redColor,
                                        ),
                                        selectedDecoration: BoxDecoration(
                                            color: redColor,
                                            shape: BoxShape.circle)),
                                    daysOfWeekVisible: true,
                                    daysOfWeekHeight: 40,
                                    headerStyle: const HeaderStyle(
                                      leftChevronVisible: true,
                                      rightChevronVisible: true,
                                      titleTextStyle: TextStyle(
                                          color: redColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      titleCentered: true,
                                      formatButtonVisible: false,
                                    ),
                                    onDaySelected: (date, focusday) {
                                      controller.invoiceDate.value =
                                          DateFormat('yyyy/MM/dd').format(date);
                                      controller.invDate =
                                          controller.invoiceDate.toString();
                                      controller.selectfrom = focusday;
                                      controller.toDate.value =
                                          controller.invDate;

                                      controller.getMyOrder();
                                      Get.back();
                                    },
                                    selectedDayPredicate: (day) =>
                                        isSameDay(day, controller.selectfrom),
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: controller.invoiceDate.value ==
                                            ""
                                        ? DateTime.now()
                                        : DateTime.parse(
                                            controller.selectfrom.toString())),
                              );
                            });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .45,
                        height: 47,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(215, 215, 215, 1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.calendar_today,
                                size: 20,
                              ),
                            ),
                            Text(
                              controller.toDate.value == ''
                                  ? "To Date"
                                  : controller.toDate.value,
                            ),
                            const Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextFeild(
                  readonly: true,
                  hintText: 'Select Lead',
                  borderRadius: 10,
                  textEditingController: controller.leadoptioncontroller,
                  onTap: () async {
                    controller.getShops();
                  },
                  suffixIcon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : controller.myOrderList.isEmpty
                          ? const SizedBox(child: NoDataWidget())
                          : Expanded(
                              child: AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: controller.myOrderList.length,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                              position: index,
                                              child: SlideAnimation(
                                                duration: const Duration(
                                                    milliseconds: 350),
                                                verticalOffset: 50.0,
                                                child: OrderHistoryCardWidget(
                                                  visible: true,
                                                  ordernmbr: controller
                                                      .myOrderList[index]
                                                      .orderNo,
                                                  qnty: controller
                                                      .myOrderList[index].qty
                                                      .toString(),
                                                  location: '',
                                                  onClick: () async {
                                                    Get.toNamed(
                                                        Routes
                                                            .ORDER_HISTORY_DETAILS,
                                                        arguments: controller
                                                                .myOrderList[
                                                            index]);
                                                  },
                                                  deleteonClick: () {
                                                    deleteOrderPopup(() async {
                                                      await controller
                                                          .deleteOrder(
                                                              controller
                                                                  .myOrderList[
                                                                      index]
                                                                  .orderNo);
                                                    });
                                                  },
                                                  date: formatDateString3(
                                                      controller
                                                          .myOrderList[index]
                                                          .date
                                                          .toString()),
                                                ).paddingAll(3),
                                              ));
                                    }),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ));
  }
}
