import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/modules/selection/controllers/diagnosticController.dart';
import '../../../../../styles/colors.dart';

class PageDiagnosticView extends StatelessWidget {
  PageDiagnosticView({super.key});

  final diagnosticController controller = Get.put(diagnosticController());

  Text textWidget(String text, double fontSize, Color fontColor) {
    return Text(text,
        style: TextStyle(
          letterSpacing: 1.0,
          fontFamily: 'BebasNeue',
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          color: colors.text_color,
        ));
  }

  final List<Color> gradients = [
    Color(0xff02d39a),
    Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    List<int> _ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors.backGround,
      ),
      backgroundColor: colors.backGround,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            landscape
                ? Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          height: Get.height - 140,
                          padding: EdgeInsets.only(right: 10),
                          child: Obx(() => LineChart(
                                LineChartData(
                                  minX: controller.minX.value.abs(),
                                  maxX: controller.maxX.value,
                                  minY: 0,
                                  maxY: 100,
                                  gridData: FlGridData(show: true),
                                  titlesData: FlTitlesData(
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    topTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      dotData: FlDotData(show: false),
                                      spots: controller.flList,
                                      isCurved: true,
                                      barWidth: 2,
                                      show: controller.show_me.value,
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: gradients
                                              .map((e) => e.withOpacity(0.5))
                                              .toList(),
                                        ),
                                      ),
                                      gradient:
                                          LinearGradient(colors: gradients),
                                    ),
                                  ],

                                  // read about it in the LineChartData section
                                ),
                              ))),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 10, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [for (var i in _ints) Text(i.toString())],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        'Please rotate phone to view the chart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Icon(
                          Icons.screen_rotation_outlined,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
