import 'dart:io';

import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

class CommanWidget {
  static Widget circularProgress() {
    return Center(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(ColorsPicker.skyColor),
    ));
  }

  static Widget circularProgressBgBlack() {
    return Container(
      color: Colors.black26,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(ColorsPicker.skyColor),
      )),
    );
  }

  static Widget imageProfileView(
      {String imageUrl,
      double imageHeight,
      double imageWidth,
      String decoration}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: imageHeight,
        width: imageWidth,
        child: imageUrl != null && imageUrl != ""
            ? OctoImage(
                fit: BoxFit.fill,
                imageBuilder: OctoImageTransformer.circleAvatar(),
                image: NetworkImage(imageUrl),
                placeholderBuilder:
                    OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                errorBuilder: OctoError.icon(color: Colors.red),
              )
            : Image.asset(ImagePath.profilePng),
        decoration: decoration == "NoDecoration"
            ? BoxDecoration()
            : BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 5),
              ),
      ),
    );
  }

  static Widget approvalDialog(BuildContext context) {
    String dialogTitle = "Alert";
    String alertMsg =
        'Your registration is successfully but,your account is not approved by codeline infotech please contact codeline infotech';
    if (Platform.isAndroid) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Text(alertMsg),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Get.offAll(SignIn());
                },
              ),
            ],
          );
        },
      );
    } else if (Platform.isIOS) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(dialogTitle),
                content: new Text(alertMsg),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Get.offAll(SignIn());
                    },
                    isDefaultAction: true,
                    child: Text("Ok"),
                  ),
                ],
              ));
    }
  }

  static Widget snackBar({String title,String message,SnackPosition position})
  {
    Get.snackbar(title, message,snackPosition: position);
  }
  static Widget labelWidget({String title}) {
    return Text(
      title,
      style: kLabelTextStyle,
    );
  }

}

