import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/buttons.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/chapter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget chapterDetails(
    {homeController,
    index,
    contexts,
    itemCount,
    DocumentSnapshot doc,
    collection}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 400),
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: EdgeInsets.symmetric(
      horizontal: 10,
    ),
    height: homeController.selectedIndex.value == index
        ? Get.height / 1.3
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
          title: doc.get("title"),
          homeController: homeController,
          index: index,
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
                              title: "Assignment", color: Color(0xff17a2b8)),
                          SizedBox(
                            width: 10,
                          ),
                          outlineButton(
                              title: "Submit", color: Color(0xffCBD0D5)),
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
                        child: Container(
                          height: Get.height / 1.5,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("AdminLang")
                                  .doc(collection)
                                  .collection("Data")
                                  .doc(doc.id)
                                  .collection("Details")
                                  .orderBy("index", descending: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.only(bottom: 50),
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
                                                        ["title"],
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Merriweather',
                                                      fontSize: 14,
                                                      color: const Color(
                                                          0xff1d4777),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.center,
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
                                          index + 1 == snapshot.data.docs.length
                                              ? SizedBox()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      left: Get.height / 40),
                                                  height: Get.height / 20,
                                                  width: 2,
                                                  color: Color(0xffC4C7C7),
                                                ),
                                          index + 1 == snapshot.data.docs.length
                                              ? SizedBox(
                                                  height: Get.height / 10,
                                                )
                                              : SizedBox()
                                        ],
                                      );
                                    },
                                    itemCount: snapshot.data.docs.length,
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox()
      ],
    ),
  );
}
