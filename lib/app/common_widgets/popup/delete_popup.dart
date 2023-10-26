import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

void deletePopup(Function onpress, Function onpress1) async {
  Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Delete Item'),
        ],
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              width: 260,
              child:
                  greyText('Do you want to Delete this item from Cart ?', 16)),
        ],
      ),
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
              child: blackText('No', 15),
            ),
            Container(
              color: const Color(0xffE3EBF6),
              height: 50,
              width: 2,
            ),
            TextButton(
              onPressed: () {
                Get.back();
                onpress();
              },
              child: redText('Yes', 15),
            ),
          ],
        )
      ],
    ),
  );
}
