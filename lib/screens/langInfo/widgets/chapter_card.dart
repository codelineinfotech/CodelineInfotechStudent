import 'dart:math';

import 'package:codeline_students_app/resource/image_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget chapterCard({homeController, index, title, description, seuqenceNo}) {
  return Padding(
    padding: EdgeInsets.only(top: Get.height / 100),
    child: InkWell(
      onTap: () {
        if (homeController.selectedIndex.value == index) {
          homeController.selectedIndex.value = 5000;
        } else {
          homeController.selectedIndex.value = index;
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: Get.height / 13,
            height: Get.height / 13,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  .withOpacity(0.2),
            ),
            child: Text(
              "${seuqenceNo.toString()}",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 25,
                color: const Color(0xffafa823),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: Get.width / 2,
            height: Get.height / 13,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Merriweather',
                fontSize: 16,
                color: const Color(0xff1d4777),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: Get.height / 50),
            child: SvgPicture.asset(homeController.selectedIndex.value == index
                ? ImagePath.downArrowSvg
                : ImagePath.rightArrowSvg),
          )
        ],
      ),
    ),
  );
}
