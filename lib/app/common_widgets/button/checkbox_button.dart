import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckBoxButton extends StatelessWidget {
  // final List<String> items;
  final bool selectItem;
  final Function act;
  final double? height;
  final double? width;

  const CheckBoxButton({
    Key? key,
    required this.selectItem,
    required this.act,
    this.height = 20,
    this.width = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 0.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 8),
          child: InkWell(
              onTap: () {
                act();
              },
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    width: 2.4,
                    color: selectItem
                        ? const Color(0xffD80005)
                        : const Color(0xffD80005),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectItem
                        ? const Color(0xffD80005)
                        : Colors.transparent,
                  ),
                  child: selectItem
                      ? const Icon(
                          Icons.check_sharp,
                          color: Colors.white,
                          size: 16,
                        ).paddingOnly(bottom: 0, right: 3)
                      : const Icon(null),
                ),
              )),
        ),
      ),
    ]);
  }
}
