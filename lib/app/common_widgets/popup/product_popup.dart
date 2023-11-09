import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/loginbutton.dart';
import 'package:kvn_farm_rich/app/common_widgets/textfield/search_feild.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class ProductPopup extends StatefulWidget {
  final String image;
  final String name;
  final String code;
  final String mrp;
  final String prunit;
  final String secunit;
  final String mfdate;
  final String exdate;
  final String batchno;
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
    required this.mrp,
    required this.prunit,
    required this.secunit,
    required this.mfdate,
    required this.exdate,
    required this.batchno,
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
                          top: size.height * 0.12,
                          left: size.width * 0.018,
                          right: size.width * 0.018,
                          bottom: size.height * 0.15),
                      child: Container(
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    widget.image,
                                    fit: BoxFit.contain,
                                    height: size.height * 0.15,
                                    width: size.width * 0.25,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/image/search.png',
                                        height: size.height * 0.15,
                                        width: size.width * 0.25,
                                      );
                                    },
                                  ).paddingOnly(right: size.width * 0.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      blackText(widget.name.toUpperCase(), 20,
                                          fontWeight: FontWeight.w500),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      greyText(
                                          "#${widget.code.toUpperCase()}", 16),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      redText("₹${widget.mrp}", 26,
                                          fontWeight: FontWeight.bold),
                                    ],
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.close)
                                          .paddingOnly(left: size.width * 0.1))
                                ],
                              ),
                              SizedBox(
                                height: size.height * 0.010,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: const Color(0xffE6E6E6)),
                                ),
                                child: Column(
                                  children: [
                                    DetailsCard(
                                      details: widget.prunit,
                                      label: "Primary Unit",
                                    ).paddingAll(6),
                                    DetailsCard(
                                      details: widget.secunit,
                                      label: "Secondary Unit",
                                    ).paddingAll(6),
                                    DetailsCard(
                                      details: widget.mfdate,
                                      label: "Manufacturing Date",
                                    ).paddingAll(6),
                                    DetailsCard(
                                      details: widget.exdate,
                                      label: "Expiring Date",
                                    ).paddingAll(6),
                                    DetailsCard(
                                      details: widget.batchno,
                                      label: "Batch ID",
                                    ).paddingAll(6),
                                  ],
                                ),
                              ).paddingAll(8),
                              // blackText(widget.name, 20,
                              //         fontWeight: FontWeight.bold)
                              //     .paddingOnly(top: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     greyText("Mrp :", 14),
                              //     greyText(widget.mrp, 14),
                              //   ],
                              // ).paddingOnly(top: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     greyText(widget.code, 14),
                              //   ],
                              // ).paddingOnly(top: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  blackText("Enter Quantity", 16,
                                          fontWeight: FontWeight.w500)
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

class DetailsCard extends StatelessWidget {
  final String label;
  final String details;
  const DetailsCard({super.key, required this.label, required this.details});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        greyText("$label:", 16, fontWeight: FontWeight.w400),
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: blackText(details, 16,
              fontWeight: FontWeight.w500, textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
