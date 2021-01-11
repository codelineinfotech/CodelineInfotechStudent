import 'package:animate_do/animate_do.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/screens/homePage/widgets/app_bar_.dart';
import 'package:codeline_students_app/screens/homePage/widgets/fees_detail.dart';
import 'package:codeline_students_app/screens/homePage/widgets/lang_box.dart';
import 'package:codeline_students_app/screens/homePage/widgets/profile_row.dart';
import 'package:codeline_students_app/screens/langInfo/lang_info.dart';
import 'package:codeline_students_app/style/box_decorations.dart';
import 'package:codeline_students_app/widgets/drawer_.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeController = Get.put(HomeContoller());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: buildDrawer(),
      body: Stack(
        children: [
          FadeInRight(
            child: Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                "assets/images/homeBg.svg",
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
                            "assets/images/cbg.svg",
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
                                            padding: const EdgeInsets.all(20),
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
                                            child: PageView(
                                          physics: BouncingScrollPhysics(),
                                          onPageChanged: (value) {
                                            homeController.langIndex.value =
                                                value;
                                          },
                                          children: [
                                            ZoomIn(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(LangInfo(
                                                    collectionName: "CLanguage",
                                                    initialValue: 29,
                                                    child: Text(
                                                      'C',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Merriweather',
                                                        fontSize: 28,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                },
                                                child: langBox2(
                                                  color: Color(0xff84FAB0),
                                                  darkColor: Colors.green,
                                                  title: "C Programming",
                                                  intialValue: 29.0,
                                                  child: Text(
                                                    'C',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Merriweather',
                                                      fontSize: 24,
                                                      color: const Color(
                                                          0xff232c42),
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
                                                    collectionName: "C++Lang",
                                                    initialValue: 80,
                                                    child: Text(
                                                      'C++',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Merriweather',
                                                        fontSize: 24,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ));
                                                },
                                                child: langBox2(
                                                  color: Color(0xff1D4777),
                                                  darkColor: Colors.blue[900],
                                                  title: "C++ Programming",
                                                  intialValue: 80.0,
                                                  child: Text(
                                                    'C++',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Merriweather',
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
                                                    initialValue: 75,
                                                    child: SvgPicture.asset(
                                                        "assets/images/dart.svg"),
                                                  ));
                                                },
                                                child: langBox2(
                                                  color: Color(0xffD8FAFF),
                                                  darkColor: Color(0xff17A2B8),
                                                  title: "Dart Dev",
                                                  intialValue: 75.0,
                                                  child: SvgPicture.asset(
                                                      "assets/images/dart.svg"),
                                                ),
                                              ),
                                            ),
                                            ZoomIn(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Get.to(LangInfo(
                                                    collectionName: "Flutter",
                                                    child: Image.asset(
                                                        "assets/images/flutter.png"),
                                                    initialValue: 10,
                                                  ));
                                                },
                                                child: langBox2(
                                                  color: Color(0xffC6EEFF),
                                                  darkColor: Colors.blue[900],
                                                  title: "Flutter",
                                                  intialValue: 10.0,
                                                  child: Image.asset(
                                                      "assets/images/flutter.png"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                        Obx(() {
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                  decoration: BoxDecoration(
                                                    color: homeController
                                                                .langIndex
                                                                .value ==
                                                            0
                                                        ? Color(0xff31AFC3)
                                                        : Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
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
                                                          ? Color(0xff31AFC3)
                                                          : Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                          ? Color(0xff31AFC3)
                                                          : Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                                                          ? Color(0xff31AFC3)
                                                          : Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
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
}
