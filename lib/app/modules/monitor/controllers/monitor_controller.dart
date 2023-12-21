import 'dart:async';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:retrokit/app/helper/local_storage_services.dart';
import 'package:retrokit/app/helper/utility.dart';
import 'package:retrokit/app/modules/selection/controllers/diagnosticController.dart';
import 'package:retrokit/styles/colors.dart';

class MonitorController extends GetxController {
  Uuid _UART_UUID = Uuid.parse("4fafc201-1fb5-459e-8fcc-c5c9c331914b");

  //Speed internal on the circle  from BLE
  Uuid _CHARACTERISTIC_UUID_SPEED_INTERNAL =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a8");
  //Max Speed  From BLE
  Uuid _CHARACTERISTIC_UUID_MAX_SPEED =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26da");
//Avg speed  From BLE
  Uuid _CHARACTERISTIC_UUID_AVG_SPEED =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d9");
//Tot distance  from BLEs
  Uuid _CHARACTERISTIC_UUID_TOT_DISTANCE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26aa");
//Range  from BLE
  Uuid _CHARACTERISTIC_UUID_RANGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ac");
//ECO,  DRIVE, SPORT  from BLE
  Uuid _CHARACTERISTIC_UUID_DRIVING_RANGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ad");
//READY, RUN, OFF
  Uuid _CHARACTERISTIC_UUID_DRIVING_STATE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26a9");
//Percentage internal to the circle  From BLE & Battery state of charge SOC
  Uuid _CHARACTERISTIC_UUID_PERCENTAGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ae");
//Charging discharging current & Controller Current
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_CURRENT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26dc");
//Battery state of health SOH
  Uuid _CHARACTERISTIC_UUID_BATTERY_SOH =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b0");
//Battery Temprature
  Uuid _CHARACTERISTIC_UUID_BATTERY_TEMPRATURE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b1");
//Battery Voltage
  Uuid _CHARACTERISTIC_UUID_BATTERY_VOLTAGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b2");
//Battery Current
  Uuid _CHARACTERISTIC_UUID_BATTERY_CURRENT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b3");
//Controller Voltage
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b4");
//Controller Temprature
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b6");
//Controller Temprature
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_THROTTLE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d3");
//Controller MAPPING
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_MAPPING =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ad");
//Motor RPM
  Uuid _CHARACTERISTIC_UUID_MOTOR_RPM =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b5");
//Motor Temprature
  Uuid _CHARACTERISTIC_UUID_MOTOR_TEMPRATURE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b7");
//Motor ODO
  Uuid _CHARACTERISTIC_UUID_MOTOR_ODO =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ab");
//Motor Tiers
  Uuid _CHARACTERISTIC_UUID_MOTOR_TIERS =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d0");
//MOTOR GEAR
  Uuid _CHARACTERISTIC_UUID_MOTOR_GEARS =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d1");

//<---ERRORS-PAGES--->

//CONTROLLER POWER TUBE FAULT
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26b8");
//CONTROLLER DRIVING POWER FAULT
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ba");
//CONTROLLER OVER CURRENT FAULT
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26bb");
// CONTROLLER OVER VOLTAGE PROTECTION
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26bc");
// CONTROLLER OVER TEMPRATURE PROTECTION
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26bd");
// MOTOR PHASE WIRE FAULT
  Uuid _CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26be");
// MOTOR HALL FAULT
  Uuid _CHARACTERISTIC_UUID_MOTOR_HALL_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26bf");
//MOTOR OVER TEMPRATURE PROTECTION
  Uuid _CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c0");
//CONTROLLER UNDER-VOLTAGE PROTECTION
  Uuid _CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c1");
//MOTOR STALL PROTECTION
  Uuid _CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c2");
// THROTTLE FAULT
  Uuid _CHARACTERISTIC_UUID_THROTTLE_FAULT =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c3");
//THROTTLE NOT RELEASED WHEN POWER-ON
  Uuid _CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c4");
//BMS LOW VOLTAGE
  Uuid _CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c5");
//BMS OVER CURRENT CHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c6");
//BMS OVER CURRENT DISCHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c7");
//BMS OVER TEMPRATURE DISCHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c8");
//BMS UNDER TEMPRATURE DISCHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26c9");
//BMS CELL OPEN
  Uuid _CHARACTERISTIC_UUID_BMS_CELL_OPEN =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ca");
//BMS SHORT DISCHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26cb");
//BMS OVER TEMPRATURE CHARGE
  Uuid _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26cc");

  Uuid _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26cd");
//BMS OVER TEMPRATURE MOSFET
  Uuid _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26ce");
//BMS TEMPRATURE SENSOR ERROR
  Uuid _CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26cf");
//BMS Status Error
  Uuid _CHARACTERISTIC_UUID_BMS_STATUS =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d5");
//VCU Status Error
  Uuid _CHARACTERISTIC_UUID_VCU_STATUS =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d4");
  //VCU Status Error
  Uuid _CHARACTERISTIC_UUID_BMS_DISCHARGING =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d6");
  Uuid _CHARACTERISTIC_UUID_BMS_CHARGING =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d7");
  Uuid _CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED =
      Uuid.parse("beb5483e-36e1-4688-b7f5-ea07361b26d8");

  final flutterReactiveBle = FlutterReactiveBle();
  List<DiscoveredDevice> foundBleUARTDevices = [];

