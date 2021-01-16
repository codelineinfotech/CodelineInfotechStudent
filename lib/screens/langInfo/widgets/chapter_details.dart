import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/buttons.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/chapter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget chapterDetails({
  homeController,
  int index,
  String title,
  String course,
  sequenceNo,
}) {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(course)
          .doc(title)
          .collection('Topics')
          .orderBy(
            'index',
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: homeController.selectedIndex.value == index
                    ? (Get.height / 100) +
                        (Get.height / 13) +
                        80.0 +
                        (Get.height / 22) +
                        (Get.height / 40) +
                        ((((Get.height / 20) + (Get.height / 20)) *
                                snapshot.data.docs.length) -
                            (Get.height / 20))
                    : Get.height / 10,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    chapterCard(
                      title: title,
                      homeController: homeController,
                      index: index,
                      seuqenceNo: sequenceNo,
                    ),
                    homeController.selectedIndex.value == index
                        ? Expanded(
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      outlineButton(
                                          title: "Assignment",
                                          color: Color(0xff17a2b8)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      outlineButton(
                                          title: "Submit",
                                          color: Color(0xffCBD0D5)),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Current Progress',
                                      style: TextStyle(
                                        fontFamily: 'Merriweather',
                                        fontSize: 23,
                                        color: const Color(0xffa8a8a8),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height / 40,
                                  ),
                                  ZoomIn(
                                    child: ListView.builder(
                                      shrinkWrap: true,

                                      physics: BouncingScrollPhysics(),
                                      // padding: EdgeInsets.only(bottom: 50),
                                      itemBuilder: (contexts, index) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  index == 0
                                                      ? "assets/images/check.svg"
                                                      : "assets/images/nonCheck.svg",
                                                  height: Get.height / 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data.docs[index]
                                                          .get('title'),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Merriweather',
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xff1d4777),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    // Container(
                                                    //   width: Get.width / 1.5,
                                                    //   child: Text(
                                                    //     snapshot.data.docs[index]
                                                    //         ["subtitle"],
                                                    //     style: TextStyle(
                                                    //       fontFamily:
                                                    //           'Merriweather',
                                                    //       fontSize: 7,
                                                    //       color: const Color(
                                                    //           0xffcbd0d5),
                                                    //     ),
                                                    //     textAlign: TextAlign.left,
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            index + 1 ==
                                                    snapshot.data.docs.length
                                                ? SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: Get.height / 40),
                                                    height: Get.height / 20,
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                          ],
                                        );
                                      },
                                      itemCount: snapshot.data.docs.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              ));
        } else {
          return SizedBox();
        }
      });
}
