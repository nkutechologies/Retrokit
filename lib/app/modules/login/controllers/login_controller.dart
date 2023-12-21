import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrokit/app/helper/local_storage_services.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  FirebaseAuth _auth = FirebaseAuth.instance;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final resetEmailController = TextEditingController().obs;

  final emailValidator = false.obs;
  final passwordValidator = false.obs;
  final resetValidator = false.obs;
  RxBool isObscure = true.obs;

  validateControllers() {
    bool execute = false;

    if (emailController.value.text.contains('@') == false ||
        emailController.value.text.length < 6) {
      emailValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => emailValidator.value = false);
      execute = true;
    }

    if (passwordController.value.text.length < 6) {
      passwordValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => passwordValidator.value = false);
      execute = true;
    }

    return execute;
  }

  validateResetControllers() {
    bool execute = false;

    if (resetEmailController.value.text.contains('@') == false ||
        resetEmailController.value.text.length < 6) {
      resetValidator.value = true;
      Future.delayed(Duration(seconds: 3))
          .then((value) => resetValidator.value = false);
      resetEmailController.value.text = '';
      execute = true;
    }

    return execute;
  }

  Future<void> check_trial(String email) async {
    try {
      final _instance = LocalStorage();

      final data =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (data.exists) {
        final createdAt_firestore = data.data()!['createdAt'].toString();
        print(createdAt_firestore);
        bool status = data.data()!['active'];
        final createdAt = DateTime.parse(createdAt_firestore.toString());
        final currentDate = DateTime.now();
        var diff = currentDate.difference(createdAt);
        print(diff);

        if (diff.inDays >= 1) {
          if (status == false) {
            Get.snackbar(
                ' User is restricted!', 'User is deactivated from admin');
          } else if (status == true) {
            _instance.write_session();
            _instance.write_currentUser(email);
            Get.toNamed('/home');
          }
        } else if (diff.inDays <= 1) {
          _instance.write_session();
          _instance.write_currentUser(email);
          Get.toNamed('/home');
        }
      }
    } on FirebaseException catch (e) {
      Get.snackbar('', e.message.toString());
    }
  }

  Future<void> sign_in(String email, String password) async {
    try {
      validateControllers() == true
          ? null
          : await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((_) {
              check_trial(email);
              emailController.value.text = '';
              passwordController.value.text = '';
            });
    } on FirebaseAuthException catch (e) {
      Get.snackbar(e.message.toString(), '');
    }
  }

  void forgetPassword() {
    try {
      validateResetControllers() == true
          ? null
          : _auth
              .sendPasswordResetEmail(email: resetEmailController.value.text)
              .then((value) => {
                    resetEmailController.value.text = '',
                    Get.back(),
                  });
    } on FirebaseException catch (e) {
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
