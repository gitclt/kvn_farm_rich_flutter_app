import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class HomeCardItem extends StatelessWidget {
  final String path;
  final String label;
  final Function? ontap;
  const HomeCardItem(
      {super.key, required this.path, required this.label, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap!();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: homeMenuColor.withOpacity(0.50)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 18),
                    child: svgWidget(
                      path,
                      color: redColor,
                      blendMode: BlendMode.srcIn,
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              blackText(label, 13,
                  textAlign: TextAlign.center, fontWeight: FontWeight.w500)
            ],
          ),
        ),
      ),
    );
  }
}

// class HomeCategories extends StatelessWidget {
//   final String path;
//   final String label;
//   final Color color;
//   final Function? onClick;

//   const HomeCategories({
//     super.key,
//     required this.path,
//     required this.label,
//     required this.color,
//     this.onClick,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onClick!();
//       },
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         // crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16), color: Colors.white),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                 child: svgWidget(path, color: color),
//               )),
//           const SizedBox(
//             height: 6,
//           ),
//           blackText(label, 14, fontWeight: FontWeight.w500)
//         ],
//       ),
//     );
//   }
// }

class HomeCategories extends StatelessWidget {
  final String label;
  // final Color color;
  final Function? onClick;

  const HomeCategories({
    super.key,
    required this.label,
    //required this.color,
    this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.39,
              height: MediaQuery.of(context).size.width * 0.18,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 4,
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                )
              ], borderRadius: BorderRadius.circular(18), color: Colors.white),
              child: Center(
                child: blackText(label, 14,
                    fontWeight: FontWeight.w500, textAlign: TextAlign.center),
              ).paddingOnly(left: 5, right: 5))
        ],
      ),
    );
  }
}
