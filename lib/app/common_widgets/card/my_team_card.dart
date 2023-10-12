import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/button/checkbox_button.dart';
import 'package:kvn_farm_rich/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kvn_farm_rich/app/common_widgets/texts/text.dart';
import 'package:kvn_farm_rich/app/models/not_assigned_route_model.dart';
import 'package:kvn_farm_rich/app/modules/my_team/controllers/shop_assign_controller.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

class MyTeamAssignCard extends StatelessWidget {
  final String shopname;
  final Function ontap;
  final String location;
  final String number;
  final bool selectItem;
  final Function onTapGps;
  final Function onTapCall;
  final NotAssignedRoute items;

  const MyTeamAssignCard({
    super.key,
    required this.shopname,
    required this.location,
    required this.number,
    required this.selectItem,
    required this.ontap,
    required this.onTapGps,
    required this.onTapCall,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 240, 235, 235),
                blurRadius: 3.0,
                spreadRadius: 3),
          ]),
      child: Row(
        children: [
          CheckBoxButton(
            act: () {
              ontap();
            },
            selectItem: selectItem,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            blackText(shopname, 16, fontWeight: FontWeight.w600),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                svgWidget('assets/svg/location.svg'),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    greyText(location, 12, textOverflow: TextOverflow.ellipsis),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    svgWidget('assets/svg/Call.svg', size: 15),
                    SizedBox(
                      width: size.width * 0.005,
                    ),
                    greyText(number, 12),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      onTapGps();
                    },
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xffE1F8FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          svgWidget('assets/svg/pin_drop.svg',
                              color: const Color(0xff4F9AB5),
                              blendMode: BlendMode.srcIn),
                          const Text(
                            " MAP",
                            style: TextStyle(color: Color(0xff4F9AB5)),
                          ).paddingOnly(right: 4)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.025,
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: svgWidget('assets/svg/Call.svg',
                          color: const Color(0xffffffff),
                          blendMode: BlendMode.srcIn),
                      onPressed: () {
                        onTapCall();
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(
                width: size.width * 0.045,
              ),
              // Spacer(),
              DropDownStatus(type: items.type)
            ]),
          ]).paddingAll(5),
        ],
      ),
    );
  }
}

// class StatusDropdown extends StatefulWidget {
//   const StatusDropdown({Key? key}) : super(key: key);
//   @override
//   State<StatusDropdown> createState() => _DropdownDemoState();
// }

// class _DropdownDemoState extends State<StatusDropdown> {
//   String dropdownValue = 'Live';

//   final ShopAssignController shopAssignController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     shopAssignController.dropValue = dropdownValue;
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.0375,
//       width: MediaQuery.of(context).size.width * 0.375,
//       decoration: BoxDecoration(
//         color: const Color(0xffffffff),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromARGB(255, 240, 235, 235),
//             blurRadius: 3.0,
//             spreadRadius: 3,
//           ),
//         ],
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: dropdownValue,
//           alignment: AlignmentDirectional.centerStart,
//           isExpanded: true,
//           hint: const Text(
//             'Select Type',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.black,
//             ),
//           ),
//           icon: const Icon(
//             Icons.expand_more,
//             color: Colors.black,
//           ),
//           items: <String>[
//             'Live',
//             'Work From Home',
//           ].map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Center(
//                 child: Text(
//                   value,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               dropdownValue = newValue!;
//               shopAssignController.dropValue = newValue;
//             });
//           },
//         ),
//       ).paddingOnly(right: 5),
//     );
//   }
// }

class DropDownStatus extends StatelessWidget {
  final RxString? type;
  const DropDownStatus({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    final ShopAssignController shopAssignController = Get.find();
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x28000000),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      height: 35,
      child: DropdownButtonFormField(
        value: type!.value,
        icon: const Icon(
          Icons.expand_more_outlined,
        ),

        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            border: InputBorder.none),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Select Type';
        //   }
        //   return null;
        // },
        items: shopAssignController.status
            .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 12),
                  ),
                ))
            .toList(),
        // hint: const Text(
        //   'Select Type',
        //   style: TextStyle(fontSize: 12, color: Colors.grey),
        // ),
        onChanged: (value) {
          type!.value = value.toString();
          shopAssignController.statusController.text = value.toString();
        },
      ),
    );
  }
}