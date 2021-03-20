import 'dart:io';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/utility.dart';
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
    return Scaffold(
      backgroundColor: ColorsPicker.offWhite,
      body: Stack(
        overflow: Overflow.visible,
        children: [
          bgElements1(deviceSize),
          bgElement2(deviceSize),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Expanded(child: Form(key: _formKey, child: signUpForm(context)))
              ],
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
            image: AssetImage(ImagePath.bgPng),
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
              ImagePath.bg2Png,
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpForm(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Obx(() => Column(
            // shrinkWrap: true,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              signLabel(title: "Sign up"),
              SizedBox(
                height: deviceSize.height / 25,
              ),
              ///Name...
              CommanWidget.getTextFormField(
                  labelText: "Full Name",
                  textEditingController: nameTextEditingController,
                  hintText: "Enter Full Name",
                  inputLength: 30,
                  regularExpression: Utility.alphabetSpaceValidationPattern,
                  validationMessage: Utility.nameEmptyValidation,
                  iconPath: ImagePath.userPng),
              /*///Name...

              CommanWidget.labelWidget(title: "Full Name"),

              TextFormField(
                controller: nameTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.alphabetSpaceValidationPattern))
                ],
                validator: (name) =>
                    name.isEmpty ? Utility.nameEmptyValidation : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorsPicker.skyColor)),
                  hintText: "Enter Full Name",
                  hintStyle: kHintTextStyle,
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
              sizedBox(),*/

              ///Email...
              CommanWidget.getTextFormField(
                  labelText: "Email Address",
                  textEditingController: emailTextEditingController,
                  validationType: Utility.emailText,
                  hintText: "Enter Email Address",
                  inputLength: 50,
                  regularExpression: Utility.emailAddressValidationPattern,
                  validationMessage: Utility.emailEmptyValidation,
                  iconPath:ImagePath.mailPng ),
            /*  CommanWidget.labelWidget(title: "Email Address"),

              TextFormField(
                controller: emailTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.emailAddressValidationPattern))
                ],
                // validator: (email) => email.isEmpty ? "Email is required" : null,
                validator: (text) {
                  return Utility.validateUserName(text);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorsPicker.skyColor)),
                  hintText: "Enter Email Address",
                  hintStyle: kHintTextStyle,
                  prefixIcon: Image.asset(
                    ImagePath.mailPng,
                    height: 5,
                    width: 5,
                    alignment: Alignment.center,
                  ),
                ),
              ),

              sizedBox(),
*/
              ///Mobile Number...
              CommanWidget.getTextFormField(
                labelText: "Mobile No",
                textEditingController: mobileNoTextEditingController,
                inputLength: 10,
                regularExpression: Utility.digitsValidationPattern,
                validationMessage: Utility.mobileNumberInValidValidation,
                validationType: 'mobileno',
                hintText: "Enter Mobile No",
                icon: Icons.phone_android_rounded,
              ),
           /*   CommanWidget.labelWidget(title: "Mobile No"),

              TextFormField(
                controller: mobileNoTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.digitsValidationPattern))
                ],
                validator: (name) => name.isEmpty
                    ? Utility.mobileNumberInValidValidation
                    : mobileNoTextEditingController.text.length != 10
                        ? Utility.mobileNumberInValidValidation
                        : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorsPicker.skyColor)),
                  hintText: "Enter Mobile No",
                  hintStyle: kHintTextStyle,
                  prefixIcon: SizedBox(
                    width: 20,
                    child: Icon(
                      Icons.phone_android_rounded,
                      color: Color(0xff9A9BA7),
                    ),
                  ),
                ),
              ),

              sizedBox(),*/

              ///Password ...
              CommanWidget.getTextFormField(
                labelText: "Password",
                textEditingController: passwordTextEditingController,
                inputLength: 30,
                regularExpression: Utility.password,
                validationMessage: "",
                validationType: 'Password',
                hintText: "Enter Password",
                iconPath: ImagePath.passwordPng,
              ),
              CommanWidget.labelWidget(title: "Password"),

              TextFormField(
                controller: passwordTextEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(Utility.password)),
                  LengthLimitingTextInputFormatter(30),
                  /*     FilteringTextInputFormatter.allow(RegExp(Utility
                                    .alphabetDigitsSpecialValidationPattern))*/
                ],
                // validator: (password) =>
                //     password.isEmpty ? "Password is required" : null,
                validator: (text) {
                  return Utility.validatePassword(text);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorsPicker.skyColor)),
                  hintText: "Enter Password",
                  hintStyle: kHintTextStyle,
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
                      color: ColorsPicker.skyColor,
                    ),
                  ),
                ),
                obscureText: validationController.obscureText.value,
              ),

              sizedBox(),

              ///Confirm Password ...
              CommanWidget.labelWidget(title: "Conform Password"),

              TextFormField(
                controller: conformPasswordTextEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(Utility.password)),
                  LengthLimitingTextInputFormatter(30),
                  /*     FilteringTextInputFormatter.allow(RegExp(Utility
                                    .alphabetDigitsSpecialValidationPattern))*/
                ],
                // validator: (password) =>
                //     password.isEmpty ? "Password is required" : null,
                validator: (text) {
                  return Utility.validatePassword(text);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorsPicker.skyColor)),
                  hintText: "Enter Conform Password",
                  hintStyle: kHintTextStyle,
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
                      color: ColorsPicker.skyColor,
                    ),
                  ),
                ),
                obscureText: validationController.obscureText.value,
              ),
              sizedBox(),
              ///Terms & Condition
              _termsNCondition(),
              sizedBox(),

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
                                buildContext: context);
                          } else {
                            CommanWidget.snackBar(
                                title: Utility.termsConditions,
                                message: Utility.termsConditionsMessage,
                                position: SnackPosition.BOTTOM);
                          }
                        } else {
                          print('unvalid');
                        }
                      } else {
                        CommanWidget.snackBar(
                            title: '',
                            message: Utility.passwordNotMatch,
                            position: SnackPosition.BOTTOM);
                      }
                    } else {
                      print("Validat Method was call on null");
                    }
                  }),
              // Padding(
              //   padding: EdgeInsets.only(
              //       bottom: MediaQuery.of(context).viewInsets.bottom),
              // ),
            ],
          )),
    );
  }

  sizedBox() {
    return SizedBox(height: deviceSize.width / 14);
  }

  labelWidget({String title}) {
    return Text(
      title,
      style: kLabelTextStyle,
    );
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
