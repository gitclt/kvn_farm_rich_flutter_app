import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/remark_textfield.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/common_widgets/toast.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';
import 'package:kvn_farm_rich/constraints/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectDivision extends StatelessWidget {
  final List<String> divisions;

  final RxString selectedItem = ''.obs;

  SelectDivision({
    super.key,
    required this.divisions,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: ListView(
        shrinkWrap: true,
        children: [
          blackText('Choose Your Division', 20, fontWeight: FontWeight.bold),
          const SizedBox(height: 20),
          ListView.separated(
              separatorBuilder: (context, index) {
                return divider();
              },
              itemCount: divisions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(
                  () => Theme(
                    data: ThemeData(
                      unselectedWidgetColor: redColor,
                    ),
                    child: RadioListTile(
                        title: Text(
                          divisions[index],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        activeColor: redColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: divisions[index],
                        groupValue: selectedItem.value,
                        onChanged: (value) {
                          selectedItem.value = value.toString();
                        }),
                  ),
                );
              }),
          CommonButtonWidget(
              label: 'SUBMIT',
              onClick: () {
                Get.back(result: selectedItem.value);
              })
        ],
      ),
    );
  }
}

Future<dynamic> openDialog(
  String title,
  String subTitle,
) {
  return Get.dialog(AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(
              Icons.close,
              // size: 20,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: blackText(title, 20, fontWeight: FontWeight.w600),
        ),
      ],
    ),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: blackText(subTitle, 17),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.grey)))),
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: blackText('Cancel', 17)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: redColor)))),
                    onPressed: () {
                      Get.back(result: true);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                          fontFamily: "Manrope", color: redColor, fontSize: 17),
                    )),
              )
            ],
          ),
        ),
      ),
    ],
  ));
}

Future<dynamic> openMsgDialog(String title, String subTitle,
    {TextEditingController? remark,
    String? okRemark = 'Ok',
    String? cancelRemark = 'Cancel'}) {
  return Get.dialog(
    AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text(
        title,
        textScaleFactor: .9,
      ),
      content: subTitle.isEmpty
          ? null
          : Text(
              subTitle,
              textScaleFactor: .9,
            ),
      actions: [
        if (remark != null)
          RemarkTextField(
            hintText: "Enter Remark",
            textEditingController: remark,
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter Remark';
              }
              return null;
            },
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(result: false),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
                ),
                child: Text(
                  cancelRemark!,
                  style: const TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  if (remark == null) {
                    Get.back(result: true);
                  } else {
                    if (remark.text.isEmpty) {
                      toast(
                        "Enter Remark",
                      );
                    } else {
                      Get.back(result: true);
                    }
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    okRemark!,
                    style: const TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}

Future<dynamic> routeDialog() {
  return Get.dialog(AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    titlePadding: EdgeInsets.zero,
    contentPadding: EdgeInsets.zero,
    content: Column(mainAxisSize: MainAxisSize.min, children: [
      const SizedBox(
        height: 15,
      ),
      svgWidget('assets/svg/geo_location.svg'),
      const SizedBox(
        height: 45,
      ),
      blackText('You’re Out Of Shop Premises', 18, fontWeight: FontWeight.w700),
      const SizedBox(
        height: 6,
      ),
      greyText('Do you want to continue?', 16, fontWeight: FontWeight.w500),
      const SizedBox(
        height: 12,
      ),
      divider1(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: blackText('Cancel', 17)),
            ),
            const SizedBox(
              height: 50,
              child: VerticalDivider(
                color: popupLineColor,
                width: 20,
                thickness: 1,
              ),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                        fontFamily: "Manrope", color: redColor, fontSize: 17),
                  )),
            )
          ],
        ),
      ),
    ]),
    // actions: [

    // ],
  ));
}

void contactAdministrationSnackBar(String msg, String details) {
  Get.snackbar(
    msg,
    details,
    icon: const Icon(Icons.error, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: redColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: Colors.white,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.startToEnd,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

RoundedRectangleBorder bottomSheetShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(32.0),
      topRight: Radius.circular(32.0),
    ),
  );
}
