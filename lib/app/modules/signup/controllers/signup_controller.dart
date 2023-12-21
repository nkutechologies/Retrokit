import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/local_storage_services.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final surenameController = TextEditingController().obs;
  final chasssisController = TextEditingController().obs;
  final chasssisNumController = TextEditingController().obs;

  final emailValidator = false.obs;
  final passwordValidator = false.obs;
  final nameValidator = false.obs;
  final surenameValidator = false.obs;
  final phoneValidator = false.obs;
  final chassisValidator = false.obs;
  final chassisNumValidator = false.obs;

  RxBool isObscure = true.obs;

  save_data() {}

  validateControllers() {
    bool execute = false;

    if (emailController.value.text.contains('@') == false ||
        emailController.value.text.length < 6) {
      emailValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => emailValidator.value = false);
      execute = true;
    }

    if (surenameController.value.text.length == 0) {
      surenameValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => surenameValidator.value = false);
      execute = true;
    }
    if (nameController.value.text.length == 0) {
      nameValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => nameValidator.value = false);
      execute = true;
    }

    if (passwordController.value.text.length < 6) {
      passwordValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => passwordValidator.value = false);
      execute = true;
    }
    if (phoneController.value.text.length < 7 ||
        phoneController.value.text.isNumericOnly == false) {
      phoneValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => phoneValidator.value = false);
      execute = true;
    }
    if (chasssisController.value.text.length == 0) {
      chassisValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => chassisValidator.value = false);
      execute = true;
    }
    if (chasssisNumController.value.text.length == 0) {
      chassisNumValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => chassisNumValidator.value = false);
      execute = true;
    }
    return execute;
  }

  void save_usersData(Map<String, dynamic> data, String email) {
    final _firestore = FirebaseFirestore.instance;

    try {
      _firestore.collection('users').doc(email).set(data);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  void register(String email, String password) {
    final dateTime = DateTime.now();
    print(dateTime.day);
    final _instance = LocalStorage();
    try {
      validateControllers() == true
          ? null
          : _auth
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((_) {
              _instance.write_session();
              _instance.write_createdAt();
              _instance.write_currentUser(email);

              final map = {
                'name': nameController.value.text,
                'surename': surenameController.value.text,
                'email': emailController.value.text,
                'chassis':
                    '${chasssisController.value.text} ${chasssisNumController.value.text}',
                'phone': phoneController.value.text,
                'createdAt': DateTime.now().toString(),
                'active': false,
              };
              save_usersData(map, emailController.value.text);
              nameController.value.text = '';
              surenameController.value.text = '';
              emailController.value.text = '';
              passwordController.value.text = '';
              chasssisController.value.text = '';
              phoneController.value.text = '';
              Get.toNamed('/home');
            });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        '',
        e.message.toString(),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
