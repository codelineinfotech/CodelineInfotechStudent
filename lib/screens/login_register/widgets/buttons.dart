import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Widget activeButton({title, onTap}) {
  return GestureDetector(
    onTap: onTap,
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
                title,
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
  );
}

Widget googleSignInButton({deviceWidth, title, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      height: Get.height / 14,
      width: deviceWidth,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff959595).withOpacity(0.31),
            offset: Offset(0, 3),
            blurRadius: 16,
          )
        ],
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: Image.asset(ImagePath.googleLogoPng)),
          // Spacer(),

          ///Google Signin Text
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: kGoogleBtnTextStyle,
            ),
          ),

          Spacer(),
        ],
      ),
    ),
  );
}
