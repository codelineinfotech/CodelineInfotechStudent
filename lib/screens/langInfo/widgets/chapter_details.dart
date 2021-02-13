import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/buttons.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/chapter_card.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../view_more_screen.dart';

bool downloading = false;

String progress = '0';

bool isDownloaded = false;
HomeContoller _homeContoller = Get.put(HomeContoller());
String filename =
    "Assignment" + DateTime.now().millisecondsSinceEpoch.toString();

Widget chapterDetails({
  homeController,
  int index,
  String title,
  String course,
  sequenceNo,
  String assignmentLink,
  String submissionStatus,
}) {
  // print("ASSIGNMENT LINK---> $assignmentLink");

  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(course)
          .doc(title)
          .collection('Topics')
          .orderBy(
            'index',
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print("TOTAL TOPIC LENGTH" + snapshot.data.docs.length.toString());

          return Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: homeController.selectedIndex.value == index
                    ? (Get.height / 100) + //card view top padding....
                        (Get.height / 13) + //sequence number  box height...
                        20 + //
                        Get.height / 22 //assignment button height...
                        +
                        Get.height / 40 //Sized Box
                        +
                        ((Get.height / 15 //veritcal line...
                                +
                                32) *
                            snapshot.data.docs.length) //icon size...
                        //

                        +
                        20 //currewnt progress top padding
                    // 10 +
                    // (Get.height / 22) +
                    // (Get.height / 40) +
                    // ((((Get.height / 23) + (Get.height / 14)) *
                    //     snapshot.data.docs.length))
                    : Get.height / 10,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.16),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    chapterCard(
                      title: title,
                      homeController: homeController,
                      index: index,
                      seuqenceNo: sequenceNo,
                    ),
                    homeController.selectedIndex.value == index
                        ? Expanded(
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('CourseCompletedTopic')
                                      .doc(
                                          FirebaseAuth.instance.currentUser.uid)
                                      .snapshots(),
                                  builder: (context, completeSnapshot) {
                                    if (completeSnapshot.hasData) {
                                      String field = course +
                                          "_" +
                                          title.replaceAll(
                                              new RegExp(r"\s+"), "");
                                      print("COMPLETED TOPIC" + field);
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: StreamBuilder<
                                                    DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection(
                                                        "AssignmentSubmission")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser.uid)
                                                    .snapshots(),
                                                builder: (context,
                                                    snapshotSubmission) {
                                                  if (snapshotSubmission
                                                      .hasData) {
                                                    if (snapshotSubmission
                                                        .data.exists) {
                                                      if ((snapshotSubmission
                                                                  .data
                                                                  .get(
                                                                      'submissionList')
                                                              as List)
                                                          .contains(course)) {
                                                        if ((snapshotSubmission
                                                                    .data
                                                                    .get(
                                                                        '$course')
                                                                as Map)
                                                            .containsKey(
                                                                title)) {
                                                          submissionStatus =
                                                              snapshotSubmission
                                                                  .data
                                                                  .get(
                                                                      '$course.$title.submissionStatus')
                                                                  .toString();
                                                        }
                                                      }
                                                    } else {
                                                      print("ELSE");
                                                    }
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: submissionStatus !=
                                                                      null &&
                                                                  submissionStatus !=
                                                                      "" &&
                                                                  submissionStatus ==
                                                                      'Complete'
                                                              ? outlineButton(
                                                                  title:
                                                                      "Assignment",
                                                                  color: Colors
                                                                      .grey,
                                                                  downloadIcon: Icon(
                                                                      Icons
                                                                          .download_rounded,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .grey),
                                                                  isIcon: true)
                                                              : InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    if (completeSnapshot
                                                                        .data
                                                                        .exists) {
                                                                      if ((completeSnapshot.data.get("${course.toString()}_CourseTopic")
                                                                              as List)
                                                                          .contains(
                                                                              field)) {
                                                                        if (snapshot.data.docs.length ==
                                                                            (completeSnapshot.data[field] as List).length) {
                                                                          downloadFile(
                                                                              assignmentLink,
                                                                              filename);
                                                                        } else {
                                                                          Get.snackbar(
                                                                            "Message",
                                                                            "Assignment is not download until your course topic is not completed",
                                                                            snackPosition:
                                                                                SnackPosition.BOTTOM,
                                                                          );
                                                                        }
                                                                      } else {
                                                                        Get.snackbar(
                                                                          "Message",
                                                                          "Assignment is not download until your course topic is not completed",
                                                                          snackPosition:
                                                                              SnackPosition.BOTTOM,
                                                                        );
                                                                      }
                                                                    } else {
                                                                      Get.snackbar(
                                                                        "Message",
                                                                        "Assignment is not download until your course topic is not completed",
                                                                        snackPosition:
                                                                            SnackPosition.BOTTOM,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: outlineButton(
                                                                      title:
                                                                          "Assignment",
                                                                      color: ColorsPicker
                                                                          .skyColor,
                                                                      downloadIcon: Icon(
                                                                          Icons
                                                                              .download_rounded,
                                                                          size:
                                                                              15,
                                                                          color: ColorsPicker
                                                                              .skyColor),
                                                                      isIcon:
                                                                          true),
                                                                ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: submissionStatus !=
                                                                      null &&
                                                                  submissionStatus !=
                                                                      "" &&
                                                                  submissionStatus ==
                                                                      'Complete'
                                                              ? outlineButton(
                                                                  title:
                                                                      "Assignment ",
                                                                  color: Colors
                                                                      .grey,
                                                                  downloadIcon:
                                                                      Icon(
                                                                    Icons
                                                                        .upload_rounded,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  isIcon: true)
                                                              : InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    print(
                                                                        "UPLOAD CALL");
                                                                    if (completeSnapshot
                                                                        .data
                                                                        .exists) {
                                                                      if ((completeSnapshot.data.get("${course.toString()}_CourseTopic")
                                                                              as List)
                                                                          .contains(
                                                                              field)) {
                                                                        if (snapshot.data.docs.length ==
                                                                            (completeSnapshot.data[field] as List).length) {
                                                                          _openFileExplorer(
                                                                              course,
                                                                              title);
                                                                        } else {
                                                                          Get.snackbar(
                                                                            "Message",
                                                                            "Assignment is not upload until your course topic is not completed",
                                                                            snackPosition:
                                                                                SnackPosition.BOTTOM,
                                                                          );
                                                                        }
                                                                      } else {
                                                                        Get.snackbar(
                                                                          "Message",
                                                                          "Assignment is not upload until your course topic is not completed",
                                                                          snackPosition:
                                                                              SnackPosition.BOTTOM,
                                                                        );
                                                                      }
                                                                    } else {
                                                                      Get.snackbar(
                                                                        "Message",
                                                                        "Assignment is not upload until your course topic is not completed",
                                                                        snackPosition:
                                                                            SnackPosition.BOTTOM,
                                                                      );
                                                                    }
                                                                  },
                                                                  child: outlineButton(
                                                                      title: "Assignment ",
                                                                      color: ColorsPicker.skyColor,
                                                                      downloadIcon: Icon(
                                                                        Icons
                                                                            .upload_rounded,
                                                                        size:
                                                                            15,
                                                                        color: ColorsPicker
                                                                            .skyColor,
                                                                      ),
                                                                      isIcon: true),
                                                                ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child:
                                                                outlineButton(
                                                                    title: submissionStatus !=
                                                                                null &&
                                                                            submissionStatus !=
                                                                                ""
                                                                        ? submissionStatus
                                                                        : "Pending",
                                                                    color: submissionStatus ==
                                                                            'Complete'
                                                                        ? Colors
                                                                            .green
                                                                        : submissionStatus ==
                                                                                'Reject'
                                                                            ? Colors.red
                                                                            : Color(0xffCBD0D5))),
                                                      ],
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(top: 20),
                                            child: Text(
                                              'Current Progress',
                                              style: TextStyle(
                                                fontFamily: 'Merriweather',
                                                fontSize: 23,
                                                color: const Color(0xffa8a8a8),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height / 40,
                                          ),
                                          ZoomIn(
                                            child: ListView.builder(
                                              shrinkWrap: true,

                                              physics: BouncingScrollPhysics(),
                                              // padding: EdgeInsets.only(bottom: 50),
                                              itemBuilder: (contexts, index) {
                                                // print(
                                                //     "SHOW ${course}_CourseTopic");
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SvgPicture.asset(completeSnapshot
                                                                .data.exists
                                                            ? ((completeSnapshot
                                                                            .data['courses']
                                                                        as List)
                                                                    .contains(
                                                                        '${course}_CourseTopic'))
                                                                ? (((completeSnapshot.data['${course}_CourseTopic']
                                                                            as List)
                                                                        .contains(
                                                                            field)))
                                                                    ? (completeSnapshot.data[field] as List).contains(snapshot
                                                                            .data
                                                                            .docs[index]
                                                                            .get('title'))
                                                                        ? "assets/images/check.svg"
                                                                        : "assets/images/nonCheck.svg"
                                                                    : "assets/images/nonCheck.svg"
                                                                : "assets/images/nonCheck.svg"
                                                            : "assets/images/nonCheck.svg"),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        index + 1 ==
                                                                snapshot.data
                                                                    .docs.length
                                                            ? Container()
                                                            : Center(
                                                                child: Container(
                                                                    height: Get.height / 15,
                                                                    width: 1,
                                                                    color: completeSnapshot.data.exists
                                                                        ? ((completeSnapshot.data['courses'] as List).contains('${course}_CourseTopic'))
                                                                            ? (((completeSnapshot.data['${course}_CourseTopic'] as List).contains(field)))
                                                                                ? (completeSnapshot.data[field] as List).contains(snapshot.data.docs[index].get('title'))
                                                                                    ? Colors.green
                                                                                    : Colors.grey
                                                                                : Colors.grey
                                                                            : Colors.grey
                                                                        : Colors.grey),
                                                              ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              Get.width / 1.5,
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                snapshot.data
                                                                    .docs[index]
                                                                    .get(
                                                                        'title'),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Merriweather',
                                                                  fontSize: 14,
                                                                  color: const Color(
                                                                      0xff1d4777),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      "View More Tap Tap");
                                                                  Get.to(
                                                                      ViewMoreScreen(),
                                                                      arguments: snapshot
                                                                          .data
                                                                          .docs[index]);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              3,
                                                                          vertical:
                                                                              3),
                                                                  decoration: BoxDecoration(
                                                                      color: ColorsPicker
                                                                          .skyColor
                                                                          .withOpacity(
                                                                              0.1),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      border: Border.all(
                                                                          color:
                                                                              ColorsPicker.skyColor)),
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Text(
                                                                        "View More",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ColorsPicker.skyColor,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                          child: Text(
                                                            snapshot.data
                                                                .docs[index]
                                                                .get(
                                                                    'subtitle'),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Merriweather',
                                                              fontSize: 12,
                                                              color: const Color(
                                                                  0xff1d4777),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                              itemCount:
                                                  snapshot.data.docs.length,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return CommanWidget.circularProgress();
                                    }
                                  }),
                            ),
                          )
                        : Container()
                  ],
                ),
              ));
        } else {
          return Container();
        }
      });
}