  late StreamSubscription<DiscoveredDevice> _scanStream;
  late Stream<ConnectionStateUpdate> _currentConnectionStream;
  late StreamSubscription<ConnectionStateUpdate> _connection;
  //Qualified characteristic according to each value
  late QualifiedCharacteristic _txCharacteristic;
  late QualifiedCharacteristic _qulaified_CHARACTERISTIC_UUID_SPEED_INTERNAL;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_MAX_SPEED;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_AVG_SPEED;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_TOT_DISTANCE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_RANGE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_MODE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_STATE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_PERCENTAGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_CURRENT;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_SOH;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_TEMPRATURE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_VOLTAGE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_CURRENT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_MAPPING;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_RPM;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_TEMPRATURE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_ODO;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_THROTTLE;

  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_HALL_FAULT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_THROTTLE_FAULT;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BMS_CELL_OPEN;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BMS_STATUS;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_VCU_STATUS;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BMS_DISCHARGING;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGING;
  late QualifiedCharacteristic
      _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED;

  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_GEAR;
  late QualifiedCharacteristic _QUALIFIED_CHARACTERISTIC_WHEEL;

  //Stream listening data from esp32
  late Stream<List<int>> receivedData_Stream;
  late Stream<List<int>> _speedInternal_Stream;
  late Stream<List<int>> _maxSpeed_Stream;
  late Stream<List<int>> _avgSpeed_Stream;
  late Stream<List<int>> _totalDistance_Stream;
  late Stream<List<int>> _range_Stream;
  late Stream<List<int>> _driving_mode_Stream;
  late Stream<List<int>> _driving_mode_State_stream;
  late Stream<List<int>> _percentage_internal_Stream;
  late Stream<List<int>> _current_level_Stream;
//PAGE_BATTERY_FROM_SELECTION
  late Stream<List<int>> _battery_state_of_health_stream;
  late Stream<List<int>> _battery_temprature_stream;
  late Stream<List<int>> _battery_voltage_stream;
  late Stream<List<int>> _battery_current_stream;
//CONTROLLER_FROM_SELECTION
  late Stream<List<int>> _controller_temprature_stream;
  late Stream<List<int>> _controller_voltage_stream;
  late Stream<List<int>> _controller_mapping_stream;
  late Stream<List<int>> _controller_throttle_stream;

  //MOTOR_FROM_SELECTION
  late Stream<List<int>> _motor_revol_stream;
  late Stream<List<int>> _motor_temprature_stream;
  late Stream<List<int>> _motor_odo_stream;
  late Stream<List<int>> _motor_gear_stream;

  //ERROR PAGE STREAMS
  late Stream<List<int>> controller_power_tube_fault_stream;
  late Stream<List<int>> controller_driving_power_fault_stream;
  late Stream<List<int>> controller_over_current_fault_stream;
  late Stream<List<int>> controller_over_voltage_protection_stream;
  late Stream<List<int>> controller_over_temprature_protection_stream;
  late Stream<List<int>> motor_phase_wire_fault_stream;
  late Stream<List<int>> motor_hall_fault_stream;
  late Stream<List<int>> motor_over_temprature_protection_stream;
  late Stream<List<int>> controller_under_voltage_protection_stream;
  late Stream<List<int>> motor_stall_protection_stream;
  late Stream<List<int>> throttle_fault_stream;
  late Stream<List<int>> throttle_not_released_stream;
  late Stream<List<int>> bms_low_voltage_stream;
  late Stream<List<int>> bms_over_current_charge_stream;
  late Stream<List<int>> bms_over_current_discharge_stream;
  late Stream<List<int>> bms_over_temprature_discharge_stream;
  late Stream<List<int>> bms_cell_open_stream;
  late Stream<List<int>> bms_short_discharge_stream;
  late Stream<List<int>> bms_over_temprature_charge_stream;
  late Stream<List<int>> bms_under_temprature_charge_stream;
  late Stream<List<int>> bms_under_temprature_discharge_stream;
  late Stream<List<int>> warnings_stream;
  late Stream<List<int>> bms_over_temprature_mosfet_stream;
  late Stream<List<int>> bms_temprature_sensor_error_stream;
  late Stream<List<int>> bms_status_stream;
  late Stream<List<int>> vcu_status_stream;
  late Stream<List<int>> bms_discharging_stream;
  late Stream<List<int>> bms_charging_stream;
  late Stream<List<int>> bms_charge_completed_stream;

//SCANNING FROM BLE
  bool _scanning = false;
//Values from ESP
  RxBool connected = false.obs;
  bool displaying_selectDevice = false;
  bool blueON = false;
  bool disconnected_count = false;
  String _logTexts = "";
//HOME PAGE READ
  RxInt receivedData = 0.obs;
  RxInt speedInternal = 0.obs;
  RxInt maxSpeed = 0.obs;
  RxInt avgSpeed = 0.obs;
  RxInt totalDistance = 0.obs;
  RxInt range = 0.obs;
  RxInt driving_state = 0.obs;
  RxInt driving_mode = 0.obs;

  RxInt percentage_internal = 0.obs;
  RxInt current_level = 0.obs;
//BATTERY PAGE 0
  RxInt battery_soh = 0.obs;
  RxInt battery_temprature = 0.obs;
  RxInt battery_voltage = 0.obs;
  RxInt battery_current = 0.obs;
//PAGE READ
  RxInt controller_temprature = 0.obs;
  RxInt controller_voltage = 0.obs;
  RxInt controller_throttle = 0.obs;

