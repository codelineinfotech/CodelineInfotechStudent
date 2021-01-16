import 'package:codeline_students_app/Resource/utility.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/screens/login_register/text_fields.dart';
import 'package:codeline_students_app/screens/login_register/widgets/back_string_button.dart';
import 'package:codeline_students_app/screens/login_register/widgets/buttons.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:codeline_students_app/services/firebase_sign_up_service.dart';
import 'package:codeline_students_app/widgets/circularprogress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_core/rx_impl.dart';

import '../../controller/validation_getx_controller.dart';
import 'sign_in.dart';

class SignUp extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxBool passwordVisible = true.obs;
  RxBool rePasswordVisible = true.obs;
  final ValidationController validationController =
      Get.put(ValidationController());

  @override
  Widget build(BuildContext context) {
    print("BUILD CALL");
    var deviceHeight = MediaQuery.of(context).size.height;

    var deviceWidth = MediaQuery.of(context).size.width;
    return _buildBody(deviceWidth, context, deviceHeight);
  }

  Widget _buildBody(
      double deviceWidth, BuildContext context, double deviceHeight) {
    return GetBuilder(builder: (_) {
      return WillPopScope(
        onWillPop: () async {
          print("_buildBody");
          validationController.termCondition.value = false;
          return true;
        },
        child: Scaffold(
          backgroundColor: Color(0xffF5F7FA),
          body: Stack(
            fit: StackFit.expand,
            children: [
              bgElements1(deviceWidth: deviceWidth),
              bgElement2(deviceWidth: deviceWidth),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: backStringButton(
                          onTap: () => Navigator.pop(context),
                          title: "Sign in",
                          deviceWidth: deviceWidth,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              signLabel(title: "Sign up"),
                              SizedBox(
                                height: deviceWidth / 10,
                              ),
                              signTextField(
                                title: "Full Name",
                                icon: 'user',
                                controller: fullNameController,
                                inputTextLength: 50,
                                regularExpressions:
                                    Utility.alphabetSpaceValidationPattern,
                              ),
                              SizedBox(height: deviceWidth / 14),
                              signTextField(
                                title: "Email Address",
                                icon: 'mail',
                                emailValidation: true,
                                controller: emailController,
                                inputTextLength: 40,
                                regularExpressions: r"([a-zA-Z0-9@.]+)",
                              ),
                              SizedBox(height: deviceWidth / 14),
                              signTextField(
                                title: "Password",
                                icon: 'pass',
                                passwordLength: true,
                                passwordVisibleClick: () {
                                  passwordVisible.value =
                                      !passwordVisible.value;
                                },
                                obsecureText: passwordVisible.value,
                                controller: passwordController,
                                inputTextLength: 20,
                                regularExpressions: Utility
                                    .alphabetDigitsSpecialValidationPattern,
                              ),
                              SizedBox(height: deviceWidth / 14),
                              signTextField(
                                title: "Confirm Password",
                                icon: 'pass',
                                placeholder: 'Confirm Password',
                                rePassword: passwordController.text,
                                passwordVisibleClick: () {
                                  rePasswordVisible.value =
                                      !rePasswordVisible.value;
                                },
                                obsecureText: rePasswordVisible.value,
                                controller: rePasswordController,
                                inputTextLength: 20,
                                regularExpressions: Utility
                                    .alphabetDigitsSpecialValidationPattern,
                              ),
                              SizedBox(height: deviceWidth / 14),
                              _termsNCondition(),
                              SizedBox(height: deviceHeight / 20),
                              activeButton(
                                  title: "Sign up",
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      if (validationController
                                          .termCondition.value) {
                                        validationController
                                            .progressVisible.value = true;
                                        FocusScope.of(context).unfocus();
                                        await SignUpService().signUp(
                                          email: emailController.text,
                                          password: rePasswordController.text,
                                          fullName: fullNameController.text,
                                        );
                                      } else {
                                        Get.snackbar('Terms & Conditions',
                                            'Please check Term Condition!');
                                      }
                                    } else {
                                      print('unvalid');
                                    }
                                  }),
                              SizedBox(
                                height: deviceWidth / 20,
                              ),
                              SizedBox(
                                height: deviceWidth / 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              validationController.progressVisible.value
                  ? CircularProgress.circularProgress()
                  : SizedBox()
            ],
          ),
        ),
      );
    });
  }

  void navigateToSignIn(context) {
    print("navigateToSignIn");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignIn()));
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
            checkColor: Colors.white,
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
