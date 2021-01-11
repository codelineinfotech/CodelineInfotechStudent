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
        height: 62.0,
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
  );
}

Widget googleSignInButton({deviceWidth, title, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      height: deviceWidth / 6,
      width: deviceWidth,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 25),
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
        children: [
          Image.asset("assets/images/glogo.png"),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Color(0xff3a3f44),
              letterSpacing: -0.004400000065565109,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}