  RxString controller_map = ''.obs;
//MOTOR PAGE READ
  RxInt motor_rpm = 0.obs;
  RxInt motor_temprature = 0.obs;
  RxInt motor_odo = 0.obs;
  RxString motor_tier = ''.obs;
//BATTERY MAX VALUES
  RxInt battery_soc_max = 0.obs;
  RxInt battery_soh_max = 0.obs;
  RxInt battery_temprature_max = 0.obs;
  RxInt battery_voltage_max = 0.obs;
  RxInt battery_current_max = 0.obs;
//CONTROLLER MAX VALUES
  RxInt controller_current_max = 0.obs;
  RxInt controller_temprature_max = 0.obs;
  RxInt controller_voltage_max = 0.obs;
  RxInt controller_throttle_max = 0.obs;

//MOTOR MAX VALUES
  RxInt motor_rpm_max = 0.obs;
  RxInt motor_temprature_max = 0.obs;
  RxInt motor_odo_max = 0.obs;

//ERROR PAGE
  RxInt controller_power_tube_fault = 2.obs;
  RxInt controller_driving_power_fault = 2.obs;
  RxInt controller_over_current_fault = 2.obs;
  RxInt controller_over_voltage_protection = 0.obs;
  RxInt controller_over_temprature_protection = 0.obs;
  RxInt motor_phase_wire_fault = 0.obs;
  RxInt motor_hall_fault = 0.obs;
  RxInt motor_over_temprature_protection = 0.obs;
  RxInt controller_under_voltage_protection = 0.obs;
  RxInt motor_stall_protection = 0.obs;
  RxInt throttle_fault = 0.obs;
  RxInt throttle_not_released = 0.obs;
  RxInt bms_low_voltage = 0.obs;
  RxInt bms_over_current_charge = 0.obs;
  RxInt bms_over_current_discharge = 0.obs;
  RxInt bms_over_temprature_discharge = 0.obs;
  RxInt bms_cell_open = 0.obs;
  RxInt bms_short_discharge = 0.obs;
  RxInt bms_over_temprature_charge = 0.obs;
  RxInt bms_under_temprature_charge = 0.obs;
  RxInt bms_under_temprature_discharge = 0.obs;
  RxInt bms_over_temprature_mosfet = 0.obs;
  RxInt bms_temprature_sensor_error = 0.obs;

  RxBool controller_power_tube_fault_state = false.obs;
  RxBool controller_driving_power_fault_state = false.obs;
  RxBool controller_over_current_fault_state = false.obs;
  RxBool controller_over_voltage_protection_state = false.obs;
  RxBool controller_over_temprature_protection_state = false.obs;
  RxBool motor_phase_wire_fault_state = false.obs;
  RxBool motor_hall_fault_state = false.obs;
  RxBool motor_over_temprature_protection_state = false.obs;
  RxBool controller_under_voltage_protection_state = false.obs;
  RxBool motor_stall_protection_state = false.obs;
  RxBool throttle_fault_state = false.obs;
  RxBool throttle_not_released_state = false.obs;
  RxBool bms_low_voltage_state = false.obs;
  RxBool bms_over_current_charge_state = false.obs;
  RxBool bms_over_current_discharge_state = false.obs;
  RxBool bms_over_temprature_discharge_state = false.obs;
  RxBool bms_cell_open_state = false.obs;
  RxBool bms_short_discharge_state = false.obs;
  RxBool bms_over_temprature_charge_state = false.obs;
  RxBool bms_under_temprature_charge_state = false.obs;
  RxBool bms_under_temprature_discharge_state = false.obs;
  RxBool bms_over_temprature_mosfet_state = false.obs;
  RxBool bms_temprature_sensor_error_state = false.obs;
  RxInt bms_status = 10.obs;
  RxInt motor_gear = 0.obs;

  RxInt vcu_status = 10.obs;
  RxInt bms_discharging = 10.obs;
  RxInt bms_charging = 10.obs;
  RxInt bms_charge_comleted = 10.obs;
  bool graph_time = true;
  void _sendData(QualifiedCharacteristic CharacteristicIds, values) async {
    await flutterReactiveBle.writeCharacteristicWithoutResponse(
        CharacteristicIds,
        value: values.toString().codeUnits);
  }

  // WHEN DATA IS RECIEVED FROM ESP

