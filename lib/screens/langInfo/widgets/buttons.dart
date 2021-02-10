import 'package:codeline_students_app/resource/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget outlineButton({title, color, Widget downloadIcon, bool isIcon = false}) {
  return Container(
    alignment: Alignment.center,
    width: isIcon ? Get.height / 6 : Get.height / 8,
    height: Get.height / 22,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(width: 1.0, color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Merriweather',
            fontSize: 10,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        isIcon
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: downloadIcon,
              )
            : SizedBox()
      ],
    ),
  );
}
