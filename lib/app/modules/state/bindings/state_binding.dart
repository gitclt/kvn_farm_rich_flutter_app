import 'package:get/get.dart';

import '../controllers/state_controller.dart';

class StateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StateController>(
      () => StateController(),
    );
  }
}
