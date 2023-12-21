import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retrokit/styles/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  forgetPasswordWidget() {
    return Get.defaultDialog(
        titlePadding: const EdgeInsets.only(top: 20, bottom: 40),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        title: 'Reset Password',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => TextFormField(
                  controller: controller.resetEmailController.value,
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
                      hintText: 'Enter Email',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {
                            controller.forgetPassword();
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color.fromARGB(
                              255,
                              242,
                              201,
                              25,
                            ),
                          ))),
                )),
            Obx(() => Padding(
                  padding: const EdgeInsets.only(left: 7, top: 9),
                  child: controller.resetValidator.value == true
                      ? Text(
                          ' Please enter a valid email ',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: colors.backGround,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'BebasNeue',
                      color: Colors.white),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => TextFormField(
                          controller: controller.emailController.value,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
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
                              hintText: 'Email',
                              border: InputBorder.none,
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
                          padding: const EdgeInsets.only(left: 7, top: 9),
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
                    Obx(() => Center(
                          child: TextFormField(
                            obscureText: controller.isObscure.value,
                            controller: controller.passwordController.value,
                            cursorColor: Colors.yellow,
                            decoration: InputDecoration(
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
                        )),
                    Obx(() => Padding(
                          padding: const EdgeInsets.only(left: 7, top: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                          onTap: () {
                            forgetPasswordWidget();
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(
                                255,
                                242,
                                201,
                                25,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.sign_in(
                            controller.emailController.value.text,
                            controller.passwordController.value.text);
                      },
                      child: Text(
                        'Sign In',
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
                          'Don\'t have an account?',
                          style: TextStyle(
                            decoration: TextDecoration.none,
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
                              Get.toNamed('/signup');
                            },
                            child: Text(
                              'Sign Up',
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
