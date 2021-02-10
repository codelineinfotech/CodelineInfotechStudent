import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../login_register/widgets/back_string_button.dart';
import '../login_register/widgets/widgets.dart';

class AboutUsScreen extends StatelessWidget {
  Size deviceSize;

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Material(
      color: ColorsPicker.offWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SafeArea(
              child: backStringButton(
                onTap: () => Navigator.pop(context),
                title: "About Us",
                deviceWidth: deviceSize.width,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
                  // height: deviceSize.height,
                  child: Text(
                    Utility.aboutUs,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
