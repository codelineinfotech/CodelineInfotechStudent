import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/screens/user_edit_profile/user_edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildDrawer() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return Drawer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height / 10,
        ),
        Container(
          height: Get.height / 6,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 7),
            image: DecorationImage(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRe_NXx1A5li3embEda5I13HgQO6NNOG7NP5w&usqp=CAU"),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.16),
                offset: Offset(0, 3),
                blurRadius: 6,
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.height / 30,
        ),

        ///GET CURRENT USER DATA ....
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc((_auth.currentUser.uid))
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
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
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: Get.height / 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            'Fees Report',
            style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 14,
              color: const Color(0xff1d4777),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Get.height / 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            'Notifications',
            style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 14,
              color: const Color(0xff1d4777),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Get.height / 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            'Certificate',
            style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 14,
              color: const Color(0xff1d4777),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Get.height / 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            'Contact US',
            style: TextStyle(
              fontFamily: 'Merriweather',
              fontSize: 14,
              color: const Color(0xff1d4777),
            ),
            textAlign: TextAlign.center,
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
              ),
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
