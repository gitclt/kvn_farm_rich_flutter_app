// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
// import 'package:kvn_farm_rich/app/common_widgets/textfield/common_textfield.dart';
// import 'package:kvn_farm_rich/app/modules/shops/controllers/shops_controller.dart';
// import 'package:kvn_farm_rich/app/modules/shops/views/add_lead1.dart';

// class NextAddLeads extends GetView<ShopsController>{
//   const NextAddLeads({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = SizedBox(height: MediaQuery.of(context).size.height * 0.02);
//     return Scaffold(
//       appBar: const CommonAppBar(label: 'Add Leads'),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Form(
//           key: controller.formKey1,
//           child: Column(children: [
//             const SizedBox(
//               height: 5,
//             ),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 HeaderWidget(
//                   number: "1",
//                   color: Color(0xffD80005),
//                 ),
//                 Expanded(
//                     child: Divider(
//                   color: Color(0xffD80005),
//                   thickness: 2,
//                 )),
//                 HeaderWidget(number: "2", color: Color(0xffD80005)),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             size,
//             CommonTextFeild(
//               hintText: 'Select Branch Head',
//               labelText: 'Select Branch Head',
//               readonly: true,
//               textEditingController: controller.buissnessheadcontroller,
//               suffixIcon: const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//                 color: redColor,
//               ),
//               onTap: () async {
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 if (controller.bhlist.length != 1) {
//                   final response = await selectPopup(
//                       controller.bhlist,
//                       controller.buissnessheadcontroller,
//                       controller.selectedbH);
//                   if (response != null) {
//                     controller.selectedbH = int.parse(response);
//                   }
//                 }
//               },
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Select Branch Head';
//                 }
//                 return null;
//               },
//             ),
//             // Zsm
//             if (Session.roleId != '4') size,
//             if (Session.roleId != '4')
//               CommonTextFeild(
//                 hintText: 'Select ZSM',
//                 labelText: 'Select ZSM',
//                 readonly: true,
//                 textEditingController: controller.zsmcontroller,
//                 suffixIcon: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 15,
//                   color: redColor,
//                 ),
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   if (controller.zsmlist.length != 1) {
//                     final response = await selectPopup(controller.zsmlist,
//                         controller.zsmcontroller, controller.selectedzsm);
//                     if (response != null) {
//                       controller.selectedzsm = int.parse(response);
//                     }
//                   }
//                 },
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Select ZSM';
//                   }
//                   return null;
//                 },
//               ),
//             size,
//             if (Session.roleId != '5')
//               CommonTextFeild(
//                 hintText: 'Select TSC',
//                 labelText: 'Select TSC',
//                 readonly: true,
//                 textEditingController: controller.tsccontroller,
//                 suffixIcon: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 15,
//                   color: redColor,
//                 ),
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   if (controller.tsclist.length != 1) {
//                     final response = await selectPopup(controller.tsclist,
//                         controller.tsccontroller, controller.selectedtsc);
//                     if (response != null) {
//                       controller.selectedtsc = int.parse(response);
//                     }
//                   }
//                 },
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Select TSC';
//                   }
//                   return null;
//                 },
//               ),
//             if (Session.roleId != '6') size,
//             if (Session.roleId != '6')
//               CommonTextFeild(
//                 hintText: 'Select TSE',
//                 labelText: 'Select TSE',
//                 readonly: true,
//                 textEditingController: controller.tsecontroller,
//                 suffixIcon: const Icon(
//                   Icons.arrow_forward_ios,
//                   size: 15,
//                   color: redColor,
//                 ),
//                 onTap: () async {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                   if (controller.tselist.length != 1) {
//                     final response = await selectPopup(controller.tselist,
//                         controller.tsecontroller, controller.selectedTse);
//                     if (response != null) {
//                       controller.selectedTse = int.parse(response);
//                     }
//                   }
//                 },
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Select TSE';
//                   }
//                   return null;
//                 },
//               ),
//           ]),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Obx(
//             () => CommonButtonWidget(
//               isLoading: controller.isLoading.value,
//               label: 'NEXT',
//               onClick: () async {
//                 FocusScope.of(context).unfocus();
//                 if (controller.formKey.currentState!.validate()) {
//                   await controller.addLead();
//                 }
//               },
//             ),
//           )),
//     );
//   }

//   Future<dynamic> selectPopup(List<TeamDetails> item,
//       TextEditingController selectedcontroller, int selectedid) {
//     return Get.dialog(AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       titlePadding: EdgeInsets.zero,
//       contentPadding: EdgeInsets.zero,
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: item.map((teamDetail) {
//             return PopupButton(
//               name: teamDetail.name.toString(),
//               ontap: () {
//                 selectedcontroller.text = teamDetail.name.toString();
//                 selectedid = teamDetail.id;
//                 Get.back(result: teamDetail.id.toString());
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     ));
//   }
// }
    
//   }
  
// }