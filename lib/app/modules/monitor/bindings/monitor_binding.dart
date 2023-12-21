import 'package:get/get.dart';

import '../controllers/monitor_controller.dart';

class MonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonitorController>(
      () => MonitorController(),
    );
  }
}
