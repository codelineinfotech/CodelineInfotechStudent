import 'package:cloud_firestore/cloud_firestore.dart';
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
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRe_NXx1A5li3embEda5I13HgQO6NNOG7NP5w&usqp=CAU"),
          radius: 30,
        ),
        SizedBox(
          width: 15,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User")
                .doc(_auth.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  (snapshot.data["fullName"] as String).capitalize,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 23,
                    color: const Color(0xff232c42),
                    fontWeight: FontWeight.w500,
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
      ],
    ),
  );
}
