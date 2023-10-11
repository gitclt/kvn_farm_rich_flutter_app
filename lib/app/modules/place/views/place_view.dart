import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/place_controller.dart';

class PlaceView extends GetView<PlaceController> {
  const PlaceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlaceView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlaceView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
