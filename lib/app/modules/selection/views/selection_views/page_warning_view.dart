import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/monitor/controllers/monitor_controller.dart';

import '../../../../../styles/colors.dart';

class PageWarningView extends StatelessWidget {
  RxList<Map> warnings_data = [
    {
      'value': Get.find<MonitorController>().controller_power_tube_fault,
      'title': 'Controller Power Tube Fault',
      'code': 'P0001',
      'state': Get.find<MonitorController>().controller_power_tube_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_driving_power_fault,
      'title': 'Controller Driving Power Fault',
      'code': 'P0002',
      'state':
          Get.find<MonitorController>().controller_driving_power_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_over_current_fault,
      'title': 'Controller Over Current Fault',
      'code': 'P0003',
      'state':
          Get.find<MonitorController>().controller_over_current_fault_state,
    },
    {
      'value': Get.find<MonitorController>().controller_over_voltage_protection,
      'title': 'Controller Over Voltage Protection',
      'code': 'P0004',
      'state': Get.find<MonitorController>()
          .controller_over_voltage_protection_state,
    },
    {
      'value':
          Get.find<MonitorController>().controller_over_temprature_protection,
      'title': 'Controller Over Temperature Protection',
      'code': 'P0005',
      'state': Get.find<MonitorController>()
          .controller_over_temprature_protection_state,
    },
    {
      'value': Get.find<MonitorController>().motor_phase_wire_fault,
      'title': 'Motor Phase Wire Fault',
      'code': 'P0006',
      'state': Get.find<MonitorController>().motor_phase_wire_fault_state,
    },
    {
      'value': Get.find<MonitorController>().motor_hall_fault,
      'title': 'Motor Hall Fault',
      'code': 'P0007',
      'state': Get.find<MonitorController>().motor_hall_fault_state,
    },
    {
      'value': Get.find<MonitorController>().motor_over_temprature_protection,
      'title': 'Motor Over Temperature protection',
      'code': 'P0008',
      'state':
          Get.find<MonitorController>().motor_over_temprature_protection_state,
    },
    {
      'value':
          Get.find<MonitorController>().controller_under_voltage_protection,
      'title': 'Controller Under-Voltage protection',
      'code': 'P0009',
      'state': Get.find<MonitorController>()
          .controller_under_voltage_protection_state,
    },
    {
      'value': Get.find<MonitorController>().motor_stall_protection,
      'title': 'Motor Stall Protection',
      'code': 'P0010',
      'state': Get.find<MonitorController>().motor_stall_protection_state,
    },
    {
      'value': Get.find<MonitorController>().throttle_fault,
      'title': 'Throttle Fault',
      'code': 'P0011',
      'state': Get.find<MonitorController>().throttle_fault_state,
    },
    {
      'value': Get.find<MonitorController>().throttle_not_released,
      'title': 'Throttle not released when power-on',
      'code': 'P0012',
      'state': Get.find<MonitorController>().throttle_not_released_state,
    },
    {
      'value': Get.find<MonitorController>().bms_low_voltage,
      'title': 'BMS Low Voltage',
      'code': 'P0013',
      'state': Get.find<MonitorController>().bms_low_voltage_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_current_charge,
      'title': 'BMS Overcurrent Charge',
      'code': 'P0014',
      'state': Get.find<MonitorController>().bms_over_current_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_current_discharge,
      'title': 'BMS Over Current Discharge',
      'code': 'P0015',
      'state': Get.find<MonitorController>().bms_over_current_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_discharge,
      'title': 'BMS Over Temperature Discharge',
      'code': 'P0016',
      'state':
          Get.find<MonitorController>().bms_over_temprature_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_under_temprature_discharge,
      'title': 'BMS Under Temperature Discharge',
      'code': 'P0017',
      'state':
          Get.find<MonitorController>().bms_under_temprature_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_cell_open,
      'title': 'BMS Cell Open',
      'code': 'P0018',
      'state': Get.find<MonitorController>().bms_cell_open_state,
    },
    {
      'value': Get.find<MonitorController>().bms_short_discharge,
      'title': 'BMS Short Discharge',
      'code': 'P0019',
      'state': Get.find<MonitorController>().bms_short_discharge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_charge,
      'title': 'BMS Over Temperature Charge',
      'code': 'P0020',
      'state': Get.find<MonitorController>().bms_over_temprature_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_under_temprature_charge,
      'title': 'BMS Under Temperature Charge',
      'code': 'P0021',
      'state': Get.find<MonitorController>().bms_under_temprature_charge_state,
    },
    {
      'value': Get.find<MonitorController>().bms_over_temprature_mosfet,
      'title': 'BMS Over Temperature Mosfet',
      'code': 'P0022',
      'state': Get.find<MonitorController>().bms_over_temprature_mosfet_state,
    },
    {
      'value': Get.find<MonitorController>().bms_temprature_sensor_error,
      'title': 'BMS Temperature Sensor Error',
      'code': 'P0023',
      'state': Get.find<MonitorController>().bms_temprature_sensor_error_state,
    },
  ].obs;

