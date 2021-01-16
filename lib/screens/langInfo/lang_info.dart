import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/app_bar_.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/background_elements.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/chapter_details.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/progress_container.dart';
import 'package:codeline_students_app/style/box_decorations.dart';
import 'package:codeline_students_app/widgets/drawer_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangInfo extends StatefulWidget {
  int initialValue;
  Widget child;
  String collectionName;

  LangInfo({this.initialValue, this.child, this.collectionName});

  @override
  _LangInfoState createState() => _LangInfoState();
}

class _LangInfoState extends State<LangInfo> {
  final homeController = Get.put(HomeContoller());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: buildDrawer(),
      body: Stack(children: [
        bgElement(),
        Column(children: [
          SizedBox(height: Get.height / 30),
          appBar(onMenuTap: () => _scaffoldKey.currentState.openEndDrawer()),
          SizedBox(height: 10),
          Expanded(
            child: Stack(children: [
              Container(
                alignment: Alignment.topLeft,
                decoration: progressDecoration,
                child: Stack(children: [
                  bgElement2(),
                  Column(children: [
                    progressContainer(
                        collection: widget.collectionName,
                        intialValue: widget.initialValue,
                        child: widget.child),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Align(
                          alignment: Alignment.bottomCenter,

                          ///GET PARENT COLLATION
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(widget.collectionName)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        // print(snapshot.data.docs[index].id);
                                        return FadeInLeft(
                                          duration: Duration(milliseconds: 400),
                                          child: chapterDetails(
                                            course: widget.collectionName,
                                            title: snapshot.data.docs[index].id,
                                            index: index,
                                            homeController: homeController,
                                            sequenceNo: snapshot
                                                .data.docs[index]
                                                .get("sequence"),
                                          ),
                                        );
                                      });
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              })),
                    ))
                  ]),
                ]),
              )
            ]),
          )
        ]),
      ]),
    );
  }
}
