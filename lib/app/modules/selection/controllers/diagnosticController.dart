import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../monitor/controllers/monitor_controller.dart';

class diagnosticController extends GetxController {
  var flList = <FlSpot>[].obs;
  RxBool show_me = false.obs;
  var dateTimeInitial;
  int rand = 0;
  RxDouble minX = 0.0.obs;
  RxDouble maxX = 9.0.obs;

  addSpotX_Y() {
    final seconds = DateTime.now().millisecondsSinceEpoch;
    final timeDiff = (seconds - dateTimeInitial) / 60000;
    if (flList.isEmpty || flList.last.x < 9.0) {
      flList.add(FlSpot(
        timeDiff.toDouble(),
        Get.find<MonitorController>().percentage_internal.toDouble(),
      ));
      show_me.value = true;
    } else {
      flList.removeAt(0);
      flList.add(FlSpot(
        timeDiff.toDouble(),
        Get.find<MonitorController>().percentage_internal.toDouble(),
      ));
      minX.value = flList[0].x;
      maxX.value = flList.last.x;
    }
  }
}
