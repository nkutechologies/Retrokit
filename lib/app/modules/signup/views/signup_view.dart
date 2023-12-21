import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../styles/colors.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backGround,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'BebasNeue',
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Obx(() => TextFormField(
                      controller: controller.nameController.value,
                      cursorColor: Colors.yellow,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.yellow), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Name',
                          suffixIcon: Icon(
                            Icons.person,
                            color: Color.fromARGB(
                              255,
                              242,
                              201,
                              25,
                            ),
                          )),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.nameValidator.value == true
                            ? Text(
                                ' Please enter a valid name ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                Obx(() => TextFormField(
                      controller: controller.surenameController.value,
                      cursorColor: Colors.yellow,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.yellow), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Surname',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.person_outlined,
                                color: Color.fromARGB(
                                  255,
                                  242,
                                  201,
                                  25,
                                ),
                              ))),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.surenameValidator.value == true
                            ? Text(
                                ' Please enter a valid surname ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                Obx(() => TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.yellow,
                      controller: controller.emailController.value,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.yellow), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Email',
                          suffixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.email,
                                color: Color.fromARGB(
                                  255,
                                  242,
                                  201,
                                  25,
                                ),
                              ))),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.emailValidator.value == true
                            ? Text(
                                ' Please enter a valid email ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                Obx(
                  () => TextFormField(
                    cursorColor: Colors.yellow,
                    obscureText: controller.isObscure.value,
                    controller: controller.passwordController.value,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Colors.white), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: Colors.yellow), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: 'Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            color: Color.fromARGB(
                              255,
                              242,
                              201,
                              25,
                            ),
                            icon: Icon(controller.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              controller.isObscure.value =
                                  !controller.isObscure.value;
                            })),
                  ),
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.passwordValidator.value == true
                            ? Text(
                                ' Please enter a valid password ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                Obx(() => TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.yellow,
                      controller: controller.phoneController.value,
                      decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.white), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2, color: Colors.yellow), //<-- SEE HERE
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Phone',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.phone,
                                color: Color.fromARGB(
                                  255,
                                  242,
                                  201,
                                  25,
                                ),
                              ))),
                    )),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.phoneValidator.value == true
                            ? Text(
                                ' Please enter a valid phone number ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Text(
                    'Chassis',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Row(
                  children: [
                    Obx(() => Flexible(
                          child: TextFormField(
                            maxLength: 5,
                            cursorColor: Colors.yellow,
                            controller: controller.chasssisController.value,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.yellow), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                    Text(
                      ' * ',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(
                          255,
                          242,
                          201,
                          25,
                        ),
                      ),
                    ),
                    Obx(() => Flexible(
                          child: TextFormField(
                            maxLength: 7,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.yellow,
                            controller: controller.chasssisNumController.value,
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.white), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.yellow), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        )),
                  ],
                ),
                Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 7, top: 7),
                      child: SizedBox(
                        height: 20,
                        child: controller.chassisValidator.value == true
                            ? Text(
                                ' Please enter a valid chassis number ',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.register(
                            controller.emailController.value.text,
                            controller.passwordController.value.text);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            decoration: TextDecoration.none),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(
                            left: 60, right: 60, top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Color.fromARGB(
                          255,
                          242,
                          201,
                          25,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Color.fromARGB(
                              255,
                              242,
                              201,
                              25,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.toNamed('/login');
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                backgroundColor: Colors.black,
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(
                                  255,
                                  242,
                                  201,
                                  25,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
