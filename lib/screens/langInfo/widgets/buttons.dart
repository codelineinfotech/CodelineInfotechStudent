import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget outlineButton({title, color}) {
  return Container(
    alignment: Alignment.center,
    width: Get.height / 8,
    height: Get.height / 22,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(13.0),
      border: Border.all(width: 1.0, color: color),
    ),
    child: SizedBox(
      width: 96.0,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Merriweather',
          fontSize: 10,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
