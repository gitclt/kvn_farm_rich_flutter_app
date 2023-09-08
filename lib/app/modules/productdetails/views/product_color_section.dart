import 'package:kvn_farm_rich/app/modules/productdetails/controllers/productdetails_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widgets/texts/text.dart';

class ProductColorSection extends StatelessWidget {
  const ProductColorSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductdetailsController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: blackText("COLOR", 16, fontWeight: FontWeight.w500),
            ),
            Wrap(runSpacing: 5, spacing: 10, children: [
              ColorWidget(
                color: "Blue",
                onTap: () {
                  // send to index
                  // controller.changeSelectedAttribute(attribute);
                },
                colorCode: "",
                selected: true,
              ),
              ColorWidget(
                color: "Blue",
                onTap: () {
                  // send to index
                  // controller.changeSelectedAttribute(attribute);
                },
                colorCode: "",
                selected: false,
              )
            ])
          ],
        ),
      );
    });
  }
}

class ColorWidget extends StatelessWidget {
  final String colorCode;
  final String color;
  final bool selected;
  final Function onTap;
  const ColorWidget(
      {Key? key,
      required this.colorCode,
      required this.color,
      required this.onTap,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (() {
            onTap();
          }),
          child: SizedBox(
            height: 30,
            child: Container(
              width: selected ? 40 : 35,
              height: selected ? 40 : 35,
              decoration: BoxDecoration(
                color: selected ? null : redColor,
                border: Border.all(color: Colors.red),
                shape: BoxShape.circle,
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: redColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 15,
          child: Center(
            child: Text(
              color,
              style: TextStyle(
                fontSize: selected ? 10 : 8,
                color: selected ? Colors.black : Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}
