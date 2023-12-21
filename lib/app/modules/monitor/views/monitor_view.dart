import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:retrokit/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/monitor_controller.dart';

class MonitorView extends GetView<MonitorController> {
  MonitorView({Key? key}) : super(key: key);

  final controller = Get.put(
    MonitorController(),
  );

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Text textWidget(String text, double fontSize, Color fontColor) {
      return Text(text,
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            fontFamily: 'BebasNeue',
            color: colors.text_color,
          ));
    }

    Text headingTextWidget(String text, double fontSize, Color fontColor) {
      return Text(text,
          style: TextStyle(
            letterSpacing: 1.0,
            fontSize: fontSize,
            fontFamily: 'BebasNeue',
            fontWeight: FontWeight.bold,
            color: colors.text_color,
          ));
    }

    List<String> headings = ['Max speed', 'Avg speed', 'Trip 1', 'Range'];

    List<RxInt> values = [
      controller.maxSpeed,
      controller.avgSpeed,
      controller.totalDistance,
      controller.range,
    ];
    List<String> units = const ['km/h', 'km/h', 'km', 'km'];

    containerWidget() {
      List<Container> _containers = [];
      for (var i = 0; i < headings.length; i++) {
        _containers.add(Container(
          width: landscape ? Get.width / 4 - 20 : Get.width / 2 - 15,
          padding: EdgeInsets.only(
            top: landscape ? 2 : 4,
            bottom: landscape ? 4 : 6,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(width: 1.5, color: colors.text_color),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 3, bottom: 5),
                  child: headingTextWidget(
                      headings[i], landscape ? 12 : 14, colors.text_color)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(values[i].value.toString(), landscape ? 24 : 27,
                      colors.text_color),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: textWidget(
                        units[i], landscape ? 11 : 14, colors.text_color),
                  ),
                ],
              )
            ],
          ),
        ));
      }
      return landscape
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _containers[0],
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: _containers[1],
                ),
                _containers[2],
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 3),
                  child: _containers[3],
                ),
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        _containers[0],
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _containers[1],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _containers[2],
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: _containers[3],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    }

    return Scaffold(
      backgroundColor: colors.backGround,
      body: Padding(
        padding: landscape
            ? EdgeInsets.only(left: 10, right: 10, top: 0)
            : EdgeInsets.all(0),
        child: SafeArea(
          child: Flex(
            direction: landscape ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 0, child: Obx(() => containerWidget())),
              Flexible(
                flex: 1,
                child: Stack(alignment: Alignment.center, children: [
                  Obx(() => Transform.scale(
                        scaleX:
                            controller.current_level.value.isNegative ? -1 : 1,
                        child: GFProgressBar(
                          percentage: controller.current_level.value >= 80
                              ? 1.0
                              : controller.current_level.value <= -40
                                  ? 1.0
                                  : controller.current_level.value.isNegative
                                      ? controller.current_level.value.abs() *
                                          2.5 /
                                          100
                                      : controller.current_level.value *
                                          1.25 /
                                          100,
                          progressHeadType: GFProgressHeadType.circular,
                          radius: landscape ? Get.height - 75 : Get.width - 60,
                          circleWidth: 11,
                          type: GFProgressType.circular,
                          backgroundColor: Colors.grey,
                          progressBarColor:
                              controller.current_level.value.isNegative
                                  ? Colors.blue
                                  : colors.green,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: landscape ? Get.width / 6 : Get.width / 3 - 10,
                      ),
                      Container(
                        child: Obx(
                          () => SizedBox(
                            width:
                                landscape ? Get.width / 6 : Get.width / 3 + 25,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        controller.tier1 == true
                                            ? '${controller.speedInternal.value}'
                                            : controller.tier2 == true
                                                ? '${controller.speedInternal.value}'
                                                : controller.tier3 == true
                                                    ? '${controller.speedInternal.value}'
                                                    : '${controller.speedInternal.value}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: 'BebasNeue',
                                          fontSize:
                                              controller.speedInternal.value >=
                                                      100
                                                  ? 110
                                                  : 170,
                                          letterSpacing: -3,
                                          color: colors.text_color,
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 35,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: RotatedBox(
                                              quarterTurns: 1,
                                              child: Image.asset(
                                                'assets/images/battery_internal.png',
                                                width: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(() => Container(
                                              padding:
                                                  EdgeInsets.only(right: 0),
                                              width: 70,
                                              height: 26,
                                              color: Colors.transparent,
                                              child: LinearProgressIndicator(
                                                  value: controller
                                                          .percentage_internal
                                                          .value /
                                                      100,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              16, 232, 27)),
                                                  backgroundColor:
                                                      Colors.transparent),
                                            )),
                                        Obx(() => Text(
                                              '${controller.percentage_internal}%',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:
                            landscape ? Get.width / 6 - 20 : Get.width / 3 - 15,
                        child: Text(
                          'Km/h',
                          style: TextStyle(
                            fontFamily: 'BebasNeue',
                            letterSpacing: 0,
                            fontSize: 27,
                            color: colors.text_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              Obx(() => Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: Flex(
                        crossAxisAlignment: landscape
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        direction: landscape ? Axis.vertical : Axis.horizontal,
                        children: [
                          landscape
                              ? Obx(() => Text(
                                    controller.driving_state == 0
                                        ? 'OFF'
                                        : controller.driving_state == 1
                                            ? 'RUN'
                                            : controller.driving_state == 2
                                                ? 'READY'
                                                : 'OFF',
                                    style: TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontSize: 32,
                                        color: controller.driving_state == 0
                                            ? colors.text_color
                                            : controller.driving_state == 1
                                                ? Colors.yellow
                                                : controller.driving_state == 2
                                                    ? Colors.green
                                                    : colors.text_color),
                                  ))
                              : Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: landscape ? 0 : 50,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      final Uri _url =
                                          Uri.parse('https://retrokit.it/');
                                      launchUrl(_url);
                                    },
                                    child: Image.asset(
                                      'assets/images/retrokit_golden.png',
                                      width: 100,
                                      color: Color.fromARGB(
                                        255,
                                        242,
                                        201,
                                        25,
                                      ),
                                    ),
                                  ),
                                ),
                          Flex(
                            direction: Axis.vertical,
                            children: [
                              Container(
                                width: 110,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2,
                                      color: controller.eco.value == true
                                          ? colors.text_color
                                          : Colors.transparent),
                                ),
                                child: Center(
                                    child: textWidget(landscape ? 'E' : 'ECO',
                                        25, colors.text_color)),
                              ),
                              Container(
                                width: landscape ? 50 : 110,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2,
                                      color: controller.drive.value == true
                                          ? colors.text_color
                                          : Colors.transparent),
                                ),
                                child: Center(
                                  child: textWidget(landscape ? 'D' : 'DRIVE',
                                      25, colors.text_color),
                                ),
                              ),
                              Container(
                                width: 110,
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      width: 2,
                                      color: controller.sport.value == true
                                          ? colors.text_color
                                          : Colors.transparent),
                                ),
                                child: Center(
                                  child: textWidget(landscape ? 'S' : 'Sport',
                                      25, colors.text_color),
                                ),
                              ),
                            ],
                          ),
                          landscape
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    top: landscape ? 0 : 50,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      final Uri _url =
                                          Uri.parse('https://retrokit.it/');
                                      launchUrl(_url);
                                    },
                                    child: Image.asset(
                                      'assets/images/retrokit_golden.png',
                                      width: 100,
                                      color: Color.fromARGB(
                                        255,
                                        242,
                                        201,
                                        25,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: landscape ? 100 : Get.width / 3 - 50,
                                  child: Obx(() => Text(
                                        controller.driving_state == 0
                                            ? 'OFF'
                                            : controller.driving_state == 1
                                                ? 'RUN'
                                                : controller.driving_state == 2
                                                    ? 'READY'
                                                    : 'OFF',
                                        style: TextStyle(
                                            fontFamily: 'BebasNeue',
                                            fontSize: 32,
                                            color: controller.driving_state == 0
                                                ? colors.text_color
                                                : controller.driving_state == 1
                                                    ? Colors.yellow
                                                    : controller.driving_state ==
                                                            2
                                                        ? Colors.green
                                                        : colors.text_color),
                                      )),
                                )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
