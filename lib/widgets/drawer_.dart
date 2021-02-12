import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/genral_screen/aboutus_screen.dart';
import 'package:codeline_students_app/screens/genral_screen/certificate_screen.dart';
import 'package:codeline_students_app/screens/genral_screen/contactus_screen.dart';
import 'package:codeline_students_app/screens/fees_report/fees_report_screen.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/screens/notofication/notification_screen.dart';
import 'package:codeline_students_app/screens/user_edit_profile/user_edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

Widget buildDrawer(BuildContext context) {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height / 10,
        ),

        ///GET CURRENT USER DATA ....
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc((_auth.currentUser.uid))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                    height: Get.height / 6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 7),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: snapshot.data["imageUrl"] != null &&
                            snapshot.data["imageUrl"] != ""
                        ? OctoImage(
                            fit: BoxFit.fill,
                            imageBuilder: OctoImageTransformer.circleAvatar(),
                            image: NetworkImage(snapshot.data["imageUrl"]),
                            placeholderBuilder: OctoPlaceholder.blurHash(
                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                            errorBuilder: OctoError.icon(color: Colors.red),
                          )
                        : Image.asset("assets/images/profile.png"),
                  ),
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  Center(
                    child: Text(
                      (snapshot.data["fullName"] as String).capitalize,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 23,
                        color: const Color(0xff232c42),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
        SizedBox(
          height: Get.height / 15,
        ),
        InkWell(
          onTap: () {
            Get.back();
            Get.to(UserEditProfile());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Edit Profile',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(FeesReportScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Fees Report',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();
            Get.to(NotificationsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Notifications',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();
            FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get()
                .then((value) {
              List<String> list = List<String>();
              for (int i = 0; i < (value.get('course') as List).length; i++) {
                print(value['course'][i].toString() +
                    value['percentage.${value.get('course')[i]}'].toString());

                if (value['percentage.${value.get('course')[i]}'] == 100) {
                  list.add(value['course'][i].toString());
                }
              }
              // value.get('completedCourse')
              print(list.toString());
              Get.to(CertificateScreen(), arguments: value);
            }).catchError((e) {
              print("DOWNLOAD CERTIFICATE ERROR--> ${e.toString()}");
            });
            // Get.to(Demo());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Certificate',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(ContactUsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Contact US',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(AboutUsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'About US',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {
            _auth.signOut().then((value) => Get.offAll(SignIn()));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              'Logout',
              style: TextStyle(
                  fontFamily: 'Merriweather',
                  fontSize: 14,
                  color: const Color(0xff1d4777),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: Get.height / 20,
        ),
      ],
    ),
  );
}

Widget customSizedBox(BuildContext context) {
  return Column(
    children: [
      SizedBox(
        height: Get.height / 100,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width / 2,
        child: Divider(
          color: Color(0xffBEE8EF),
          endIndent: 5,
        ),
      ),
      SizedBox(
        height: Get.height / 100,
      ),
    ],
  );
}
