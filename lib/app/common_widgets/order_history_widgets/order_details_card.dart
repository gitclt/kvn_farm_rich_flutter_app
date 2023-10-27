import 'package:flutter/material.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class OrderDetailsWidget extends StatelessWidget {
  final String name, qty,image;
  final String code;
  final Function deleteonClick;
  const OrderDetailsWidget({
    super.key,
    required this.name,
    required this.code,
    required this.qty,
    required this.deleteonClick, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    var sizedBox = const SizedBox(
      height: 5,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              image,
              height: 86,
              width: 66,
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      blackText(name, 14, fontWeight: FontWeight.w600),
                    ],
                  ),
                  sizedBox,
                  greyText(code, 12),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 15,
                  ),
                  blackText('Qty: $qty', 12, fontWeight: FontWeight.w600),
                ],
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                deleteonClick();
              },
              child: svgWidget("assets/svg/delete.svg",
                  size: 25, color: red2Color),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          height: 5,
          color: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }
}

Widget orderType(String label) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: blackText("ORDER TYPE : $label", 10),
    ),
  );
}

SizedBox divider() {
  return const SizedBox(
      width: 12,
      height: 45,
      child: VerticalDivider(thickness: 1.5, color: Color(0xFFC4C4C4)));
}

Container borderWidget(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFFC4C4C4), width: .5),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Text(text),
  );
}
