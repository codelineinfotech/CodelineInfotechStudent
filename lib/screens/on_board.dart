import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'login_register/sign_in.dart';

class OnBoardPage extends StatefulWidget {
  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  @override
  Widget build(BuildContext context) {
    print("ON BOARD");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: Get.height / 1.3,
            decoration: BoxDecoration(),
            child: Image.asset(
              "assets/images/onBoard1.png",
              width: Get.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height / 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  'Welcome to\nCodeLine InfoTech',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 33,
                    color: const Color(0xff3a3f44),
                    letterSpacing: 0.33,
                    fontWeight: FontWeight.w500,
                    height: 1.303030303030303,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () => Get.off(SplashScreen()),
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      width: 346.0,
                      height: 62.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0),
                        color: const Color(0xff17a2b8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x6117a2b8),
                            offset: Offset(0, 10),
                            blurRadius: 40,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 22,
                                color: const Color(0xffffffff),
                                letterSpacing: -0.004400000065565109,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SvgPicture.asset("assets/images/arrow.svg"),
                          )
                        ],
                      )),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(SignIn());
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already Have Account ?",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: const Color(0xff3A3F44),
                          ),
                        ),
                        TextSpan(
                          text: " Sign in",
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: const Color(0xff17a2b8),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height / 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
