import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/state_controller.dart';

class StateView extends GetView<StateController> {
  const StateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
