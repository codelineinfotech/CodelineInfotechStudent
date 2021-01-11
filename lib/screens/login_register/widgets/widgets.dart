import 'package:flutter/material.dart';

Widget bgElements1({deviceWidth}) {
  return Positioned(
    top: 0,
    left: 0,
    child: Container(
      height: deviceWidth * 1.67,
      width: deviceWidth * 1.1,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
        ),
      ),
    ),
  );
}

Widget bgElement2({deviceWidth}) {
  return Positioned(
    bottom: -deviceWidth / 5,
    right: -deviceWidth / 3,
    child: Container(
      height: deviceWidth,
      width: deviceWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/bg2.png",
          ),
        ),
      ),
    ),
  );
}

Widget signLabel({title}) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 38,
      color: Color(0xff3a3f44),
      letterSpacing: 0.38,
      fontWeight: FontWeight.w500,
      height: 1.3421052631578947,
    ),
    textAlign: TextAlign.center,
  );
}
