import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget appBar({onMenuTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Color(0xff656969),
            ),
            onPressed: () {
              Get.back();
            }),
        Spacer(),
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Get.height / 15,
                  width: Get.height / 15,
                ),
                Container(
                  height: Get.height / 20,
                  width: Get.height / 20,
                  padding: EdgeInsets.all(Get.height / 100),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff26D147), width: 2),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/images/bell.svg",
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 2,
                  child: Container(
                    alignment: Alignment.center,
                    height: Get.height / 40,
                    width: Get.height / 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff26D147), width: 2),
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "3",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: onMenuTap,
              child: Container(
                height: Get.height / 20,
                width: Get.height / 20,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/images/menu.svg",
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
