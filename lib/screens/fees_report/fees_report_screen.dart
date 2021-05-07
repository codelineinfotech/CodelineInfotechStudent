import 'dart:io';


import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/screens/user_edit_profile/user_edit_profile.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


class FeesReportScreen extends StatefulWidget {
  @override
  _FeesReportScreenState createState() => _FeesReportScreenState();
}

class _FeesReportScreenState extends State<FeesReportScreen> {
  Size deviceSize;
  String feesStatus = "Complate",
      studentName = "",
      studentEmailId = "",
      studentProfile = "";

  @override
  void initState() {
    // TODO: implement initState
    getProfileData();
    super.initState();
  }

  getProfileData() {
    cUserCollection
        .doc(kFirebaseAuth.currentUser.uid)
        .get()
        .then((snapshot) {
      studentName = snapshot["fullName"].toString().capitalizeFirst;
      studentEmailId = snapshot['email'];

      studentProfile = snapshot["imageUrl"];
      print("IMAGE URL $studentProfile");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipar(),
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorsPicker.pista,
                      ColorsPicker.lightPista,
                      ColorsPicker.darkPista
                    ], begin: Alignment.topCenter, end: Alignment.bottomRight),
                    // red to yellow
                  ),
                ),
              ),
              Positioned(
                  top: 120,
                  child: Container(
                    width: deviceSize.width / 1.8,
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            studentName == null || studentName == ""
                                ? "Name"
                                : studentName,
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 37,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              studentEmailId == null || studentEmailId == ""
                                  ? "Email"
                                  : studentEmailId,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                color: const Color(0xa5ffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                right: deviceSize.width / 8,
                bottom: 20,
                child: CommanWidget.imageProfileView(
                    imageUrl: studentProfile,
                    imageHeight: 100,
                    imageWidth: 100),
              )
            ],
          ),
          feesReportList(context),
        ],
      ),
    );
  }

  Widget feesReportList(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              height: 170,
              width: deviceSize.width,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: deviceSize.width / 2.5,
                          decoration: BoxDecoration(
                            color: ColorsPicker.skyColor.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Instalment ${(index + 1).toString()}',
                              style: TextStyle(
                                fontSize: 19,
                                fontFamily: "ProximaNova",
                                color: const Color(0xff1d4777),
                                letterSpacing: -0.003800000056624412,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start Date : ',
                                    style: kTitleTextStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    '28 / 02 / 2021',
                                    style: kDateTextStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  width: deviceSize.width / 2.35,
                                  child: Divider(color: Colors.grey)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Due Date : ',
                                    style: kTitleTextStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    '02 / 03 / 2021',
                                    style: kDateTextStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Status',
                          style: kStatusTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          feesStatus,
                          style: TextStyle(
                            fontFamily: 'Proxima Nova',
                            fontSize: 20,
                            color: feesStatus == "Pending"
                                ? Color(0xffffc400)
                                : feesStatus == "Late"
                                    ? Colors.red
                                    : Colors.green,
                            letterSpacing: -0.004000000059604644,
                            // fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ColorsPicker.skyColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
