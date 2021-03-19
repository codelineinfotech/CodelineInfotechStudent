import 'package:animate_do/animate_do.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget feesDetails() {
  return Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FadeInLeft(child: _boxes(title: "10%", description: "Discount")),
        ZoomIn(child: _boxes(title: "33.5K", description: "Left Fees")),
        FadeInRight(child: _boxes(title: "10K", description: "Deposit"))
      ],
    ),
  );
}

Widget _boxes({title, description}) {
  return Container(
    alignment: Alignment.center,
    width: Get.height / 8,
    height: Get.height / 11,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: const Color(0xff56bece),
    ),
    child: Text.rich(
      TextSpan(children: [
        TextSpan(
          text: "${title}\n",
          style:kHomeWhiteLabelTextStyle,
        ),
        TextSpan(
          text: description,
          style:kHomeLabelTextStyle,
        )
      ]),
      textAlign: TextAlign.center,
    ),
  );
}
