import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/services/firebase_contactus_service.dart';
import 'package:codeline_students_app/services/firebase_contactus_service.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
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
              style: kDetailsTextStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),

            ///Name...

            CommanWidget.getTextFormField(
              labelText:   "Full Name",
                textEditingController: nameTextEditingController,
                hintText: "Enter Full Name",
                inputLength: 30,
                regularExpression: Utility.alphabetSpaceValidationPattern,
                validationMessage: Utility.nameEmptyValidation,
                iconPath:ImagePath.userPng),
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
            ///Message...
            Row(
              children: [
                Text(
                  "Message",
                  style: kLabelTextStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.message,
                  size: 15,
                  color: Colors.grey,
                ),

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
              textAlign: TextAlign.start,
              validator: (message) =>
                  message.isEmpty ? "Message is required" : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                errorBorder:  CommanWidget.outLineRed,
                focusedErrorBorder: CommanWidget.outLineRed,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                focusColor: ColorsPicker.skyColor,
                enabledBorder:CommanWidget.outLineSky,
                focusedBorder: CommanWidget.outLineSky,
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
