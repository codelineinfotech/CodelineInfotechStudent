import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalkingScreen extends StatefulWidget {
  @override
  _WalkingScreenState createState() => _WalkingScreenState();
}

class _WalkingScreenState extends State<WalkingScreen> {
  var homeController = Get.put(HomeContoller());
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          onPageChanged: (value) {
            homeController.splashIndex.value = value;
          },
          controller: pageController,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImagePath.splash1Png,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height / 2,
                    ),
                    Text(
                      'Add Products',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        color: const Color(0xff3a3f44),
                        letterSpacing: 0.24,
                        height: 4.0625,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Capture photos of your products and fill product\nnotes easily and efficient\n',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xff656c80),
                        letterSpacing: 0.16,
                        fontWeight: FontWeight.w500,
                        height: 2.0625,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImagePath.splash2Png,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height / 2,
                    ),
                    Text(
                      'Export\n',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        color: const Color(0xff3a3f44),
                        letterSpacing: 0.24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 370.0,
                      child: Text(
                        'Export your Products into excel or PDF\nCustomized to your needs within one click',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: const Color(0xff656c80),
                          letterSpacing: 0.16,
                          fontWeight: FontWeight.w500,
                          height: 2.0625,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  ImagePath.splash3Png,
                  width: Get.width,
                  fit: BoxFit.fitWidth,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Get.height / 2,
                    ),
                    SizedBox(
                      width: 77.0,
                      child: Text(
                        'Share\n',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          color: const Color(0xff3a3f44),
                          letterSpacing: 0.24,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Send and share your Exported Documents\nanywhere directly from mobile app',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xff656c80),
                        letterSpacing: 0.16,
                        fontWeight: FontWeight.w500,
                        height: 2.0625,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        Obx(() {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAll(SignIn());
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xff898ba5),
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w700,
                      height: 2.55,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: homeController.splashIndex.value == 0
                        ? Color(0xff17A2B8)
                        : Color(0xffC4C7C7),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: homeController.splashIndex.value == 1
                        ? Color(0xff17A2B8)
                        : Color(0xffC4C7C7),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: homeController.splashIndex.value == 2
                        ? Color(0xff17A2B8)
                        : Color(0xffC4C7C7),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (homeController.splashIndex.value == 2) {
                      Get.offAll(SignIn());
                    } else {
                      pageController.animateToPage(
                          homeController.splashIndex.value == 0
                              ? 1
                              : homeController.splashIndex.value == 1
                                  ? 2
                                  : 3,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    }
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xff17a2b8),
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w700,
                      height: 2.55,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        })
      ],
    ));
  }
}
