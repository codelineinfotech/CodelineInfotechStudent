import 'package:codeline_students_app/resource/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget bgElement() {
  return Align(
    alignment: Alignment.topRight,
    child: SvgPicture.asset(
      ImagePath.homeBgSvg,
      height: Get.height / 4,
      width: Get.height / 3,
    ),
  );
}

Widget bgElement2() {
  return SvgPicture.asset(
    ImagePath.cbgSvg,
    height: Get.height / 7.3,
  );
}
