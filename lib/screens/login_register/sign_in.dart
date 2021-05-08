import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/screens/login_register/widgets/buttons.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:codeline_students_app/services/firebase_login_service.dart';
import 'package:codeline_students_app/services/google_login_service.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import 'sign_up_new.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var deviceWidth;
  var deviceHeight;
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  ValidationController validationController = Get.put(ValidationController());

  @override
  void initState() {
    // TODO: implement initState
    validationController.obscureText = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("SING IN LOGIN");
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Obx(() => WillPopScope(
        onWillPop: () async {
          validationController.forgotPasswordFlag.value = false;
          validationController.forgotPasswordPageIndex.value = 0;
          return true;
        },
        child: Scaffold(
            backgroundColor: Color(0xffF5F7FA),
            body: Stack(fit: StackFit.expand, children: [
              bgElements1(deviceWidth: deviceWidth),
              bgElement2(deviceWidth: deviceWidth),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                        child: IconButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.black,
                      ),
                    )),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: loginFormWidget(context),
                      ),
                    ),
                  ],
                ),
              ),
              validationController.progressVisible.value
                  ? CommanWidget.circularProgressBgBlack()
                  : SizedBox(),
            ]))));
  }

  loginFormWidget(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
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

          ///Email...
          CommanWidget.getTextFormField(
              labelText: "Email Address",
              textEditingController: emailController,
              validationType: Utility.emailText,
              hintText: "Enter Email Address",
              inputLength: 50,
              regularExpression: Utility.emailAddressValidationPattern,
              validationMessage: Utility.emailEmptyValidation,
              iconPath: ImagePath.mailPng),

          ///Password ...
          CommanWidget.getTextFormField(
            labelText: "Password",
            textEditingController: passwordController,
            inputLength: 30,
            regularExpression: Utility.password,
            validationMessage: "Password is required",
            validationType: 'password',
            hintText: "Enter Password",
            iconPath: ImagePath.passwordPng,
          ),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              validationController.forgotPasswordFlag.value = true;
              validationController.forgotPasswordPageIndex.value = 0;
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: kLabelTextStyle,
              ),
            ),
          ),
          SizedBox(height: deviceWidth / 14),
          activeButton(
            title: "Sign in",
            onTap: () async {
              if (_formKey.currentState != null) {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();
                  validationController.progressVisible.value = true;
                  await FirebaseLoginService().firebaseLogin(
                      email: emailController.text,
                      password: passwordController.text,
                      buildContext: context);
                }
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'OR',
              style: TextStyle(
                fontSize: 16,
                color: ColorsPicker.balticSea,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          googleSignInButton(
              onTap: () async {
                print("hello");
                validationController.progressVisible.value = true;
                await GoogleLoginService().googleLogin(context);
              },
              deviceWidth: deviceWidth,
              title: "Sign in With Google"),
          SizedBox(height: 15),
          Center(
            child: InkWell(
              onTap: () {
                Get.to(SignUpScreen());
              },
              child: Text.rich(TextSpan(children: [
                TextSpan(text: 'Don\'t have an Account? '),
                TextSpan(
                  text: 'Sign up',
                  style: kLabelTextStyle,
                )
              ])),
            ),
          ),
        ],
      ),
    );
  }
}
