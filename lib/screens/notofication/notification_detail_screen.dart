import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/color.dart';

import 'package:codeline_students_app/screens/login_register/widgets/back_string_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationDetails extends StatefulWidget {
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  Size deviceSize;
  String notificationTitle, notificationTime, notificationDescription;
  var data = Get.arguments;


  @override
  void initState() {
    // TODO: implement initState
    notificationTitle = data.get('title');
    notificationDescription = data.get('description');
    final Timestamp timestamp = data.get('time') as Timestamp;
    final DateTime dateTime = timestamp.toDate();

    notificationTime = DateFormat.yMMM().add_jm().format(dateTime);

    cNotificationCollection.doc(data.id).set({
      'read_user': FieldValue.arrayUnion([kFirebaseAuth.currentUser.uid])
    }, SetOptions(merge: true));

    super.initState();
  }

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
                title: "",
                deviceWidth: deviceSize.width,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: deviceSize.width / 1.5,
                        child: Text(
                          notificationTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontFamily: 'Metropolis',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: ColorsPicker.lightGrey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: deviceSize.width / 1.5,
                            child: Text(
                              notificationTime.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorsPicker.lightGrey,
                                fontFamily: 'Metropolis',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(
                        notificationDescription,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 14,
                            color: ColorsPicker.lightGrey),
                      ),
                    ],
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
