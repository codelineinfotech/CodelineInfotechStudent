import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'resource/utility.dart';

class AddCourseTopic extends StatefulWidget {
  @override
  _AddCourseTopicState createState() => _AddCourseTopicState();
}
class _AddCourseTopicState extends State<AddCourseTopic> {
  Size _deviceSize;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dropdownValue = 'CLanguage',
      downloadUrlDescription = "",
      downloadUrl = "",
      storageLocation = "",
      storageLocationDescription = "";

  TextEditingController _courseTopicController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subTitleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<String> courseList = ['CLanguage', 'C++', 'Dart', 'Flutter'];
  HomeContoller _homeContoller = Get.put(HomeContoller());

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CommanWidget.bgElements1(deviceWidth: _deviceSize.width),
          CommanWidget.bgElement2(deviceWidth: _deviceSize.width),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: SafeArea(
                    child: CommanWidget.backStringButton(
                      onTap: () => Navigator.pop(context),
                      title: "Home",
                      deviceWidth: _deviceSize.width,
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: formWidget(),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return _homeContoller.isLoad.value
                ? CommanWidget.circularProgress()
                : Container();
          }),
        ],
      ),
    );
  }

  Widget sizedBox() {
    return SizedBox(
      height: _deviceSize.width / 25,
    );
  }

  fetchSimpleData() async {
    List _list = new List();
    FirebaseFirestore.instance
        .collection(dropdownValue)

        // .where('topicname', isGreaterThanOrEqualTo: text)
        // .where('topicname', isLessThan: text + 'z')
        .get()
        .then((value) {
      // print("Search Suggetion length -->${value.docs.length.toString()}");
      // _list.add(value.docs);
      value.docs.forEach((element) {
        _list.add(element.get('topicname'));
      });
      print("LIST" + _list.toString());
      return _list;
    }).catchError((e) {
      print("Error---> ${e.toString()}");
    });
  }

  Widget formWidget() {
    String validationMsg = 'Field is required';
    // return Obx(() {
    return Scrollbar(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Topic',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 38,
                color: const Color(0xff3a3f44),
                letterSpacing: 0.38,
                fontWeight: FontWeight.w500,
                height: 1.3421052631578947,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Select Course",
              style: TextStyle(
                fontSize: 16,
                color: ColorsPicker.skyColor,
                fontFamily: 'Robot',
              ),
            ),
            DropdownButton(
              underline: Container(
                height: 1,
                color: ColorsPicker.skyColor,
              ),
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5, left: 10),
                child: RotatedBox(
                  quarterTurns: 75,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorsPicker.skyColor,
                    size: 20,
                  ),
                ),
              ),
              value: dropdownValue,
              items: courseList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
            ),
            Text(
              "Topic Name",
              style: TextStyle(
                fontSize: 16,
                color: ColorsPicker.skyColor,
                fontFamily: 'Robot',
              ),
            ),
            TextFormField(
              onChanged: (text) {
                FirebaseFirestore.instance
                    .collection(dropdownValue)
                    .where('topicname', isGreaterThanOrEqualTo: text)
                    .where('topicname', isLessThan: text + 'z')
                    .get()
                    .then((value) {
                  print(
                      "Search Suggetion length -->${value.docs.length.toString()}");
                }).catchError((e) {
                  print("Error---> ${e.toString()}");
                });
              },
              controller: _courseTopicController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(
                    RegExp(Utility.alphabetDigitsSpecialValidationPattern))
              ],
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorsPicker.skyColor)),
                hintText: 'Enter course topic',
              ),
              validator: (title) => title.isEmpty ? validationMsg : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            sizedBox(),
            Text(
              "Topic Title",
              style: TextStyle(
                fontSize: 16,
                color: ColorsPicker.skyColor,
                fontFamily: 'Robot',
              ),
            ),
            TextFormField(
              controller: _titleController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.allow(
                    RegExp(Utility.alphabetDigitsSpecialValidationPattern))
              ],
              decoration: InputDecoration(
                hintText: 'Enter title',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorsPicker.skyColor)),
              ),
              validator: (title) => title.isEmpty ? validationMsg : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            sizedBox(),
            Text(
              "Topic Sub Title",
              style: TextStyle(
                fontSize: 16,
                color: ColorsPicker.skyColor,
                fontFamily: 'Robot',
              ),
            ),
            TextFormField(
              controller: _subTitleController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
                FilteringTextInputFormatter.allow(
                    RegExp(Utility.alphabetDigitsSpecialValidationPattern))
              ],
              decoration: InputDecoration(
                hintText: 'Enter sub title',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorsPicker.skyColor)),
              ),
              validator: (subTitle) => subTitle.isEmpty ? validationMsg : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            sizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _homeContoller.descriptionFileName.value == ""
                            ? ''
                            : _homeContoller.descriptionFileName.value,
                      ),
                      InkWell(
                        onTap: () {
                          print("ONTAP");
                          if (_courseTopicController.text != null &&
                              _courseTopicController.text != "" &&
                              _titleController.text != null &&
                              _titleController.text != "") {
                            _openFileExplorer(
                                dropdownValue,
                                _courseTopicController.text,
                                _titleController.text,
                                _subTitleController.text,
                                "Description");
                          } else {
                            Get.snackbar("Validation Message",
                                "Topic name and title is required",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          width: _deviceSize.width,
                          decoration: BoxDecoration(
                              color: ColorsPicker.skyColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Robot',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: RotatedBox(
                                    quarterTurns: 75,
                                    child: SvgPicture.asset(
                                        "assets/images/arrow.svg")),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        _homeContoller.assignmentFileName.value == ""
                            ? ''
                            : _homeContoller.assignmentFileName.value,
                      ),
                      InkWell(
                        onTap: () {
                          print("ONTAP");
                          if (_courseTopicController.text != null &&
                              _courseTopicController.text != "" &&
                              _titleController.text != null &&
                              _titleController.text != "") {
                            _openFileExplorer(
                                dropdownValue,
                                _courseTopicController.text,
                                _titleController.text,
                                _subTitleController.text,
                                "assignment");
                          } else {
                            Get.snackbar("Validation",
                                "Topic name and title is required",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          width: _deviceSize.width,
                          decoration: BoxDecoration(
                              color: ColorsPicker.skyColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Assignment',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Robot',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: RotatedBox(
                                    quarterTurns: 75,
                                    child: SvgPicture.asset(
                                        "assets/images/arrow.svg")),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            sizedBox(),
            InkWell(
              onTap: () async {
                if (_formKey.currentState != null) {
                  if (_formKey.currentState.validate()) {
                    if (_homeContoller.descriptionFileName.value != null &&
                        _homeContoller.descriptionFileName.value != "") {
                      _homeContoller.changeLoaderStatus(true);
                      QuerySnapshot _querySnapshot = await FirebaseFirestore
                          .instance
                          .collection(dropdownValue)
                          .doc(_courseTopicController.text)
                          .collection('Topics')
                          .get();
                      FirebaseFirestore.instance
                          .collection(dropdownValue)
                          .doc(_courseTopicController.text)
                          .set({
                        // 'sequence': sequenceNo,
                        'assignment': downloadUrl.toString(),
                        'storageLocation': storageLocation,
                      }, SetOptions(merge: true));

                      FirebaseFirestore.instance
                          .collection(dropdownValue)
                          .doc(_courseTopicController.text)
                          .collection('Topics')
                          .doc()
                          .set({
                        // 'sequence': sequenceNo,
                        'title': _titleController.text,
                        'subtitle': _subTitleController.text,
                        'description': downloadUrlDescription,
                        'storageLocation': storageLocationDescription,
                        'index': _querySnapshot.docs.length + 1,
                      }, SetOptions(merge: true));

                      _homeContoller.changeLoaderStatus(false);
                      Get.snackbar('Message',
                          "Course Topic Add Successfully.",duration: Duration(seconds: 2) );

                      dropdownValue = 'CLanguage';
                      _courseTopicController.clear();
                      _titleController.clear();
                      _subTitleController.clear();
                      _homeContoller.assignmentFileName.value = "";
                      _homeContoller.descriptionFileName.value = "";

                    } else {
                      Get.snackbar(
                          "Message",
                          "Topic Description is required");
                    }
                  } else {
                    print("IN VALID");
                  }
                } else {
                  print("else ");
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: _deviceSize.width,
                decoration: BoxDecoration(
                    color: ColorsPicker.skyColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Robot',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // });
  }

  void _openFileExplorer(String courseName, String courseTopic,
      String courseTitle, String subtitle, String uploadFile) async {
    print("OPEN FILE EXPLORER");
    print(courseName);
    print(courseTitle);
    String folderName = courseName;
    // setState(() => _loadingPath = true);
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
      File file;
      if (result != null) {
        file = File(result.files.single.path);

        final _firebaseStorage = FirebaseStorage.instanceFor(
            bucket: 'gs://studentapp-a47d3.appspot.com');
        FirebaseFirestore.instance
            .collection(courseName)
            .doc(courseTitle)
            .get()
            .then((value) {
          if (value.exists) {
            if (value.get('storageLocation') != null &&
                value.get('storageLocation') != "") {
              String path = value['storageLocation'];
              _firebaseStorage.ref().child(path).delete().then((value) {
                print("Done");
                _homeContoller.changeLoaderStatus(true);

                if (uploadFile == "assignment") {
                  updateFileFireStorageAssignment(_firebaseStorage, file,
                      courseName, courseTopic, folderName, courseTitle);
                } else {
                  updateFileFireStorageDescription(_firebaseStorage, file,
                      courseName, courseTopic, courseTitle, subtitle);
                }
                // Get.snackbar("Uploading Message", "Assignment Upload Successfully");
              }).catchError((e) {
                print("Error ${e.toString()}");
              });
            } else {
              _homeContoller.changeLoaderStatus(true);

              if (uploadFile == "assignment") {
                updateFileFireStorageAssignment(_firebaseStorage, file,
                    courseName, courseTopic, folderName, courseTitle);
              } else {
                updateFileFireStorageDescription(_firebaseStorage, file,
                    courseName, courseTopic, courseTitle, subtitle);
              }
              print("STORAGE LOCATION IS EMPTY");
            }
          } else {
            _homeContoller.changeLoaderStatus(true);

            if (uploadFile == "assignment") {
              updateFileFireStorageAssignment(_firebaseStorage, file,
                  courseName, courseTopic, folderName, courseTitle);
            } else {
              updateFileFireStorageDescription(_firebaseStorage, file,
                  courseName, courseTopic, courseTitle, subtitle);
            }
            print("STORAGE LOCATION IS EMPTY");
          }
        }).catchError((e) {
          _homeContoller.changeLoaderStatus(true);

          if (uploadFile == "assignment") {
            updateFileFireStorageAssignment(_firebaseStorage, file, courseName,
                courseTopic, folderName, courseTitle);
          } else {
            updateFileFireStorageDescription(_firebaseStorage, file, courseName,
                courseTopic, courseTitle, subtitle);
          }
          print("Error---> ${e.toString()}");
        });
        // String path = snapshot.data.docs.get('$courseName.$courseTitle.storageLocation');
        // print("PATH-->$path");
      } else {
        // User canceled the picker
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print("CATCH" + ex.toString());
    }
  }

  updateFileFireStorageAssignment(
      FirebaseStorage _firebaseStorage,
      File file,
      String courseName,
      String courseTopic,
      String folderName,
      String courseTitle) {
    Future.delayed(Duration(milliseconds: 500), () async {
      print("UPLOAD PATH" + file.toString());
      String assignment = "assignment";
      storageLocation =
          '$assignment/$folderName/$courseTitle/${DateTime.now().microsecondsSinceEpoch}';
      var snapshot =
          await _firebaseStorage.ref().child(storageLocation).putFile(file);
      // .onComplete;
      downloadUrl = await snapshot.ref.getDownloadURL();
      QuerySnapshot d =
          await FirebaseFirestore.instance.collection(courseName).get();
      print("LIST LENGTH" + d.docs.length.toString());

      _homeContoller.assignmentFileName.value = courseTopic + '.pdf';

      _homeContoller.changeLoaderStatus(false);

      Get.snackbar("Uploading Message", "Assignment Upload Successfully");
    });
  }

  updateFileFireStorageDescription(
      FirebaseStorage _firebaseStorage,
      File file,
      String courseName,
      String courseTopic,
      String courseTitle,
      String subtitle) {
    print("courseName" + courseName);
    print("courseTopic" + courseTopic);
    print("courseTitle" + courseTitle);
    Future.delayed(Duration(milliseconds: 500), () async {
      print("UPLOAD PATH" + file.toString());
      String description = "Description";
      storageLocationDescription =
          '$description/$courseName/$courseTopic/${DateTime.now().microsecondsSinceEpoch}';
      var snapshot = await _firebaseStorage
          .ref()
          .child(storageLocationDescription)
          .putFile(file);
      // .onComplete;
      downloadUrlDescription = await snapshot.ref.getDownloadURL();
      QuerySnapshot d =
          await FirebaseFirestore.instance.collection(courseName).get();
      print("LIST LENGTH" + d.docs.length.toString());
      // FirebaseFirestore.instance
      //     .collection(courseTopic)
      //     .doc(courseTitle)
      //     .collection('Topics')
      //     .doc()
      //     .set({
      //   // 'sequence': sequenceNo,
      //   'title': courseTitle,
      //   'subtitle': subtitle,
      //   'description': downloadUrlDescription,
      //   'index': 1,
      // }, SetOptions(merge: true));
      _homeContoller.changeLoaderStatus(false);

      _homeContoller.descriptionFileName.value = courseTitle + '.pdf';

      Get.snackbar("Uploading Message", "Description Upload Successfully");
    });
  }
}
