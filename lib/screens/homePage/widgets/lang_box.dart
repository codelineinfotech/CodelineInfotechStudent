import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

Widget langBox({color, title, darkColor, intialValue, child}) {
  return Stack(
    children: [
      Container(
          padding: EdgeInsets.only(top: Get.height / 40),
          height: Get.height / 6,
          width: Get.height / 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: const Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x29000000),
                offset: Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SleekCircularSlider(
                  initialValue: intialValue,
                  appearance: CircularSliderAppearance(
                      customColors: CustomSliderColors(
                          trackColor: Colors.blueGrey,
                          progressBarColors: [
                            darkColor,
                            color,
                          ]),
                      size: Get.height / 10),
                  onChange: null),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 10,
                  color: const Color(0xff232c42),
                ),
              ),
            ],
          )),
      Container(
        alignment: Alignment.center,
        height: Get.height / 20,
        width: Get.height / 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
          color: color,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: child,
      ),
    ],
  );
}

Widget langBox2({color, title, darkColor, intialValue, child}) {
  return Container(
      width: Get.width,
      margin: EdgeInsets.only(
          top: Get.height / 60,
          left: Get.height / 20,
          right: Get.height / 20,
          bottom: Get.height / 60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 1),
            blurRadius: 10,
          ),
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SleekCircularSlider(
                      initialValue: intialValue,
                      appearance: CircularSliderAppearance(
                          infoProperties: InfoProperties(
                              mainLabelStyle: TextStyle(
                                  color: color,
                                  fontSize: 25,
                                  fontFamily: "Merriweather")),
                          startAngle: 270,
                          angleRange: 360,
                          animationEnabled: true,
                          customWidths: CustomSliderWidths(
                              trackWidth: 16, progressBarWidth: 16),
                          customColors: CustomSliderColors(
                              hideShadow: true,
                              trackColor: Color(0xffE4EBEB),
                              progressBarColors: [
                                color,
                                color,
                              ]),
                          size: Get.height / 5),
                      onChange: null),
                  SizedBox(
                    height: Get.height / 100,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Merriweather',
                      fontSize: 20,
                      color: const Color(0xff232c42),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              alignment: Alignment.center,
              height: Get.height / 10,
              width: Get.height / 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
                color: color,
                boxShadow: [
                  // BoxShadow(
                  //   color: const Color(0x29000000).withOpacity(0.5),
                  //   offset: Offset(0, 3),
                  //   blurRadius: 6,
                  // ),
                ],
              ),
              child: child,
            ),
          ),
        ],
      ));
}
