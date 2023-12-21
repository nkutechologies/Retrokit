import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageMotorView extends StatelessWidget {
  PageMotorView({super.key});
  final controller = Get.put(MonitorController());
  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: colors.backGround,
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors.backGround,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      utility().heading_selections('    Motor'),
                      Image.asset(
                        'assets/images/more2.png',
                        width: 130,
                        height: 70,
                        color: colors.text_color,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('RPM'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().speedInternal} RPM'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'revol. per minute', colors.dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().speedInternal,
                            Get.find<MonitorController>().motor_rpm_max,
                            'RPM')),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('ODO'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().motor_odo} KM'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'Odometer', colors.dark_grey),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('T'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().motor_temprature} °C'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().body_selections_const(
                            'Temprature', colors.dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().motor_temprature,
                            Get.find<MonitorController>().motor_temprature_max,
                            '')),
                      ],
                    ),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.wheel_selection(
                                      true, false, false, 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier1.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-1.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.wheel_selection(
                                      false, true, false, 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier2.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-2.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                              InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  controller.wheel_selection(
                                      false, false, true, 1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 3,
                                        color: controller.tier3.value == true
                                            ? Colors.green
                                            : Colors.transparent),
                                  ),
                                  child: Image.asset(
                                    'assets/images/tier-3.jpg',
                                    height: 100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),

                    Obx(
                      () => Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 0, left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              splashColor: Colors.transparent,
                              onTap: () {
                                controller.gear_selection(
                                    true, false, false, 0);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 3,
                                      color: controller.gear1.value == true
                                          ? Colors.green
                                          : Colors.transparent),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: 91,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/gear_icon.png',
                                        color: Colors.white,
                                        width: 55,
                                      ),
                                      Text(
                                        '22 - 36',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'BebasNeue',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              splashColor: Colors.transparent,
                              onTap: () {
                                controller.gear_selection(
                                    false, true, false, 1);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 3,
                                      color: controller.gear2.value == true
                                          ? Colors.green
                                          : Colors.transparent),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: 91,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/gear_icon.png',
                                        color: Colors.white,
                                        width: 55,
                                      ),
                                      Text(
                                        '22 - 40',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'BebasNeue',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashFactory: NoSplash.splashFactory,
                              splashColor: Colors.transparent,
                              onTap: () {
                                controller.gear_selection(
                                    false, false, true, 2);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      width: 3,
                                      color: controller.gear3.value == true
                                          ? Colors.green
                                          : Colors.transparent),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  width: 91,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/gear_icon.png',
                                        color: Colors.white,
                                        width: 55,
                                      ),
                                      Text(
                                        '22 - 44',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'BebasNeue',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Obx(() => Padding(
                    //       padding: const EdgeInsets.only(top: 10),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           InkWell(
                    //             splashFactory: NoSplash.splashFactory,
                    //             splashColor: Colors.transparent,
                    //             onTap: () {
                    //               controller.gear1.value = true;
                    //               controller.gear2.value = false;
                    //               controller.gear3.value = false;
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 border: Border.all(
                    //                     width: 3,
                    //                     color: controller.gear1.value == true
                    //                         ? Colors.green
                    //                         : Colors.transparent),
                    //               ),
                    //               child: Image.asset(
                    //                 'assets/images/gear-1.png',
                    //                 height: 100,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //           InkWell(
                    //             splashFactory: NoSplash.splashFactory,
                    //             splashColor: Colors.transparent,
                    //             onTap: () {
                    //               controller.gear1.value = false;
                    //               controller.gear2.value = true;
                    //               controller.gear3.value = false;
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 border: Border.all(
                    //                     width: 3,
                    //                     color: controller.gear2.value == true
                    //                         ? Colors.green
                    //                         : Colors.transparent),
                    //               ),
                    //               child: Image.asset(
                    //                 'assets/images/gear-2.png',
                    //                 height: 100,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //           InkWell(
                    //             splashFactory: NoSplash.splashFactory,
                    //             splashColor: Colors.transparent,
                    //             onTap: () {
                    //               controller.gear1.value = false;
                    //               controller.gear2.value = false;
                    //               controller.gear3.value = true;
                    //             },
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(5.0),
                    //                 border: Border.all(
                    //                     width: 3,
                    //                     color: controller.gear3.value == true
                    //                         ? Colors.green
                    //                         : Colors.transparent),
                    //               ),
                    //               child: Image.asset(
                    //                 'assets/images/gear-3.png',
                    //                 height: 100,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                  ],
                ),
                SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
