import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';

import 'package:codeline_students_app/screens/login_register/widgets/back_string_button.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'notification_detail_screen.dart';

class NotificationsScreen extends StatelessWidget {
  Size deviceSize;


  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
          stream:
          cNotificationCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: backStringButton(
                            deviceWidth: deviceSize.width,
                            title: "Notification",
                            onTap: () => Navigator.pop(context)),
                      )),
                  Expanded(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data.docs.length,
                        separatorBuilder: (context, index) => Divider(
                              height: 0,
                              color: Colors.black12,
                              thickness: 1,
                            ),
                        itemBuilder: (context, index) {
                          final Timestamp timestamp = snapshot.data.docs[index]
                              .get('time') as Timestamp;
                          final DateTime dateTime = timestamp.toDate();
                          final time =
                              DateFormat.yMMMd().add_jm().format(dateTime);

                          return InkWell(
                            onTap: () {
                              Get.to(NotificationDetails(),
                                  arguments: snapshot.data.docs[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              width: deviceSize.width,
                              color: (snapshot.data.docs[index].get('read_user')
                                          as List)
                                      .contains(kFirebaseAuth.currentUser.uid)
                                  // .contains(_auth.currentUser.uid)
                                  ? Colors.white
                                  : Colors.red[50],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // color: Colors.green,
                                    margin: EdgeInsets.only(top: 15),
                                    child: Icon(
                                      Icons.circle,
                                      color: (snapshot.data.docs[index]
                                                  .get('read_user') as List)
                                              .contains(
                                          kFirebaseAuth.currentUser.uid)
                                          // .contains(_auth.currentUser.uid)
                                          ? Colors.grey
                                          : Colors.red,
                                      size: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Adobe XD layer: 'Profile text slider…' (text)
                                        Text(
                                          snapshot.data.docs[index]
                                              .get('title'),
                                          style: TextStyle(
                                              fontFamily: 'MetropolisLight',
                                              fontSize: 16,
                                              color: const Color(0xff4a4b4d),
                                              height: 1.5,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        // Adobe XD layer: 'Profile text slider…' (text)
                                        Text(
                                          time,
                                          style: TextStyle(
                                            fontFamily: 'Metropolis',
                                            fontSize: 12,
                                            color: const Color(0xffb6b7b7),
                                            fontWeight: FontWeight.w700,
                                            height: 1.75,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else {
              return CommanWidget.circularProgress();
            }
          }),
    );
  }
}
