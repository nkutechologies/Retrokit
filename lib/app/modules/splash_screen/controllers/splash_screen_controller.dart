import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/local_storage_services.dart';

class SplashScreenController extends GetxController {
  void navigation() async {
    final _instance = LocalStorage();
    var session = _instance.read_session();
    await Future.delayed(Duration(seconds: 3)).then((_) {
      print(session);
      if (session == true) {
        Get.toNamed('/home');
      } else if (session == false) {
        Get.toNamed('/login');
      } else if (session == null) {
        Get.toNamed('/login');
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    navigation();
  }
}
