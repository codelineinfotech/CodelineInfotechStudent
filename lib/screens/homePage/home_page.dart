import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/screens/homePage/widgets/app_bar_.dart';
import 'package:codeline_students_app/screens/homePage/widgets/fees_detail.dart';
import 'package:codeline_students_app/screens/homePage/widgets/lang_box.dart';
import 'package:codeline_students_app/screens/homePage/widgets/profile_row.dart';
import 'package:codeline_students_app/screens/langInfo/lang_info.dart';
import 'package:codeline_students_app/style/box_decorations.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:codeline_students_app/widgets/drawer_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeContoller homeController = Get.put(HomeContoller());

  String imageUrl;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    print("HOME PAGE CALL");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: buildDrawer(context),
      body: Stack(
        children: [
          FadeInRight(
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                ImagePath.homeBgSvg,
                height: Get.height / 4,
                width: Get.height / 3,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: Get.height / 30,
              ),
              homeAppBar(onMenuTap: () {
                _scaffoldKey.currentState.openEndDrawer();
              }),
              profileRow(),
              SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      decoration: progressDecoration,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            ImagePath.cbgSvg,
                            height: Get.height / 7.3,
                          ),
                          Column(
                            children: [
                              feesDetails(),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: whiteDecoration,
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 20),
                                            child: Text(
                                              'Course Status',
                                              style: TextStyle(
                                                fontFamily: 'Merriweather',
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xffa8a8a8),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: StreamBuilder<
                                                    DocumentSnapshot>(
                                                stream: cUserCollection
                                                    .doc(
                                                        (kFirebaseAuth.currentUser.uid))
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (Get.height > 800) {
                                                      return _viewAbove800(
                                                          snapshot);
                                                    } else {
                                                      return _viewBelow800(
                                                          snapshot);
                                                    }
                                                  } else {
                                                    return Center(
                                                        child: CommanWidget
                                                            .circularProgress());
                                                  }
                                                })),
                                        Get.height < 800
                                            ? Obx(() {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AnimatedContainer(
                                                        height: 10,
                                                        width: homeController
                                                                    .langIndex
                                                                    .value ==
                                                                0
                                                            ? 25
                                                            : 10,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: homeController
                                                                      .langIndex
                                                                      .value ==
                                                                  0
                                                              ? Color(
                                                                  0xff31AFC3)
                                                              : Colors
                                                                  .grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      AnimatedContainer(
                                                        height: 10,
                                                        width: homeController
                                                                    .langIndex
                                                                    .value ==
                                                                1
                                                            ? 25
                                                            : 10,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        decoration: BoxDecoration(
                                                            color: homeController
                                                                        .langIndex
                                                                        .value ==
                                                                    1
                                                                ? Color(
                                                                    0xff31AFC3)
                                                                : Colors
                                                                    .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      AnimatedContainer(
                                                        height: 10,
                                                        width: homeController
                                                                    .langIndex
                                                                    .value ==
                                                                2
                                                            ? 25
                                                            : 10,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        decoration: BoxDecoration(
                                                            color: homeController
                                                                        .langIndex
                                                                        .value ==
                                                                    2
                                                                ? Color(
                                                                    0xff31AFC3)
                                                                : Colors
                                                                    .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      AnimatedContainer(
                                                        height: 10,
                                                        width: homeController
                                                                    .langIndex
                                                                    .value ==
                                                                3
                                                            ? 25
                                                            : 10,
                                                        duration: Duration(
                                                            milliseconds: 300),
                                                        decoration: BoxDecoration(
                                                            color: homeController
                                                                        .langIndex
                                                                        .value ==
                                                                    3
                                                                ? Color(
                                                                    0xff31AFC3)
                                                                : Colors
                                                                    .grey[300],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                            : SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _viewAbove800(AsyncSnapshot<DocumentSnapshot> snapshot) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      primary: false,
      padding: const EdgeInsets.all(30),
      children: [
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "CLanguage",
                initialValue: snapshot.data.get('percentage.CLanguage'),
                child: Text(
                  'C',
                  style: kCWhiteLabelTextStyle,
                  textAlign: TextAlign.center,
                ),
              ));
            },
            child: langBoxGrid(
              color: Color(0xff84FAB0),
              darkColor: Colors.green,
              title: "C Programming",
              intialValue: snapshot.data.get('percentage.CLanguage').toDouble(),
              child: Text(
                'C',
                style: kCIconTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "C++",
                initialValue: snapshot.data.get('percentage.C++'),
                child: Text(
                  'C++',
                  style: kCPPWhiteLabelTextStyle,
                  textAlign: TextAlign.center,
                ),
              ));
            },
            child: langBoxGrid(
              color: Color(0xff1D4777),
              darkColor: Colors.blue[900],
              title: "C++ Programming",
              intialValue: snapshot.data.get('percentage.C++').toDouble(),
              child: Text(
                'C++',
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "Dart",
                initialValue: snapshot.data.get('percentage.Dart'),
                child: SvgPicture.asset(ImagePath.dartSvg),
              ));
            },
            child: langBoxGrid(
              color: Color(0xffD8FAFF),
              darkColor: Color(0xff17A2B8),
              title: "Dart Dev",
              intialValue: snapshot.data.get('percentage.Dart').toDouble(),
              child: SvgPicture.asset(
                ImagePath.dartSvg,
                width: 15,
                height: 15,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "Flutter",
                child: Image.asset(ImagePath.flutterPng),
                initialValue: snapshot.data.get('percentage.Flutter'),
              ));
            },
            child: langBoxGrid(
              color: Color(0xffC6EEFF),
              darkColor: Colors.blue[900],
              title: "Flutter",
              intialValue: snapshot.data.get('percentage.Flutter').toDouble(),
              child: Image.asset(
                ImagePath.flutterPng,
                width: 15,
                height: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  PageView _viewBelow800(AsyncSnapshot<DocumentSnapshot> snapshot) {
    return PageView(
      physics: BouncingScrollPhysics(),
      onPageChanged: (value) {
        homeController.langIndex.value = value;
      },
      children: [
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "CLanguage",
                initialValue: snapshot.data.get('percentage.CLanguage'),
                child: Text(
                  'C',
                  style: kCWhiteLabelTextStyle,
                  textAlign: TextAlign.center,
                ),
              ));
            },
            child: langBox2(
              color: Color(0xff84FAB0),
              darkColor: Colors.green,
              title: "C Programming",
              intialValue: snapshot.data.get('percentage.CLanguage').toDouble(),
              child: Text(
                'C',
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 24,
                  color: const Color(0xff232c42),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "C++",
                initialValue: snapshot.data.get('percentage.C++'),
                child: Text(
                  'C++',
                  style: kCPPWhiteLabelTextStyle,
                  textAlign: TextAlign.center,
                ),
              ));
            },
            child: langBox2(
              color: Color(0xff1D4777),
              darkColor: Colors.blue[900],
              title: "C++ Programming",
              intialValue: snapshot.data.get('percentage.C++').toDouble(),
              child: Text(
                'C++',
                style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "Dart",
                initialValue: snapshot.data.get('percentage.Dart'),
                child: SvgPicture.asset(ImagePath.dartSvg),
              ));
            },
            child: langBox2(
              color: Color(0xffD8FAFF),
              darkColor: Color(0xff17A2B8),
              title: "Dart Dev",
              intialValue: snapshot.data.get('percentage.Dart').toDouble(),
              child: SvgPicture.asset(ImagePath.dartSvg),
            ),
          ),
        ),
        ZoomIn(
          child: GestureDetector(
            onTap: () {
              Get.to(LangInfo(
                collectionName: "Flutter",
                child: Image.asset(ImagePath.flutterPng),
                initialValue: snapshot.data.get('percentage.Flutter'),
              ));
            },
            child: langBox2(
              color: Color(0xffC6EEFF),
              darkColor: Colors.blue[900],
              title: "Flutter",
              intialValue: snapshot.data.get('percentage.Flutter').toDouble(),
              child: Image.asset(ImagePath.flutterPng),
            ),
          ),
        ),
      ],
    );
  }
}
