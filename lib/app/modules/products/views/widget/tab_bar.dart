// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kvn_farm_rich/app/modules/products/controllers/product_controller.dart';
// import 'package:kvn_farm_rich/app/modules/products/views/product_view.dart';
// import 'package:kvn_farm_rich/constraints/app_colors.dart';

// class ProductTabBar extends StatefulWidget {
//   const ProductTabBar({
//     super.key,
//   });

//   @override
//   // ignore: library_private_types_in_public_api
//   _StackOverState createState() => _StackOverState();
// }

// class _StackOverState extends State<ProductTabBar>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//   final MasalaController masalacontroller = Get.find();
//   @override
//   void initState() {
//     _tabController =
//         TabController(length: masalacontroller.subcatList.length, vsync: this);
//     // _tabController!.addListener(_onTabChanged);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController!.dispose();
//     super.dispose();
//   }

//   void _onTabChanged() async {
//     final selectedTabIndex = _tabController!.index;
//     final selectedSubcat = masalacontroller.subcatList[selectedTabIndex];
//     masalacontroller.subcatname.value = selectedSubcat;
//     await masalacontroller.getProductList(selectedSubcat);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: DefaultTabController(
//         length: masalacontroller.subcatList.length,
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: TabBar(
//                 controller: _tabController,
//                 labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//                 labelColor: redColor,
//                 indicatorColor: redColor,
//                 unselectedLabelStyle:
//                     const TextStyle(fontWeight: FontWeight.bold),
//                 unselectedLabelColor: Colors.black,
//                 onTap: (int index) async {
//                   String subcat = masalacontroller.subcatList[index];
//                   masalacontroller.subcatname.value = subcat;
//                   await masalacontroller.getProductList(subcat);
//                 },
//                 tabs: masalacontroller.subcatList.map((subcat) {
//                   return Tab(
//                     text: subcat,
//                   );
//                 }).toList(),
//               ),
//             ),
//             masalacontroller.isloading.value
//                 ? const Center(child: CircularProgressIndicator())
//                     .paddingOnly(top: 50)
//                 : masalacontroller.subcatList.isEmpty
//                     ? const Center()
//                     : Expanded(
//                         child: TabBarView(
//                           controller: _tabController,
//                           children: masalacontroller.subcatList.map((subcat) {
//                             return const ProductView();
//                           }).toList(),
//                         ),
//                       )
//           ],
//         ),
//       ),
//     );
//   }
// }