  RxList<Map> non_warnings_data = [
    {
      'value': Get.find<MonitorController>().vcu_status,
      'title': 'VCU STATUS',
      'code': 'P0024',
    },
    {
      'value': Get.find<MonitorController>().bms_status,
      'title': 'BMS STATUS',
      'code': 'P0025',
    },
    {
      'value': Get.find<MonitorController>().bms_discharging,
      'title': 'BMS DISCHARGING',
      'code': 'P0026',
    },
    {
      'value': Get.find<MonitorController>().bms_charging,
      'title': 'BMS CHARGING',
      'code': 'P0027',
    },
    {
      'value': Get.find<MonitorController>().bms_charge_comleted,
      'title': 'BMS CHARGE COMPLETED',
      'code': 'P0028',
    },
  ].obs;

  error_handler_containers(RxInt x, String title, String code, RxBool state) {
    return state.value == true
        ? Obx(() => Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width / 2,
                        child: Text(title,
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 23,
                              fontFamily: 'BebasNeue',
                              fontWeight: FontWeight.bold,
                              color: x == 1 ? Colors.red : Colors.white,
                            )),
                      ),
                      Text(code,
                          style: TextStyle(
                            letterSpacing: 1.0,
                            fontFamily: 'BebasNeue',
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: x == 1 ? Colors.red : Colors.white,
                          )),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ))
        : SizedBox(
            height: 0,
          );
  }

  sorting_function() {
    warnings_data.sort((a, b) => b['value'].value.compareTo(a['value'].value));
  }

  status_color(title, RxInt int, code) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width / 2 + 10,
            child: Text(
              title,
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 20,
                fontFamily: 'BebasNeue',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: Get.width / 2 - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(code,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontFamily: 'BebasNeue',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                Obx(
                  () => Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: int.value == 0
                            ? Colors.white
                            : int.value == 1
                                ? Colors.yellow
                                : int.value == 2
                                    ? Colors.red
                                    : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: colors.backGround,
      ),
      backgroundColor: colors.backGround,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    utility().heading_selections('  Warning'),
                    Image.asset(
                      'assets/images/03.png',
                      width: 130,
                      height: 70,
                      color: colors.text_color,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    itemCount: non_warnings_data.length,
                    itemBuilder: ((context, index) => Obx(() => status_color(
                        non_warnings_data[index]['title'],
                        non_warnings_data[index]['value'],
                        non_warnings_data[index]['code'])))),
              ),
              SizedBox(
                height: Get.height / 2,
                child: ListView.builder(
                    itemCount: warnings_data.length,
                    itemBuilder: (context, index) {
                      Timer.periodic(
                          Duration(seconds: 1), (timer) => sorting_function());
                      return Obx(() => error_handler_containers(
                          warnings_data[index]['value'],
                          warnings_data[index]['title'],
                          warnings_data[index]['code'],
                          warnings_data[index]['state']));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
