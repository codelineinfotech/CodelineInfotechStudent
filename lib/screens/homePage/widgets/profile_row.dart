
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

Widget profileRow() {

  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      top: 10,
      bottom: 10,
      right: 20,
    ),
    child: StreamBuilder(
        stream: cUserCollection
            .doc(kFirebaseAuth.currentUser.uid)
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
                            AssetImage(ImagePath.profilePng),
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
