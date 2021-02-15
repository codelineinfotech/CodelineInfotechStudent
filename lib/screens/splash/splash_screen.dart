import 'package:avatar_glow/avatar_glow.dart';
import 'package:codeline_students_app/screens/genral_screen/on_board.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size _size;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 5), () {
      _firebaseAuth.currentUser != null
          ? Get.off(HomePage())
          : Get.off(OnBoardPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0XFF17A2B8), Color(0XFF0c515c)],
        )),
        child: AvatarGlow(
          glowColor: Color(0xFF68A4AE),
          endRadius: 200.0,
          duration: Duration(milliseconds: 2000),
          repeat: true,
          showTwoGlows: true,
          repeatPauseDuration: Duration(milliseconds: 100),
          child: CircleAvatar(
            radius: _size.width / 3.5,
            backgroundColor: Color(0xffAFD2D8),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/icons/splash_logo.svg",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