void _openFileExplorer(String courseName, String courseTitle) async {
  print("OPEN FILE EXPLORER");
  String folderName = courseName + "AssignmentSubmission";

  try {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
    File file;
    if (result != null) {
      file = File(result.files.single.path);
      _homeContoller.isLoad.value = true;
    } else {
      // User canceled the picker
    }
    final _firebaseStorage = FirebaseStorage.instanceFor(
        bucket: 'gs://studentapp-a47d3.appspot.com');
    final snapSot = FirebaseFirestore.instance
        .collection("AssignmentSubmission")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) async {
      String storagePath =
          '$folderName/$courseTitle/${FirebaseAuth.instance.currentUser.uid}/${DateTime.now().microsecondsSinceEpoch}';

      if (value.exists) {
        print("SUBMISSION DATA EXISTS IF------------");

        if ((value.get('submissionList') as List).contains(courseName)) {
          print("SUBMISSION LIST IF------------");

          if ((value.get('submissionTopic') as List).contains(courseTitle)) {
            // print("SUBMISSION TOPIC IF-------------");
            String path = value.get('$courseName.$courseTitle.storageLocation');
            // print("PATH-->$path");

            _firebaseStorage.ref().child(path).delete().then((value) {
              print("Done");
              updateFileFireStorage(
                  _firebaseStorage, file, courseName, courseTitle, storagePath);
            }).catchError((e) {
              print("Error ${e.toString()}");
            });
          } else {
            print("SUBMISSION TOPIC ELSE------------");
            updateFileFireStorage(
                _firebaseStorage, file, courseName, courseTitle, storagePath);
          }
        } else {
          _homeContoller.isLoad.value = false;
        }
      } else {
        print("SUBMISSION DATA EXISTS ELSE------------");
        updateFileFireStorage(
            _firebaseStorage, file, courseName, courseTitle, storagePath);
      }
    });
  } on PlatformException catch (e) {
    _homeContoller.isLoad.value = false;

    print("Unsupported operation" + e.toString());
  } catch (ex) {
    _homeContoller.isLoad.value = false;

    print(ex);
  }
}

