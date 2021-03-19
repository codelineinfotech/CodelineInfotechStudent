import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/services/firebase_contactus_service.dart';
import 'package:codeline_students_app/services/firebase_contactus_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

    return Scaffold(
      backgroundColor: ColorsPicker.offWhite,
      body: Stack(
        overflow: Overflow.visible,
        children: [
          bgElements1(deviceWidth: deviceSize.width),
          bgElement2(deviceSize),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: backStringButton(
                    onTap: () => Navigator.pop(context),
                    title: "Contact Us",
                    deviceWidth: deviceSize.width,
                  ),
                ),
                // signUpForm(context),
                Expanded(
                    child: Form(key: _formKey, child: contactUsForm(context)))
              ],
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
              ImagePath.bg2Png,
            ),
          ),
        ),
      ),
    );
  }

  Widget contactUsForm(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style:kDetailsTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),

            ///Name...
            Text(
              "Full Name",
              style: kLabelTextStyle,
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
              validator: (name) => name.isEmpty ?  Utility.nameEmptyValidation : null,
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
              style:kLabelTextStyle,
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
              validator: (email) => email.isEmpty ? Utility.emailEmptyValidation : null,
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
                  style:kLabelTextStyle,
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
                focusColor: ColorsPicker.skyColor,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorsPicker.skyColor, width: 1.0),
                ),
                hintStyle: kHintTextStyle,
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
                          style: kButtonTextStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(ImagePath.arrowSvg),
                      )
                    ],
                  )),
            ),
          ],
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
