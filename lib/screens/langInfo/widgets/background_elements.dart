import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget bgElement() {
  return Align(
    alignment: Alignment.topRight,
    child: SvgPicture.asset(
      "assets/images/homeBg.svg",
      height: Get.height / 4,
      width: Get.height / 3,
    ),
  );
}

Widget bgElement2() {
  return SvgPicture.asset(
    "assets/images/cbg.svg",
    height: Get.height / 7.3,
  );
}
