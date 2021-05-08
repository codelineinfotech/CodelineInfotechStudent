import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/screens/login_register/widgets/back_string_button.dart';
import 'package:codeline_students_app/screens/login_register/widgets/buttons.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:codeline_students_app/services/firebase_sign_up_service.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:flutter/material.dart';
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

              ///Email...
              CommanWidget.getTextFormField(
                  labelText: "Email Address",
                  textEditingController: emailTextEditingController,
                  validationType: Utility.emailText,
                  hintText: "Enter Email Address",
                  inputLength: 50,
                  regularExpression: Utility.emailAddressValidationPattern,
                  validationMessage: Utility.emailEmptyValidation,
                  iconPath: ImagePath.mailPng),

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

              ///Password ...
              CommanWidget.getTextFormField(
                labelText: "Password",
                textEditingController: passwordTextEditingController,
                inputLength: 30,
                regularExpression: Utility.password,
                validationMessage: "Password is required",
                validationType: 'password',
                hintText: "Enter Password",
                iconPath: ImagePath.passwordPng,
              ),

              ///Confirm Password ...

              CommanWidget.getTextFormField(
                labelText: "Conform Password",
                textEditingController: conformPasswordTextEditingController,
                inputLength: 30,
                regularExpression: Utility.password,
                validationMessage: "Conform Password is required",
                validationType: 'password',
                hintText: "Enter Conform Password",
                iconPath: ImagePath.passwordPng,
              ),

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
            ],
          )),
    );
  }

  sizedBox() {
    return SizedBox(height: deviceSize.width / 14);
  }

  Widget _termsNCondition() {
    print("T&C --> " + validationController.termCondition.value.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 22,
          width: 22,
          child: Checkbox(
            value: validationController.termCondition.value,
            onChanged: (value) {
              print("T&C Chnage --> " +
                  validationController.termCondition.value.toString());

              validationController.termCondition.value =
                  !validationController.termCondition.value;
              // validationController.chnageTC();
            },
            checkColor: Colors.greenAccent,
            activeColor: Color(0xff17a2b8),
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
              color: const Color(0xff797b8b),
            ),
            children: [
              TextSpan(
                text: 'I agree to the ',
              ),
              TextSpan(
                text: 'terms',
                style: TextStyle(
                  color: Color(0xff17a2b8),
                ),
              ),
              TextSpan(
                text: ' and ',
              ),
              TextSpan(
                text: 'Privacy',
                style: TextStyle(
                  color: Color(0xff17a2b8),
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
