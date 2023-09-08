
import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class DivisionCardWidget extends StatelessWidget {
  final String label;
  final Function? act;

  final String selectItem;
  const DivisionCardWidget(
      {super.key, required this.label, required this.selectItem, this.act});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          blackText(label, 16, fontWeight: FontWeight.w600),
          InkWell(
              onTap: () {
                act!(label);
              },
              child: radioButton(label, selectItem))
        ]),
      ),
    );
  }
}

Widget radioButton(String text, String selectItem) {
  return Row(children: [
    Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 1.5, color: text == selectItem ? redColor : Colors.grey)),
      child: Center(
          child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: text == selectItem ? redColor : Colors.transparent,
            shape: BoxShape.circle),
      )),
    )
  ]);
}
