import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageBatteryView extends StatelessWidget {
  const PageBatteryView({super.key});

  @override
  Widget build(BuildContext context) {
    final landscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors.backGround,
      ),
      backgroundColor: colors.backGround,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
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
                      utility().heading_selections('  Battery'),
                      Image.asset(
                        'assets/images/01.png',
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
                        utility().heading_selections('SOC'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().percentage_internal} %'),
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
                            'State of Charge', colors.dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().percentage_internal,
                            Get.find<MonitorController>().battery_soc_max,
                            '')),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        utility().heading_selections('SOH'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().battery_soh} %'),
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
                            'State of Health', colors.dark_grey),
                        SizedBox(),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('T'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().battery_temprature} °C'),
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
                            Get.find<MonitorController>().battery_temprature,
                            Get.find<MonitorController>()
                                .battery_temprature_max,
                            '')),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: landscape ? 0 : 15, bottom: landscape ? 0 : 15),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility().heading_selections('V'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().battery_voltage} V'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility()
                            .body_selections_const('Voltage', colors.dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().battery_voltage,
                            Get.find<MonitorController>().battery_voltage_max,
                            '')),
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
                        utility().heading_selections('I'),
                        Obx(
                          () => utility().heading_selections(
                              '${Get.find<MonitorController>().battery_current} A'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: landscape ? 0 : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        utility()
                            .body_selections_const('Current', colors.dark_grey),
                        Obx(() => utility().maximum_value_container(
                            Get.find<MonitorController>().battery_current,
                            Get.find<MonitorController>().battery_current_max,
                            '')),
                      ],
                    ),
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
