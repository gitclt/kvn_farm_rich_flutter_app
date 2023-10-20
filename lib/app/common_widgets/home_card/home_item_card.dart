import 'package:flutter/material.dart';
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
  final String path;
  final String label;
  // final Color color;
  final Function? onClick;

  const HomeCategories({
    super.key,
    required this.path,
    required this.label,
    //required this.color,
    this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        onClick!();
      },
      child: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1), // rgba(0, 0, 0, 0.10)
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ], borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.025,
                right: size.width * 0.075,
                top: size.width * 0.04,
                bottom: size.width * 0.04),
            child: Row(
              children: [
                // svgWidget(path),
                Image.asset(
                  path,
                  width: size.width * 0.13,
                  height: size.width * 0.13,
                ),
                const SizedBox(
                  width: 10,
                ),
                blackText(label, 14, fontWeight: FontWeight.w500)
              ],
            ),
          )),
    );
  }
}
