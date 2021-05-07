import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
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

import '../add_course_topic_screen.dart';

Widget buildDrawer(BuildContext context) {

  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height / 10,
        ),

        ///GET CURRENT USER DATA ....
        StreamBuilder(
          stream: cUserCollection
              .doc((kFirebaseAuth.currentUser.uid))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Material(
                    child: ClipRRect(
                      child: Container(
                        height: Get.width / 3,
                        width: Get.width / 3,
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 7),
                        ),
                        child: snapshot.data["imageUrl"] != null &&
                                snapshot.data["imageUrl"] != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: OctoImage(
                                  fit: BoxFit.fill,
                                  imageBuilder:
                                      OctoImageTransformer.circleAvatar(),
                                  image:
                                      NetworkImage(snapshot.data["imageUrl"]),
                                  placeholderBuilder: OctoPlaceholder.blurHash(
                                      'LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                                  errorBuilder:
                                      OctoError.icon(color: Colors.red),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage(ImagePath.profilePng),
                                radius: 25,
                              ),
                      ),
                      borderRadius: BorderRadius.circular(100),
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                    ),
                    elevation: 10,
                    shape: CircleBorder(),
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

          child:  labelWidget(title: 'Edit Profile'),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(FeesReportScreen());
          },
          child:  labelWidget(title: 'Fees Report'),

        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();
            Get.to(NotificationsScreen());
          },
          child: labelWidget(title: 'Notifications'),

        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();
            cUserCollection
                .doc(kFirebaseAuth.currentUser.uid)
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
          child: labelWidget(title: 'Certificate'),
        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(ContactUsScreen());
          },
          child: labelWidget(title: 'Contact US'),


        ),
        customSizedBox(context),

        InkWell(
          onTap: () {
            Get.back();

            Get.to(AboutUsScreen());
          },
          child: labelWidget(title: 'About US'),

        ),
        Spacer(),
        // customSizedBox(context),
        //
        // InkWell(
        //   onTap: () {
        //     Get.back();
        //
        //     Get.to(AddCourseTopic());
        //   },
        //   child: labelWidget(title: 'Add Course'),
        //
        // ),
        // Spacer(),
        InkWell(
          onTap: () {
            kFirebaseAuth.signOut().then((value) => Get.offAll(SignIn()));
          },
          child: labelWidget(title: 'Logout'),

        ),
        SizedBox(
          height: Get.height / 20,
        ),
      ],
    ),
  );
}

labelWidget({String title}) {
  return Padding(
    padding: const EdgeInsets.only(left: 40),
    child: Text(
      title,
      style: kDrawerLabelTextStyle,
      textAlign: TextAlign.center,
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