  void onReceived_SpeedInternal(List<int> data) {
    speedInternal.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_maxSpeed(List<int> data) {
    maxSpeed.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_avgSpeed(List<int> data) {
    avgSpeed.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_totalDistance(List<int> data) {
    totalDistance.value = int.parse("${String.fromCharCodes(data)}") * 10;
  }

  void onReceived_range(List<int> data) {
    range.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_percentage_internal(List<int> data) {
    if (graph_time == true) {
      Get.put(diagnosticController());
      Get.find<diagnosticController>().dateTimeInitial =
          DateTime.now().millisecondsSinceEpoch;
    }
    Get.find<diagnosticController>().addSpotX_Y();
    graph_time = false;
    percentage_internal.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_current_level(List<int> data) {
    current_level.value = int.parse("${String.fromCharCodes(data)}") - 40;
  }

  void onReceived_battery_soh(List<int> data) {
    battery_soh.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_temprature(List<int> data) {
    battery_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_voltage(List<int> data) {
    battery_voltage.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_battery_current(List<int> data) {
    battery_current.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_voltage(List<int> data) {
    controller_voltage.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_temprature(List<int> data) {
    controller_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_controller_map(List<int> data) {
    controller_map.value = "${String.fromCharCodes(data)}";
  }

  void onReceived_controller_throttle(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    double y = x / 10;
    controller_throttle.value = y.toInt();
  }

  void onReceived_motor_revol(List<int> data) {
    motor_rpm.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_motor_temprature(List<int> data) {
    motor_temprature.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_motor_odo(List<int> data) {
    motor_odo.value = int.parse("${String.fromCharCodes(data)}");
  }

  void onReceived_motor_gear(List<int> data) {
    motor_gear.value = int.parse("${String.fromCharCodes(data)}");
    print(motor_gear);
  }

  void onReceived_controller_power_tube_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_power_tube_fault_state.value = true;
    }
    if (controller_power_tube_fault_state.value == true) {
      controller_power_tube_fault.value = x;
    }
  }

  void onReceived_controller_driving_power_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_driving_power_fault_state.value = true;
    }
    if (controller_driving_power_fault_state.value == true) {
      controller_driving_power_fault.value = x;
    }
  }

  void onReceived_controller_over_current_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_over_current_fault_state.value = true;
    }
    if (controller_over_current_fault_state.value == true) {
      controller_over_current_fault.value = x;
    }
  }

  void onReceived_controller_over_voltage_protection(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_over_voltage_protection_state.value = true;
    }
    if (controller_over_voltage_protection_state.value == true) {
      controller_over_voltage_protection.value = x;
    }
  }

  void onReceived_controller_over_temprature_protection(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_over_temprature_protection_state.value = true;
    }
    if (controller_over_temprature_protection_state.value == true) {
      controller_over_temprature_protection.value = x;
    }
  }

  void onReceived_motor_phase_wire_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      motor_phase_wire_fault_state.value = true;
    }
    if (motor_phase_wire_fault_state.value == true) {
      motor_phase_wire_fault.value = x;
    }
  }

  void onReceived_motor_hall_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      motor_hall_fault_state.value = true;
    }
    if (motor_hall_fault_state.value == true) {
      motor_hall_fault.value = x;
    }
  }

  void onReceived_motor_over_temprature_protection(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      motor_over_temprature_protection_state.value = true;
    }
    if (motor_over_temprature_protection_state.value == true) {
      motor_over_temprature_protection.value = x;
    }
  }

