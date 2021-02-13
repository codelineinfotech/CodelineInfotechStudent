import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

Widget profileRow() {
  FirebaseAuth _auth = FirebaseAuth.instance;
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      top: 10,
      bottom: 10,
      right: 20,
    ),
    child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("User")
            .doc(_auth.currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                snapshot.data["imageUrl"] != null &&
                        snapshot.data["imageUrl"] != ""
                    ? CommanWidget.imageProfileView(
                        imageUrl: snapshot.data["imageUrl"].toString(),
                        imageHeight: 70,
                        imageWidth: 70,
                        decoration: "NoDecoration")
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/profile.png"),
                        radius: 25,
                      ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  (snapshot.data["fullName"] as String).capitalize,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 23,
                    color: const Color(0xff232c42),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        }),
  );
}
