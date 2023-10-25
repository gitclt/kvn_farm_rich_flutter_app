import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';

class ProductCard extends StatelessWidget {
  final String iteam;
  final String image;

  final Function onTap;
  final String code;
  final Function? act;
  // final Color colors, color;
  const ProductCard({
    Key? key,
    required this.iteam,
    // required this.colors,
    required this.image,
    required this.onTap,
    required this.code,
    this.act,
    // required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (() => onTap()),
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 200,
          width: 180,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Column(children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,

                  // loadingBuilder: (BuildContext context, Widget child,
                  //     ImageChunkEvent? loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       color: redColor,
                  //       value: loadingProgress.expectedTotalBytes != null
                  //           ? loadingProgress.cumulativeBytesLoaded /
                  //               loadingProgress.expectedTotalBytes!
                  //           : null,
                  //     ),
                  //   );
                  // },
                  // errorBuilder: (context, exception, stackTrack) =>
                  //     const Center(
                  //   child: Icon(
                  //     Icons.error,
                  //     color: redColor,
                  //   ),
                  // ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackText(iteam, 12, fontWeight: FontWeight.w600),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                greyText("Mrp :", 12),
                greyText(code, 12),
              ],
            ).paddingOnly(top: 5),
          ]),
        ));
  }
}