  void onReceived_controller_under_voltage_protection(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_under_voltage_protection_state.value = true;
    }
    if (controller_under_voltage_protection_state.value == true) {
      controller_under_voltage_protection.value = x;
    }
  }

  void onReceived_motor_stall_protection(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      motor_stall_protection_state.value = true;
    }
    if (motor_stall_protection_state.value == true) {
      motor_stall_protection.value = x;
    }
  }

  void onReceived_throttle_fault(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    print(x);
    if (x == 1) {
      throttle_fault_state.value = true;
    }
    if (throttle_fault_state.value == true) {
      throttle_fault.value = x;
    }
  }

  void onReceived_throttle_not_released(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      throttle_not_released_state.value = true;
    }
    if (throttle_not_released_state.value == true) {
      throttle_not_released.value = x;
    }
  }

  void onReceived_bms_low_voltage(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_low_voltage_state.value = true;
    }
    if (bms_low_voltage_state.value == true) {
      bms_low_voltage.value = x;
    }
  }

  void onReceived_bms_over_current_charge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_over_current_charge_state.value = true;
    }
    if (bms_over_current_charge_state.value == true) {
      bms_over_current_charge.value = x;
    }
  }

  void onReceived_bms_over_current_discharge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_over_current_discharge_state.value = true;
    }
    if (bms_over_current_discharge_state.value == true) {
      bms_over_current_discharge.value = x;
    }
  }

  void onReceived_bms_over_temprature_discharge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_over_temprature_discharge_state.value = true;
    }
    if (bms_over_temprature_discharge_state.value == true) {
      bms_over_temprature_discharge.value = x;
    }
  }

  void onReceived_bms_under_temprature_discharge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_under_temprature_discharge_state.value = true;
    }
    if (bms_under_temprature_discharge_state.value == true) {
      bms_under_temprature_discharge.value = x;
    }
  }

  void onReceived_bms_cell_open(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_cell_open_state.value = true;
    }
    if (bms_cell_open_state.value == true) {
      bms_cell_open.value = x;
    }
  }

  void onReceived_bms_short_discharge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_short_discharge_state.value = true;
    }
    if (bms_short_discharge_state.value == true) {
      bms_short_discharge.value = x;
    }
  }

  void onReceived_bms_over_temprature_charge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      controller_power_tube_fault_state.value = true;
    }
    if (controller_power_tube_fault_state.value == true) {
      controller_power_tube_fault.value = x;
    }
  }

  void onReceived_bms_under_temprature_charge(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_under_temprature_charge_state.value = true;
    }
    if (bms_under_temprature_charge_state.value == true) {
      bms_under_temprature_charge.value = x;
    }
  }

  void onReceived_bms_over_temprature_mosfet(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_over_temprature_mosfet_state.value = true;
    }
    if (bms_over_temprature_mosfet_state.value == true) {
      bms_over_temprature_mosfet.value = x;
    }
  }

  void onReceived_bms_temprature_sensor_error(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    if (x == 1) {
      bms_temprature_sensor_error_state.value = true;
    }
    if (bms_temprature_sensor_error_state.value == true) {
      bms_temprature_sensor_error.value = x;
    }
  }

  void onReceived_bms_status(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    print(x);
    bms_status.value = x;
  }

  void onReceived_vcu_status(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    vcu_status.value = x;
  }

  void onReceived_bms_charging(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");

    bms_charging.value = x;
  }

  void onReceived_bms_discharging(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    bms_discharging.value = x;
  }

  void onReceived_bms_charge_completed(List<int> data) {
    int x = int.parse("${String.fromCharCodes(data)}");
    bms_charge_comleted.value = x;
  }

  void onReceived_driving_mode(List<int> data) {
    driving_mode.value = int.parse("${String.fromCharCodes(data)}");

    driving_mode.value == 0
        ? {
            eco.value = true,
            drive.value = false,
            sport.value = false,
          }
        : driving_mode.value == 1
            ? {
                eco.value = false,
                drive.value = true,
                sport.value = false,
              }
            : driving_mode.value == 2
                ? {
                    eco.value = false,
                    drive.value = false,
                    sport.value = true,
                  }
                : {};
  }

  void onReceived_driving_state(List<int> data) {
    driving_state.value = int.parse("${String.fromCharCodes(data)}");
  }

  void _stopScan() async {
    await _scanStream.cancel();
    _scanning = false;
  }

  permission_internal() async {
    await Nearby().askLocationPermission();
    Nearby().askBluetoothPermission();
  }

  void startScan() async {
    update();
    if (connected == false && blueON == true) {
      foundBleUARTDevices = [];

      _scanning = true;
      update();
      _scanStream = await flutterReactiveBle
          .scanForDevices(withServices: [_UART_UUID]).listen(
        (device) {
          if (foundBleUARTDevices.every((element) => element.id != device.id)) {
            foundBleUARTDevices.add(device);
            update();
            selectDevices();
            _stopScan();
          }
        },
        onError: (Object error) {
          _logTexts = "${_logTexts}ERROR while scanning:$error \n";
        },
      );
    }
    await Future.delayed(Duration(seconds: 3));
    if (foundBleUARTDevices.length == 0) {
      utility().device_not_found_snackbar();
    }
  }

  onConnectDevice(int index) async {
    _currentConnectionStream =
        await flutterReactiveBle.connectToAdvertisingDevice(
      id: foundBleUARTDevices[index].id,
      prescanDuration: Duration(seconds: 4),
      withServices: [
        _UART_UUID,
        _CHARACTERISTIC_UUID_SPEED_INTERNAL,
        _CHARACTERISTIC_UUID_MAX_SPEED,
        _CHARACTERISTIC_UUID_AVG_SPEED,
        _CHARACTERISTIC_UUID_TOT_DISTANCE,
        _CHARACTERISTIC_UUID_RANGE,
        _CHARACTERISTIC_UUID_DRIVING_RANGE,
        _CHARACTERISTIC_UUID_PERCENTAGE,
        _CHARACTERISTIC_UUID_CONTROLLER_CURRENT,
        _CHARACTERISTIC_UUID_BATTERY_SOH,
        _CHARACTERISTIC_UUID_BATTERY_TEMPRATURE,
        _CHARACTERISTIC_UUID_BATTERY_VOLTAGE,
        _CHARACTERISTIC_UUID_BATTERY_CURRENT,
        _CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE,
        _CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE,
        _CHARACTERISTIC_UUID_CONTROLLER_MAPPING,
        _CHARACTERISTIC_UUID_MOTOR_RPM,
        _CHARACTERISTIC_UUID_MOTOR_TEMPRATURE,
        _CHARACTERISTIC_UUID_MOTOR_ODO,
        _CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT,
        _CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT,
        _CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT,
        _CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION,
        _CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION,
        _CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT,
        _CHARACTERISTIC_UUID_MOTOR_HALL_FAULT,
        _CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION,
        _CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION,
        _CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION,
        _CHARACTERISTIC_UUID_THROTTLE_FAULT,
        _CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED,
        _CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE,
        _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE,
        _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE,
        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE,
        _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE,
        _CHARACTERISTIC_UUID_BMS_CELL_OPEN,
        _CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE,
        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE,
        _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE,
        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET,
        _CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR,
        _CHARACTERISTIC_UUID_DRIVING_STATE,
        _CHARACTERISTIC_UUID_MOTOR_GEARS,
        _CHARACTERISTIC_UUID_MOTOR_TIERS,
        _CHARACTERISTIC_UUID_CONTROLLER_THROTTLE,
        _CHARACTERISTIC_UUID_BMS_STATUS,
        _CHARACTERISTIC_UUID_VCU_STATUS,
        _CHARACTERISTIC_UUID_BMS_CHARGING,
        _CHARACTERISTIC_UUID_BMS_DISCHARGING,
        _CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED,
      ],
    );
    _logTexts = "";
    _connection = await _currentConnectionStream.listen((event) {
      var id = event.deviceId.toString();
      switch (event.connectionState) {
        case DeviceConnectionState.connecting:
          {
            _logTexts = "${_logTexts}Connecting to $id\n";
            break;
          }
        case DeviceConnectionState.connected:
          {
            flutterReactiveBle.clearGattCache(foundBleUARTDevices[0].id);

            utility().connected_snackbar();
            connected.value = true;
            receivedData.value = 0;
            speedInternal.value = 0;
            maxSpeed.value = 0;
            avgSpeed.value = 0;
            totalDistance.value = 0;
            range.value = 0;
            driving_mode.value = 0;
            percentage_internal.value = 0;
            current_level.value = 0;
            battery_temprature.value = 0;
            battery_voltage.value = 0;
            battery_current.value = 0;
            controller_temprature.value = 0;
            controller_voltage.value = 0;
            motor_temprature.value = 0;
            motor_odo.value = 0;
            controller_power_tube_fault.value = 0;
            controller_driving_power_fault.value = 0;
            controller_over_current_fault.value = 0;
            controller_over_voltage_protection.value = 0;
            controller_over_temprature_protection.value = 0;
            motor_phase_wire_fault.value = 0;
            motor_hall_fault.value = 0;
            motor_over_temprature_protection.value = 0;
            controller_under_voltage_protection.value = 0;
            motor_stall_protection.value = 0;
            throttle_fault.value = 0;
            throttle_not_released.value = 0;
            bms_low_voltage.value = 0;
            bms_over_current_charge.value = 0;
            bms_over_current_discharge.value = 0;
            bms_over_temprature_discharge.value = 0;
            bms_cell_open.value = 0;
            bms_short_discharge.value = 0;
            bms_over_temprature_charge.value = 0;
            bms_under_temprature_charge.value = 0;
            bms_under_temprature_discharge.value = 0;
            bms_over_temprature_mosfet.value = 0;
            bms_temprature_sensor_error.value = 0;
            bms_status.value = 10;
            vcu_status.value = 10;
            bms_charging.value = 10;
            bms_discharging.value = 10;
            bms_charge_comleted.value = 10;

            _logTexts = "${_logTexts}Connected to $id\n";

            _txCharacteristic = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_DRIVING_RANGE,
                deviceId: event.deviceId);
            _qulaified_CHARACTERISTIC_UUID_SPEED_INTERNAL =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_SPEED_INTERNAL,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MAX_SPEED = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_MAX_SPEED,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_AVG_SPEED = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_AVG_SPEED,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_TOT_DISTANCE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_TOT_DISTANCE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_RANGE = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_RANGE,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_MODE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_DRIVING_RANGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_STATE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_DRIVING_STATE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_PERCENTAGE = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_PERCENTAGE,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_CURRENT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_CONTROLLER_CURRENT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_SOH =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BATTERY_SOH,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_TEMPRATURE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BATTERY_TEMPRATURE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_VOLTAGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BATTERY_VOLTAGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_CURRENT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BATTERY_CURRENT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE,
                    deviceId: event.deviceId);

            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_THROTTLE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_CONTROLLER_THROTTLE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_MAPPING =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_CONTROLLER_MAPPING,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_RPM = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_MOTOR_RPM,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_TEMPRATURE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_MOTOR_TEMPRATURE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_ODO = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_MOTOR_ODO,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_HALL_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_MOTOR_HALL_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_THROTTLE_FAULT =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_THROTTLE_FAULT,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_CELL_OPEN =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_CELL_OPEN,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId:
                        _CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_WHEEL = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_MOTOR_TIERS,
                deviceId: event.deviceId);
            ////////////////////
            _QUALIFIED_CHARACTERISTIC_GEAR = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_MOTOR_TIERS,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_STATUS = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_BMS_STATUS,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_VCU_STATUS = QualifiedCharacteristic(
                serviceId: _UART_UUID,
                characteristicId: _CHARACTERISTIC_UUID_VCU_STATUS,
                deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGING =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_CHARGING,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_DISCHARGING =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_DISCHARGING,
                    deviceId: event.deviceId);
            _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED =
                QualifiedCharacteristic(
                    serviceId: _UART_UUID,
                    characteristicId: _CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED,
                    deviceId: event.deviceId);

            receivedData_Stream =
                flutterReactiveBle.subscribeToCharacteristic(_txCharacteristic);
            receivedData_Stream.listen((data) {}, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _speedInternal_Stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _qulaified_CHARACTERISTIC_UUID_SPEED_INTERNAL);
            _speedInternal_Stream.listen((data) {
              onReceived_SpeedInternal(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _maxSpeed_Stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_MAX_SPEED);
            _maxSpeed_Stream.listen((data) {
              onReceived_maxSpeed(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _avgSpeed_Stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_AVG_SPEED);
            _avgSpeed_Stream.listen((data) {
              onReceived_avgSpeed(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _totalDistance_Stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_TOT_DISTANCE);
            _totalDistance_Stream.listen((data) {
              onReceived_totalDistance(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _range_Stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_RANGE);
            _range_Stream.listen((data) {
              onReceived_range(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            _driving_mode_Stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_MODE);
            _driving_mode_Stream.listen((data) {
              onReceived_driving_mode(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _driving_mode_State_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_DRIVING_STATE);
            _driving_mode_State_stream.listen((data) {
              onReceived_driving_state(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _percentage_internal_Stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_PERCENTAGE);
            _percentage_internal_Stream.listen((data) {
              onReceived_percentage_internal(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _current_level_Stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_CURRENT);
            _current_level_Stream.listen((data) {
              onReceived_current_level(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            _battery_state_of_health_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_SOH);
            _battery_state_of_health_stream.listen((data) {
              onReceived_battery_soh(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_current_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_CURRENT);
            _battery_current_stream.listen((data) {
              onReceived_battery_current(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_temprature_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_TEMPRATURE);
            _battery_temprature_stream.listen((data) {
              onReceived_battery_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _battery_voltage_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BATTERY_VOLTAGE);
            _battery_voltage_stream.listen((data) {
              onReceived_battery_voltage(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_voltage_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_VOLTAGE);
            _controller_voltage_stream.listen((data) {
              onReceived_controller_voltage(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_temprature_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_TEMPRATURE);
            _controller_temprature_stream.listen((data) {
              onReceived_controller_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_throttle_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_THROTTLE);
            _controller_throttle_stream.listen((data) {
              onReceived_controller_throttle(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _controller_mapping_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_MAPPING);
            _controller_mapping_stream.listen((data) {
              onReceived_controller_map(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_revol_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_RPM);
            _motor_revol_stream.listen((data) {
              onReceived_motor_revol(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_temprature_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_TEMPRATURE);
            _motor_temprature_stream.listen((data) {
              onReceived_motor_temprature(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_odo_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_ODO);
            _motor_odo_stream.listen((data) {
              onReceived_motor_odo(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            controller_power_tube_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_POWER_TUBE_FAULT);
            controller_power_tube_fault_stream.listen((data) {
              onReceived_controller_power_tube_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            controller_driving_power_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_DRIVING_POWER_FAULT);
            controller_driving_power_fault_stream.listen((data) {
              onReceived_controller_driving_power_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            controller_over_current_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_CURRENT_FAULT);
            controller_over_current_fault_stream.listen((data) {
              onReceived_controller_over_current_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            controller_over_voltage_protection_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_VOLTAGE_PROTECTION);
            controller_over_voltage_protection_stream.listen((data) {
              onReceived_controller_over_voltage_protection(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            controller_over_temprature_protection_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_OVER_TEMPRATURE_PROTECTION);
            controller_over_temprature_protection_stream.listen((data) {
              onReceived_controller_over_temprature_protection(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            motor_phase_wire_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_PHASE_WIRE_FAULT);
            motor_phase_wire_fault_stream.listen((data) {
              onReceived_motor_phase_wire_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            motor_hall_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_HALL_FAULT);
            motor_hall_fault_stream.listen((data) {
              onReceived_motor_hall_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            motor_over_temprature_protection_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_OVER_TEMPRATURE_PROTECTION);
            motor_over_temprature_protection_stream.listen((data) {
              onReceived_motor_over_temprature_protection(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            controller_under_voltage_protection_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_CONTROLLER_UNDER_VOLTAGE_PROTECTION);
            controller_under_voltage_protection_stream.listen((data) {
              onReceived_controller_under_voltage_protection(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            motor_stall_protection_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_MOTOR_STALL_PROTECTION);
            motor_stall_protection_stream.listen((data) {
              onReceived_motor_stall_protection(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            throttle_fault_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_THROTTLE_FAULT);
            throttle_fault_stream.listen((data) {
              onReceived_throttle_fault(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            throttle_not_released_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_HROTTLE_NOT_RELEASED);
            throttle_not_released_stream.listen((data) {
              onReceived_throttle_not_released(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_low_voltage_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_LOW_VOLTAGE);
            bms_low_voltage_stream.listen((data) {
              onReceived_bms_low_voltage(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_over_current_charge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_CHARGE);
            bms_over_current_charge_stream.listen((data) {
              onReceived_bms_over_current_discharge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_over_current_discharge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_CURRENT_DISCHARGE);
            bms_over_current_discharge_stream.listen((data) {
              onReceived_motor_odo(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_over_temprature_discharge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_DISCHARGE);
            bms_over_temprature_discharge_stream.listen((data) {
              onReceived_bms_over_temprature_discharge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_under_temprature_discharge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_DISCHARGE);
            bms_under_temprature_discharge_stream.listen((data) {
              onReceived_bms_under_temprature_discharge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_under_temprature_charge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE);
            bms_under_temprature_charge_stream.listen((data) {
              onReceived_bms_under_temprature_charge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            bms_cell_open_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_BMS_CELL_OPEN);
            bms_cell_open_stream.listen((data) {
              onReceived_bms_cell_open(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_short_discharge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_SHORT_DISCHARGE);
            bms_short_discharge_stream.listen((data) {
              onReceived_bms_short_discharge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_over_temprature_charge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_CHARGE);
            bms_over_temprature_charge_stream.listen((data) {
              onReceived_bms_over_temprature_charge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_under_temprature_charge_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_UNDER_TEMPRATURE_CHARGE);
            bms_under_temprature_charge_stream.listen((data) {
              onReceived_bms_under_temprature_charge(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_over_temprature_mosfet_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_OVER_TEMPRATURE_MOSFET);
            bms_over_temprature_mosfet_stream.listen((data) {
              onReceived_bms_over_temprature_mosfet(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_temprature_sensor_error_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_TEMPRATURE_SENSOR_ERROR);
            bms_temprature_sensor_error_stream.listen((data) {
              onReceived_bms_temprature_sensor_error(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            bms_status_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_BMS_STATUS);
            bms_status_stream.listen((data) {
              onReceived_bms_status(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            vcu_status_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_VCU_STATUS);
            vcu_status_stream.listen((data) {
              onReceived_vcu_status(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            bms_charging_stream = flutterReactiveBle.subscribeToCharacteristic(
                _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGING);
            bms_charging_stream.listen((data) {
              onReceived_bms_charging(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            bms_discharging_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_DISCHARGING);
            bms_discharging_stream.listen((data) {
              onReceived_bms_discharging(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            bms_charge_completed_stream =
                flutterReactiveBle.subscribeToCharacteristic(
                    _QUALIFIED_CHARACTERISTIC_UUID_BMS_CHARGE_COMPLETED);
            bms_charge_completed_stream.listen((data) {
              onReceived_bms_charge_completed(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });
            _motor_gear_stream = flutterReactiveBle
                .subscribeToCharacteristic(_QUALIFIED_CHARACTERISTIC_GEAR);
            _motor_gear_stream.listen((data) {
              onReceived_motor_gear(data);
            }, onError: (dynamic error) {
              _logTexts = "${_logTexts}Error:$error$id\n";
            });

            break;
          }
        case DeviceConnectionState.disconnecting:
          {
            _logTexts = "${_logTexts}Disconnecting from $id\n";
            break;
          }
        case DeviceConnectionState.disconnected:
          {
            connected.value = false;
            utility().ble_disconnected_snackbar();
            _connection.cancel();

            _logTexts = "${_logTexts}Disconnected from $id\n";

            break;
          }
      }
    });
  }

  final eco = false.obs;
  final drive = true.obs;
  final sport = false.obs;

  final tier1 = false.obs;
  final tier2 = false.obs;
  final tier3 = false.obs;

  final gear1 = false.obs;
  final gear2 = false.obs;
  final gear3 = false.obs;

  final max = 0.obs;
  @override
  void onInit() {
    super.onInit();
    check_trial();
    permission_internal();
    FlutterBlue.instance.state.listen((event) {
      if (event.toString() == 'BluetoothState.on') {
        blueON = true;
        startScan();
      } else if (event.toString() == 'BluetoothState.off') {
        utility().disconnected_snackbar();
        enableBT();
      }
    });
  }

  Future<void> check_trial() async {
    print('check trailncalled!');
    final _instance = LocalStorage();
    final createdAt = DateTime.parse(_instance.read_createdAt());
    final currentDate = DateTime.now();
    var x = currentDate.difference(createdAt);
    var currentUser = _instance.read_currentUser();
    bool status = await checkUserStatus(currentUser);
    if (x.inDays >= 1) {
      if (status == false) {
        Get.toNamed('/login');
        _instance.remove_session();
      }
    }
  }

  Future<bool> checkUserStatus(String email) async {
    try {
      final checkuser =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      final status = checkuser.data()!['active'];
      return status;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<void> enableBT() async {
    await BluetoothEnable.enableBluetooth.then((value) {
      startScan();
      blueON = true;
    });
  }

  logout() {
    final _instance = LocalStorage();

    return Get.defaultDialog(
        title: 'Logout',
        titleStyle: TextStyle(fontSize: 22),
        content: Container(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              children: [
                Divider(
                  height: 2,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          _instance.remove_session();
                          Get.toNamed('/login');
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
              ],
            )));
  }

  gear_selection(
    bool value1,
    bool value2,
    bool value3,
    valueToBle,
  ) {
    return Get.defaultDialog(
        title: 'Are you sure?',
        titleStyle: TextStyle(fontSize: 22),
        content: Container(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              children: [
                Divider(
                  height: 2,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          _sendData(_QUALIFIED_CHARACTERISTIC_GEAR, valueToBle);
                          gear1.value = value1;
                          gear2.value = value2;
                          gear3.value = value3;

                          Get.back();
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
              ],
            )));
  }

  wheel_selection(bool value1, bool value2, bool value3, valueToBle) {
    return Get.defaultDialog(
        title: 'Are you sure?',
        titleStyle: TextStyle(fontSize: 22),
        content: Container(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              children: [
                Divider(
                  height: 2,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'No',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          tier1.value = value1;
                          tier2.value = value2;
                          tier3.value = value3;
                          _sendData(
                              _QUALIFIED_CHARACTERISTIC_WHEEL, valueToBle);

                          Get.back();
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          'Yes',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
              ],
            )));
  }

  selectDevices() async {
    displaying_selectDevice = true;
    return Get.dialog(Container(
        padding: EdgeInsets.only(top: 20),
        margin:
            const EdgeInsets.only(left: 50, right: 50, top: 100, bottom: 100),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 100,
        child: ListView.builder(
            itemCount: foundBleUARTDevices.length,
            itemBuilder: (context, index) => Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: index == 0 ? 70 : 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Text(
                            'Select Device',
                            style: TextStyle(
                                color: colors.text_color,
                                fontSize: 18,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Retrokit',
                            style: TextStyle(
                                color: colors.text_color,
                                fontSize: 17,
                                decoration: TextDecoration.none),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              (!connected.value && _scanning) ||
                                      (!_scanning && connected.value)
                                  ? () {}
                                  : await onConnectDevice(index);

                              Get.back();
                            },
                            child: Text(
                              'Connect',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: TextDecoration.none),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: colors.green,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: colors.text_color,
                      ),
                    ],
                  ),
                ))));
  }
}
