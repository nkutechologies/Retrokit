import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:retrokit/styles/colors.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());

    return Scaffold(
      backgroundColor: colors.backGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/retrokit_golden.png',
              width: Get.width - 100,
              color: Color.fromARGB(255, 233, 210, 7),
            ),
          ],
        ),
      ),
    );
  }
}
