import 'dart:io';
import 'package:codeline_students_app/Resource/utility.dart';
import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/screens/login_register/widgets/back_string_button.dart';
import 'package:codeline_students_app/screens/login_register/widgets/buttons.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:codeline_students_app/services/firebase_sign_up_service.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Size deviceSize;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValidationController validationController =
      Get.put(ValidationController());

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController mobileNoTextEditingController = TextEditingController();

  TextEditingController conformPasswordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    validationController.termCondition = false.obs;
    validationController.obscureText = true.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Material(
      color: ColorsPicker.offWhite,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          bgElements1(deviceSize),
          bgElement2(deviceSize),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: backStringButton(
                      onTap: () => Navigator.pop(context),
                      title: "Sign in",
                      deviceWidth: deviceSize.width,
                    ),
                  ),
                  // signUpForm(context),
                  Form(key: _formKey, child: signUpForm(context))
                ],
              ),
            ),
          ),
          Obx(
            () => validationController.progressVisible.value
                ? CommanWidget.circularProgressBgBlack()
                : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget bgElements1(Size deviceWidth) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: deviceWidth.width * 1.67,
        width: deviceWidth.width * 1.1,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
          ),
        ),
      ),
    );
  }

  Widget bgElement2(Size deviceWidth) {
    return Positioned(
      bottom: -deviceWidth.width / 5,
      right: -deviceWidth.width / 3,
      child: Container(
        height: deviceWidth.width,
        width: deviceWidth.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/bg2.png",
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpForm(BuildContext context) {
    return Obx(() => Container(
          // color: Colors.yellow,
          child: Column(
            // shrinkWrap: true,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              signLabel(title: "Sign up"),
              SizedBox(
                height: deviceSize.height / 20,
              ),

              ///Name...
              Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextFormField(
                controller: nameTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.alphabetSpaceValidationPattern))
                ],
                validator: (name) => name.isEmpty ? "Name is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Enter Full Name",
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                  prefixIcon: SizedBox(
                    width: 20,
                    child: Image.asset(
                      ImagePath.userPng,
                      height: 5,
                      width: 5,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceSize.width / 14,
              ),

              ///Email...
              Text(
                "Email Address",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextFormField(
                controller: emailTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.emailAddressValidationPattern))
                ],
                validator: (email) =>
                    email.isEmpty ? "Email is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Enter Email Address",
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                  prefixIcon: Image.asset(
                    ImagePath.mailPng,
                    height: 5,
                    width: 5,
                    alignment: Alignment.center,
                  ),
                ),
              ),

              SizedBox(
                height: deviceSize.width / 14,
              ),

              ///Mobile Number...
              Text(
                "Mobile No",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextFormField(
                controller: mobileNoTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.digitsValidationPattern))
                ],
                validator: (name) =>
                    name.isEmpty ? "Mobile Number is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Enter Mobile No",
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                  prefixIcon: SizedBox(
                    width: 20,
                    child: Icon(Icons.phone_android_rounded),
                  ),
                ),
              ),

              SizedBox(
                height: deviceSize.width / 14,
              ),

              ///Password ...
              Text(
                "Password",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextFormField(
                controller: passwordTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.alphabetDigitsSpecialValidationPattern))
                ],
                validator: (password) =>
                    password.isEmpty ? "Password is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                  prefixIcon: Image.asset(
                    ImagePath.passwordPng,
                    height: 5,
                    width: 5,
                    alignment: Alignment.center,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      validationController.toggle();
                    },
                    child: Icon(
                      !validationController.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: validationController.obscureText.value,
              ),

              SizedBox(
                height: deviceSize.width / 14,
              ),

              ///Confirm Password ...
              Text(
                "Conform Password",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextFormField(
                controller: conformPasswordTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.alphabetDigitsSpecialValidationPattern))
                ],
                validator: (cPassword) =>
                    cPassword.isEmpty ? "Conform Password is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: "Enter Conform Password",
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                  prefixIcon: Image.asset(
                    ImagePath.passwordPng,
                    height: 5,
                    width: 5,
                    alignment: Alignment.center,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      validationController.toggle();
                    },
                    child: Icon(
                      !validationController.obscureText.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: validationController.obscureText.value,
              ),
              SizedBox(height: deviceSize.width / 14),

              ///Terms & Condition
              _termsNCondition(),
              SizedBox(height: deviceSize.width / 14),

              activeButton(
                  title: "Sign up",
                  onTap: () async {
                    print(nameTextEditingController.text);
                    print(emailTextEditingController.text);
                    print(passwordTextEditingController.text);
                    // Get.to(SignIn());
                    if (_formKey.currentState != null) {
                      if (passwordTextEditingController.text ==
                          conformPasswordTextEditingController.text) {
                        if (_formKey.currentState.validate()) {
                          if (validationController.termCondition.value) {
                            validationController.progressVisible.value = true;
                            FocusScope.of(context).unfocus();
                            await SignUpService().signUp(
                              email: emailTextEditingController.text,
                              password: passwordTextEditingController.text,
                              fullName: nameTextEditingController.text,
                              mobileNo: mobileNoTextEditingController.text,
                            );
                          } else {
                            Get.snackbar('Terms & Conditions',
                                'Please check Term Condition!');
                          }
                        } else {
                          print('unvalid');
                        }
                      } else {
                        Get.snackbar('Validation ',
                            'Password and Conform password does not match!');
                      }
                    } else {
                      print("Validat Method was call on null");
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ));
  }

  Widget _termsNCondition() {
    print("T&C  --> " + validationController.termCondition.value.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 22,
          width: 22,
          child: GetX(
            builder: (_) {
              return Checkbox(
                value: validationController.termCondition.value,
                onChanged: (value) {
                  validationController.chnageTC();

                  print("T&C Chnage --> " +
                      validationController.termCondition.value.toString());
                  /* validationController.termCondition.value =
                    !validationController.termCondition.value;*/
                  // validationController.chnageTC();
                },
                checkColor: Colors.white,
                activeColor: ColorsPicker.skyColor,
              );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text.rich(
          TextSpan(
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              color: ColorsPicker.darkGrey,
            ),
            children: [
              TextSpan(
                text: 'I agree to the ',
              ),
              TextSpan(
                text: 'Terms',
                style: TextStyle(
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextSpan(
                text: ' and ',
              ),
              TextSpan(
                text: 'Privacy',
                style: TextStyle(
                  color: ColorsPicker.skyColor,
                ),
              ),
              TextSpan(
                text: ' policy.',
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }
}
