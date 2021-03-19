import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


Widget appBar({onMenuTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 20, top: 20),
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
                    ImagePath.bellSvg,
                  ),
                ),
                Positioned(
                  top: 1,
                  right: 2,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: cNotificationCollection
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          int notificationCount = snapshot.data.docs.length;

                          snapshot.data.docs.forEach((element) {
                            if ((element.get('read_user') as List)
                                .contains(kFirebaseAuth.currentUser.uid)) {
                              notificationCount = notificationCount - 1;
                            }
                          });
                          print(
                              "NOTIFICATION COUNT${notificationCount.toString()}");

                          return notificationCount.toString() != '0'
                              ? Container(
                                  alignment: Alignment.center,
                                  height: Get.height / 40,
                                  width: Get.height / 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff26D147), width: 2),
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    notificationCount.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : Container();
                        } else {
                          return Container();
                        }
                      }),
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
                  ImagePath.menuSvg,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
