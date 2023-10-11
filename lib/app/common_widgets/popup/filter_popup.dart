import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class PopupButton extends StatelessWidget {
  final String name;
  final Function ontap;
  const PopupButton({super.key, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.60,
        child: Column(
          children: [
            blackText(name, 15,
                    fontWeight: FontWeight.w500, textAlign: TextAlign.center)
                .paddingAll(15),
          ],
        ),
      ),
    );
  }
}
