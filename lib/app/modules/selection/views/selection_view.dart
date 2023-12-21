import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_battery_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_controller_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_motor_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_diagnostic_view.dart';
import 'package:retrokit/app/modules/selection/views/selection_views/page_warning_view.dart';
import 'package:retrokit/styles/colors.dart';
import '../controllers/selection_controller.dart';

class SelectionView extends GetView<SelectionController> {
  const SelectionView({super.key});

  _containers(routes, icons, names) {
    return InkWell(
      onTap: () {
        routes;
      },
      child: Card(
        color: colors.backGround,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: colors.text_color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                '${icons}',
                width: 130,
                height: 110,
                color: colors.text_color,
              ),
              Text(
                '${names}',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                  color: colors.text_color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> iconsPath = [
      'assets/images/01.png',
      'assets/images/more1.png',
      'assets/images/more2.png',
      'assets/images/more13.png',
      'assets/images/03.png',
    ];
    List<String> names = [
      'Battery',
      'Controller',
      'Motor',
      'Diagnostic',
      'Error'
    ];
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        backgroundColor: colors.backGround,
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: colors.backGround,
          automaticallyImplyLeading: false,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => Get.find<MonitorController>().connected.value == false
                    ? ElevatedButton(
                        onPressed: () {
                          if (Get.find<MonitorController>().blueON == false) {
                            Get.find<MonitorController>().enableBT();
                          } else if (Get.find<MonitorController>()
                                      .connected
                                      .value ==
                                  false &&
                              Get.find<MonitorController>().blueON == true) {
                            Get.find<MonitorController>().startScan();
                          }
                        },
                        child: Text(
                          'Connect',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          backgroundColor: colors.green,
                        ),
                      )
                    : SizedBox(
                        height: 0,
                      )),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<MonitorController>().logout();
                    },
                    child: Icon(Icons.login_outlined, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      backgroundColor:
                          Color.fromARGB(255, 233, 210, 7), // <-- Button color
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        body: Center(
          child: Container(
            padding: landscape ? null : const EdgeInsets.only(top: 30),
            child: ListView(children: [
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 8,
                spacing: 8,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => PageBatteryView());
                    },
                    child: Card(
                      color: colors.backGround,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors.text_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              '${iconsPath[0]}',
                              width: landscape ? 85 : 130,
                              height: landscape ? 100 : 110,
                              color: colors.text_color,
                            ),
                            Text(
                              '${names[0]}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.normal,
                                color: colors.text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => PageControllerView());
                    },
                    child: Card(
                      color: colors.backGround,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors.text_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              '${iconsPath[1]}',
                              width: landscape ? 85 : 130,
                              height: landscape ? 100 : 110,
                              color: colors.text_color,
                            ),
                            Text(
                              '${names[1]}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: 'BebasNeue',
                                fontWeight: FontWeight.normal,
                                color: colors.text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => PageMotorView());
                    },
                    child: Card(
                      color: colors.backGround,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors.text_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              '${iconsPath[2]}',
                              width: landscape ? 85 : 130,
                              height: landscape ? 100 : 110,
                              color: colors.text_color,
                            ),
                            Text(
                              '${names[2]}',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BebasNeue',
                                color: colors.text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => PageDiagnosticView());
                    },
                    child: Card(
                      color: colors.backGround,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors.text_color,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              '${iconsPath[3]}',
                              width: landscape ? 85 : 130,
                              height: landscape ? 100 : 110,
                              color: colors.text_color,
                            ),
                            Text(
                              '${names[3]}',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'BebasNeue',
                                color: colors.text_color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => PageWarningView());
                    },
                    child: Container(
                      child: Card(
                        color: colors.backGround,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: colors.text_color,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Image.asset(
                                '${iconsPath[4]}',
                                width: landscape ? 85 : 130,
                                height: landscape ? 100 : 110,
                                color: colors.text_color,
                              ),
                              Text(
                                '${names[4]}',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'BebasNeue',
                                  color: colors.text_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
