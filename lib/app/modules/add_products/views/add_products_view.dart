import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_products_controller.dart';

class AddProductsView extends GetView<AddProductsController> {
  const AddProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddProductsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