updateFileFireStorage(FirebaseStorage _firebaseStorage, File file,
    String courseName, String courseTitle, String storagePath) {
  Future.delayed(Duration(milliseconds: 500), () async {
    var snapshot =
        await _firebaseStorage.ref().child(storagePath).putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("AssignmentSubmission")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      '$courseName': {
        '$courseTitle': {
          'submissionStatus': 'Pending',
          'submitAssignment': downloadUrl.toString(),
          'storageLocation': storagePath
        }
      },
      'submissionList': FieldValue.arrayUnion([courseName]),
      'submissionTopic': FieldValue.arrayUnion([courseTitle]),
    }, SetOptions(merge: true));

    _homeContoller.isLoad.value = false;

    Get.snackbar("Uploading Message", "Assignment Upload Successfully");
  });
}

Future<void> downloadFile(uri, fileName) async {
  _homeContoller.isLoad.value = true;

  String savePath = await getFilePath(fileName);
  Dio dio = Dio();
  dio
      .download(
    uri,
    savePath,
    onReceiveProgress: (rcv, total) {},
    deleteOnError: true,
  )
      .then((_) {
    _homeContoller.isLoad.value = false;

    Get.snackbar(
      "Message",
      "Assignment Download Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
    print("File Downloaded");
  }).catchError((e) {
    print("ERROR DOWNLOAD FILE--->${e.toString()}");
    _homeContoller.isLoad.value = false;

    Get.snackbar(
      "Message",
      "Problem Downloading Assignment",
      snackPosition: SnackPosition.BOTTOM,
    );
  });
}
//gets the applicationDirectory and path for the to-be downloaded file

// which will be used to save the file to that path in the downloadFile method

Future<String> getFilePath(uniqueFileName) async {
  String path = '';

  Directory directory;

  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else if (Platform.isAndroid) {
    if (await _requestPermission(Permission.storage)) {
      directory = await getExternalStorageDirectory();
      String newPath = "";
      print(directory);
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/CodeLineStudentApp";
      directory = Directory(newPath);
    }
  }

  path = '${directory.path}/$uniqueFileName.pdf';

  return path;
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

// https://firebasestorage.googleapis.com/v0/b/studentapp-a47d3.appspot.com/o/CLanguageAssignmentSubmission%2FLoops%2Fpac0Mpol5Qbd8Wa6hOjH4EczZKD2%2F1612244590000238?alt=media&token=19c8eedf-5478-4487-a56f-d3dd05294d34
// https://firebasestorage.googleapis.com/v0/b/studentapp-a47d3.appspot.com/o/CLanguageAssignmentSubmission%2FLoops%2Fpac0Mpol5Qbd8Wa6hOjH4EczZKD2%2F1612244590000238?alt=media&token=19c8eedf-5478-4487-a56f-d3dd05294d34
