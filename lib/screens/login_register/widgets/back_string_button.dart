import 'package:flutter/material.dart';

Widget backStringButton({deviceWidth, title, onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
            // color: Color(0xff17a2b8),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              color: Color(0xba000000),
              letterSpacing: 0.44,
              height: 1.2727272727272727,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}
