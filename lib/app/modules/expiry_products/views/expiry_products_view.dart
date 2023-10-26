import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kvn_farm_rich/app/common_widgets/app_bar/common_app_bar.dart';
import 'package:kvn_farm_rich/app/modules/expiry_products/views/expiry_product_products.dart';
import 'package:kvn_farm_rich/app/modules/expiry_products/views/expiry_product_shop.dart';
import 'package:kvn_farm_rich/constraints/app_colors.dart';

import '../controllers/expiry_products_controller.dart';

class ExpiryProductsView extends GetView<ExpiryProductsController> {
  const ExpiryProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: const CommonAppBar(
        label: "Expiry Products",
        visibility: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              labelColor: redColor,
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.w400),
              unselectedLabelColor: Colors.black,
              onTap: (int index) {
                if (index == 0) {
                } else {}
              },
              tabs: const [
                Tab(
                  text: "SHOPS",
                ),
                Tab(
                  text: "PRODUCTS",
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  ExpiryProductShopView(),
                  ExpiryProductProductsView()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
