import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/search_feild.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class ProductPopup extends StatefulWidget {
  final String image;
  final String name;
  final String code;
  final Function ontap;
  final bool isloading;
  final TextEditingController qtycontroller;
  const ProductPopup({
    Key? key,
    required this.image,
    required this.name,
    required this.code,
    required this.ontap,
    required this.qtycontroller,
    required this.isloading,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => AddSalePopupState();
}

class AddSalePopupState extends State<ProductPopup>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
        child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
                scale: scaleAnimation!,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: size.height * 0.17,
                          left: size.width * 0.018,
                          right: size.width * 0.018,
                          bottom: size.height * 0.17),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(widget.image,
                                          fit: BoxFit.contain,
                                          height: size.height * 0.25,
                                          width: size.width * 0.56)
                                      .paddingOnly(left: size.width * 0.16),
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.close)
                                          .paddingOnly(left: size.width * 0.07))
                                ],
                              ),
                              blackText(widget.name, 20,
                                      fontWeight: FontWeight.bold)
                                  .paddingOnly(top: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  greyText("Mrp :", 14),
                                  greyText(widget.code, 14),
                                ],
                              ).paddingOnly(top: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  blackText("Enter Quantity", 16,
                                          fontWeight: FontWeight.w600)
                                      .paddingOnly(top: 10),
                                ],
                              ).paddingAll(5),
                              CommonSearchTextField(
                                hintText: "",
                                textEditingController: widget.qtycontroller,
                                isEnabled: true,
                              ).paddingOnly(top: 5, left: 5, right: 5),
                              CommonButtonWidget(
                                label: "ADD TO CART",
                                isLoading: widget.isloading,
                                onClick: () {
                                  if (widget.qtycontroller.text != "") {
                                    widget.ontap();
                                  }
                                },
                              ).paddingOnly(top: 25, left: 5, right: 5)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
