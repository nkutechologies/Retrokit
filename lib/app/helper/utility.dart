import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../styles/colors.dart';
import '../modules/monitor/controllers/monitor_controller.dart';

class utility {
  final controller = Get.put(MonitorController());

  disconnected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(top: 12),
      margin: EdgeInsets.only(left: 50, right: 30),
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Row(
        children: [
          Text(
            textAlign: TextAlign.center,
            '    Bluetooth is turned off',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 12, 12),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.bluetooth_disabled,
              color: Colors.red,
            ),
          ),
        ],
      ));

  connected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(
        top: 7,
      ),
      margin: EdgeInsets.only(left: 80, right: 80),
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        'Connected',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 85, 255, 28),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));

  device_not_found_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(top: 12),
      margin: EdgeInsets.only(left: 50, right: 50),
      borderRadius: 200,
      duration: Duration(seconds: 3),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        textAlign: TextAlign.center,
        '  No device found! ',
        style: TextStyle(
            color: Color.fromARGB(255, 255, 227, 12),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ));
  ble_disconnected_snackbar() => Get.snackbar('', '',
      padding: EdgeInsets.only(top: 12),
      margin: EdgeInsets.only(left: 50, right: 50),
      borderRadius: 200,
      duration: Duration(seconds: 2),
      messageText: Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 0),
      ),
      titleText: Text(
        textAlign: TextAlign.center,
        '  Device Disconnected! ',
        style: TextStyle(
            color: Color.fromARGB(255, 255, 117, 12),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ));

  Text heading_selections(
    String text,
  ) {
    return Text(text,
        style: TextStyle(
          letterSpacing: 1.0,
          fontSize: 27,
          fontWeight: FontWeight.bold,
          fontFamily: 'BebasNeue',
          color: colors.text_color,
        ));
  }

  Text body_selections_const(
    String text,
    Color color,
  ) {
    return Text(text,
        style: TextStyle(
            letterSpacing: 0.0,
            fontSize: 19,
            fontFamily: 'BebasNeue',
            fontWeight: FontWeight.bold,
            color: color));
  }

  maximum_value_container(RxInt val, RxInt max, String symbol) {
    if (val >= max.value) {
      max.value = val.value;
    }
    return Obx(() => Container(
        width: 130,
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
        decoration: BoxDecoration(
          color: colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text('Max  ${max.value.toString()} $symbol',
              style: TextStyle(
                  letterSpacing: 0.0,
                  fontSize: 19,
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        )));
  }

  selection_container(
    Text text,
  ) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
      decoration: BoxDecoration(
        color: colors.red,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: text,
    );
  }
}
