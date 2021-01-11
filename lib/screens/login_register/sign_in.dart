import 'dart:convert';

import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/screens/login_register/sign_up.dart';
import 'package:codeline_students_app/screens/login_register/text_fields.dart';
import 'package:codeline_students_app/screens/login_register/widgets/buttons.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:codeline_students_app/services/firebase_login_service.dart';
import 'package:codeline_students_app/services/google_login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/src/foundation/key.dart';

final ValidationController validationController =
    Get.put(ValidationController());

class SignIn extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool signInPasswordVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Obx(() => WillPopScope(
        onWillPop: () async {
          validationController.forgotPasswordFlag.value = false;
          validationController.forgotPasswordPageIndex.value = 0;
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0xffF5F7FA),
            body: Stack(fit: StackFit.expand, children: [
              bgElements1(deviceWidth: deviceWidth),
              bgElement2(deviceWidth: deviceWidth),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SafeArea(
                            child: IconButton(
                          onPressed: () {
                            Get.to(SignUp());
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                            color: Color(0xff17a2b8),
                          ),
                        )),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              signLabel(title: "Sign in"),
                              SizedBox(
                                height: deviceWidth / 10,
                              ),
                              signTextField(
                                  title: "Email Address",
                                  icon: 'mail',
                                  controller: emailController,
                                  emailValidation: true),
                              SizedBox(height: deviceWidth / 14),
                              signTextField(
                                  title: "Password",
                                  icon: 'pass',
                                  obsecureText: signInPasswordVisible.value,
                                  controller: passwordController,
                                  passwordVisibleClick: () {
                                    signInPasswordVisible.value =
                                        !signInPasswordVisible.value;
                                  }),
                              SizedBox(height: deviceWidth / 20),
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  validationController
                                      .forgotPasswordFlag.value = true;
                                  validationController
                                      .forgotPasswordPageIndex.value = 0;
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff17a2b8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: deviceWidth / 14),
                              activeButton(
                                title: "Sign in",
                                onTap: () async {
                                  if (_formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();
                                    validationController.progressVisible.value =
                                        true;
                                    await FirebaseLoginService().firebaseLogin(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                              SizedBox(height: 15),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    navigateToSignUp(context);
                                  },
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(text: 'Don\'t have an Account? '),
                                    TextSpan(
                                      text: 'Sign up',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff17a2b8),
                                      ),
                                    )
                                  ])),
                                ),
                              ),
                              SizedBox(height: 25),
                              // Align(
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     'OR',
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       color: Color(0xff3a3f44),
                              //     ),
                              //     textAlign: TextAlign.left,
                              //   ),
                              // ),
                              // googleSignInButton(
                              //     onTap: () async {
                              //       validationController.progressVisible.value =
                              //           true;
                              //       await GoogleLoginService().googleLogin();
                              //     },
                              //     deviceWidth: deviceWidth,
                              //     title: "Sign in With Google"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]))));
  }

  void navigateToSignUp(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUp()));
  }
}
