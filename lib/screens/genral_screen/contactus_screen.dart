import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/services/firebase_contactus_service.dart';
import 'package:codeline_students_app/widgets/drawer_.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../langInfo/widgets/app_bar_.dart';
import '../langInfo/widgets/background_elements.dart';
import '../login_register/widgets/back_string_button.dart';
import '../login_register/widgets/widgets.dart';

class ContactUsScreen extends StatelessWidget {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController messageTextEditingController = TextEditingController();
  Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Material(
      color: ColorsPicker.offWhite,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          bgElements1(deviceWidth: deviceSize.width),
          bgElement2(deviceSize),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SafeArea(
                      child: backStringButton(
                        onTap: () => Navigator.pop(context),
                        title: "Contact Us",
                        deviceWidth: deviceSize.width,
                      ),
                    ),
                  ),
                  // signUpForm(context),
                  Form(key: _formKey, child: contactUsForm(context))
                ],
              ),
            ),
          ),
        ],
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

  Widget contactUsForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 38,
                  color: const Color(0xff3a3f44),
                  letterSpacing: 0.38,
                  fontWeight: FontWeight.w500,
                  height: 1.3421052631578947,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
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
                // style: TextStyle(
                //   color: ColorsPicker.darkGrey.withOpacity(0.8),
                // ),
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
                      color: ColorsPicker.darkGrey.withOpacity(0.6),
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
                      RegExp(Utility.alphabetDigitsSpecialValidationPattern))
                ],
                // style: TextStyle(
                //   color: ColorsPicker.darkGrey.withOpacity(0.8),
                // ),
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
                    color: ColorsPicker.darkGrey.withOpacity(0.6),
                    alignment: Alignment.center,
                  ),
                ),
              ),

              SizedBox(
                height: deviceSize.width / 14,
              ),

              ///Message...
              Row(
                children: [
                  Text(
                    "Message",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsPicker.skyColor,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.message,
                    size: 15,
                    color: Colors.grey,
                  ),
                  // Image.asset(
                  //   ImagePath.messagePng,
                  //   color: ColorsPicker.darkGrey.withOpacity(0.8),
                  //   alignment: Alignment.topCenter,
                  // )
                ],
              ),
              SizedBox(
                height: deviceSize.width / 20,
              ),
              TextFormField(
                maxLines: 5,

                controller: messageTextEditingController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                  FilteringTextInputFormatter.allow(
                      RegExp(Utility.alphabetDigitsSpaceValidationPattern))
                ],
                textInputAction: TextInputAction.done,
                // style: TextStyle(
                //   color: ColorsPicker.darkGrey.withOpacity(0.8),
                // ),
                textAlign: TextAlign.start,
                validator: (message) =>
                    message.isEmpty ? "Message is required" : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff3a3f44).withOpacity(0.5),
                  ),
                ),
              ),

              SizedBox(
                height: deviceSize.width / 14,
              ),
              InkWell(
                onTap: () {
                  contactUs();
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    width: Get.width,
                    height: Get.height / 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: const Color(0xff17a2b8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x6117a2b8),
                          offset: Offset(0, 10),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Send Message",
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              color: const Color(0xffffffff),
                              letterSpacing: -0.004400000065565109,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SvgPicture.asset("assets/images/arrow.svg"),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void contactUs() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState.validate()) {
        ContactUsService().contactUs(
            name: nameTextEditingController.text,
            email: emailTextEditingController.text,
            message: messageTextEditingController.text);
      } else {
        print('unvalid');
      }
    } else {
      print("Validat Method was call on null");
    }
  }
}
