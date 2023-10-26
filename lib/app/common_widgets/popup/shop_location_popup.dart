import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

void shopLocationPopup(Function onpress, Function onpress1) async {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Update Location'),
        ],
      ),
      content: greyText('You can update location by clicking Continue', 16),
      actions: [
        const Divider(
          color: Color(0xffE3EBF6),
          thickness: 2,
          endIndent: 0,
          indent: 0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                onpress1();
              },
              child: blackText('Skip', 15),
            ),
            // Container(
            //   color: const Color(0xffE3EBF6),
            //   height: 50,
            //   width: 2,
            // ),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: Color(0xffE3EBF6),
                width: 20,
                thickness: 1,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                onpress();
              },
              child: redText('Continue', 15),
            ),
          ],
        )
      ],
    ),
  );
}
