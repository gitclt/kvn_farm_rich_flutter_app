import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/common_widgets/card/my_visit_card.dart';
import 'package:kvn_farm_rich/app/common_widgets/date_picker/attendance_date_picker.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../controllers/myvisit_controller.dart';

class MyvisitView extends GetView<MyvisitController> {
  const MyvisitView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldBgColor,
        appBar: const CommonAppBar(label: 'My Visit'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => AttendanceDatePicker(
                  date: controller.date.value,
                  changeDate: () {
                    controller.changeDate(context);
                  },
                  decrement: () {
                    controller.decrementDay();
                  },
                  increment: () {
                    controller.incrementDay();
                  },
                )),
            const Divider(
              thickness: 5,
              color: Colors.white,
            ),
            Expanded(
              child: AnimationLimiter(
                child: ListView.separated(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            duration: const Duration(milliseconds: 350),
                            horizontalOffset: 50.0,
                            // verticalOffset: 50.0,
                            child: VisitCardWidget(
                                slno: num.parse((index + 1).toString())
                                    .toString(),
                                name: 'CHOLAN SHOE MART',
                                location:
                                    'Crystal Building, Malad, Rathodi,Mankavu, Calicut',
                                duration: '3:49 PM',
                                remark: 'Order Booked'),
                          ));
                    },
                    separatorBuilder: (c, i) {
                      return visitDivider();
                    }),
              ),
            ),
          ],
        ));
  }
}

Container visitDivider() {
  return Container(
    height: 1.5,
    color: const Color(0xFFE2E2E2),
    width: double.infinity,
  );
}
