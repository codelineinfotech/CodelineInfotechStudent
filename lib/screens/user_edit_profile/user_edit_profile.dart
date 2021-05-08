import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UserEditProfile extends StatefulWidget {
  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  Size deviceSize;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController mobileNoTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController courseTextEditingController = TextEditingController();

  String imageUrl, storagePath = "";
  File _image;
  final ValidationController validationController =
      Get.put(ValidationController());
  final HomeContoller _homeContoller = Get.put(HomeContoller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
  }

  getProfileData() {
    cUserCollection.doc(_firebaseAuth.currentUser.uid).get().then((snapshot) {
      nameTextEditingController.text =
          (snapshot["fullName"] as String).capitalize;
      emailTextEditingController.text = snapshot['email'];
      mobileNoTextEditingController.text = snapshot['mobileNo'].toString();
      print("Address -->" + addressTextEditingController.text);
      addressTextEditingController.text = snapshot['address'];
      courseTextEditingController.text =
          snapshot['course'].toString().replaceAll('[', '').replaceAll(']', '');
      imageUrl = snapshot["imageUrl"];
      if (snapshot["storageLocation"] != null &&
          snapshot["storageLocation"] != "") {
        storagePath = snapshot["storageLocation"];
      }
      print("IMAGE URL $imageUrl");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: MyCustomClipar(),
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorsPicker.pista,
                              ColorsPicker.lightPista,
                              ColorsPicker.darkPista
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomRight),
                        // red to yellow
                      ),
                    ),
                  ),
                  Positioned(
                      top: 120,
                      child: Container(
                        width: deviceSize.width / 1.8,
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                nameTextEditingController.text == null ||
                                        nameTextEditingController.text == ""
                                    ? "Name"
                                    : nameTextEditingController.text,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 37,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  emailTextEditingController.text == null ||
                                          emailTextEditingController.text == ""
                                      ? "Email"
                                      : emailTextEditingController.text,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xa5ffffff),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                      right: deviceSize.width / 8,
                      bottom: 20,
                      child: InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: _image == null
                            ? CommanWidget.imageProfileView(
                                imageUrl: imageUrl,
                                imageHeight: 100,
                                imageWidth: 100)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  child: imageUrl != null && imageUrl != ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            child: Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Image.asset(ImagePath.profilePng),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.white, width: 5),
                                  ),
                                ),
                              ),
                        // : CircleAvatar(child: Image.file(_image)),
                      )),
                  Positioned(
                    right: deviceSize.width / 8,
                    bottom: 25,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Icon(
                            Icons.camera_alt,
                            color: ColorsPicker.offWhite,
                          )),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child:
                          Form(key: _formKey, child: editProfileForm(context))))
            ],
          ),
          Obx(() {
            return _homeContoller.isLoad.value == true
                ? CommanWidget.circularProgressBgBlack()
                : Container();
          }),
        ],
      ),
    );
  }

  Widget editProfileForm(BuildContext context) {
    print(
        "Mobile Number ${mobileNoTextEditingController.text.length.toString()}");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),

              ///Name...
              CommanWidget.getTextFormField(
                  labelText: "Full Name",
                  textEditingController: nameTextEditingController,
                  hintText: "Enter Full Name",
                  inputLength: 30,
                  regularExpression: Utility.alphabetSpaceValidationPattern,
                  validationMessage: Utility.nameEmptyValidation,
                  iconPath: ImagePath.userPng),

              ///Email...
              CommanWidget.getTextFormField(
                  labelText: "Email Address",
                  isEnable: false,
                  textEditingController: emailTextEditingController,
                  validationType: Utility.emailText,
                  hintText: "Enter Email Address",
                  inputLength: 50,
                  regularExpression: Utility.emailAddressValidationPattern,
                  validationMessage: Utility.emailEmptyValidation,
                  iconPath: ImagePath.mailPng),

              ///Mobile Number...
              CommanWidget.getTextFormField(
                labelText: "Mobile No",
                textEditingController: mobileNoTextEditingController,
                inputLength: 10,
                regularExpression: Utility.digitsValidationPattern,
                validationMessage: Utility.mobileNumberInValidValidation,
                validationType: 'mobileno',
                hintText: "Enter Mobile No",
                icon: Icons.phone_android_rounded,
              ),

              ///Addresss...
              CommanWidget.getTextFormField(
                labelText: "Address",
                textEditingController: addressTextEditingController,
                inputLength: 100,
                isValidate: false,
                regularExpression: Utility.alphabetDigitsSpaceValidationPattern,
                hintText: "Enter Address",
                icon: Icons.location_on,
              ),

              ///Course Name ...
              CommanWidget.getTextFormField(
                  labelText: "Course Name",
                  isEnable: false,
                  textEditingController: courseTextEditingController,
                  hintText: "Enter Course Name",
                  inputLength: 1,
                  regularExpression: "",
                  validationMessage: "",
                  icon: Icons.book_outlined),

              InkWell(
                onTap: () {
                  updateUserData();
                },
                child: Container(
                    // margin: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.center,
                    height: Get.height / 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      color: const Color(0xff17a2b8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x6117a2b8),
                          offset: Offset(0, 10),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Save",
                        style: kButtonTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateUserData({
    String email,
    String password,
    String fullName,
    String mobileNo,
  }) async {
    if (_formKey.currentState != null) {
      print("FORM CURRENT CALL");
      if (_formKey.currentState.validate()) {
        print("FORM CURRENT CALL VALIDATE");
        _homeContoller.isLoad.value = true;
        if (_image != null) {
          await uploadImage(_image);
          print("UPLOAD SUCCESS023020");
          print("Image URL  $imageUrl");
          print("SAVE STORAGE CALL $storagePath");
          cUserCollection.doc(_firebaseAuth.currentUser.uid).set({
            'fullName': nameTextEditingController.text,
            'mobileNo': mobileNoTextEditingController.text,
            'address': addressTextEditingController.text,
            'imageUrl': imageUrl,
            'storageLocation': storagePath,
          }, SetOptions(merge: true)).then((value) {
            print("SIGNUP SUCCESSFULLY");
            _homeContoller.isLoad.value = false;
            CommanWidget.snackBar(
                title: "Profile Update",
                message: "User Profile Update Successfully",
                position: SnackPosition.TOP);
          }).catchError((e) {
            _homeContoller.isLoad.value = false;
            print('cloud Error ' + _homeContoller.isLoad.value.toString());
          });
        } else {
          print("UPLOAD SUCCESS023020");
          print("Image URL  $imageUrl");
          print("SAVE STORAGE CALL $storagePath");
          cUserCollection.doc(_firebaseAuth.currentUser.uid).set({
            'fullName': nameTextEditingController.text,
            'mobileNo': mobileNoTextEditingController.text,
            'address': addressTextEditingController.text,
            'imageUrl': imageUrl,
            'storageLocation': storagePath,
          }, SetOptions(merge: true)).then((value) {
            print("SIGNUP SUCCESSFULLY");
            _homeContoller.isLoad.value = false;
            // Get.offAll(HomePage());
            CommanWidget.snackBar(
                title: "Profile Update",
                message: "User Profile Update Successfully",
                position: SnackPosition.TOP);
          }).catchError((e) {
            _homeContoller.isLoad.value = false;
            print('cloud Error ' + _homeContoller.isLoad.value.toString());
          });
        }
      } else {
        print('unvalid');
      }
    } else {
      _homeContoller.isLoad.value = false;
      print("Validat Method was call on null");
    }
  }

  uploadImage(File image) async {
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      final _firebaseStorage =
          FirebaseStorage.instanceFor(bucket: Utility.bucketURL);
      String path = 'UserProfilePic/${DateTime.now().microsecondsSinceEpoch}';
      var file = File(image.path);
      if (image != null) {
        if (storagePath != null && storagePath != "") {
          try {
            await _firebaseStorage
                .ref()
                .child(storagePath)
                .delete()
                .catchError((e) => print("DELETE IMAGE ERROR$e"));
            _homeContoller.isLoad.value = true;
            print("Done");
            await Future.delayed(
              Duration(milliseconds: 100),
            );
            var snapshot =
                await _firebaseStorage.ref().child(path).putFile(file);
            String downloadUrl = await snapshot.ref.getDownloadURL();
            storagePath = path;
            imageUrl = downloadUrl;
            print("Download URL  else -->  " + imageUrl);
            print("storagePath  else --> " + storagePath);
            setState(() {});
            // _homeContoller.isLoad.value = false;
          } catch (e) {
            print("ERROR --> ${e.toString()}");
          }
        } else {
          await Future.delayed(
            Duration(milliseconds: 100),
          );
          var snapshot = await _firebaseStorage.ref().child(path).putFile(file);
          String downloadUrl = await snapshot.ref.getDownloadURL();
          storagePath = path;
          imageUrl = downloadUrl;
          print("Download URL  else -->  " + imageUrl);
          print("storagePath  else --> " + storagePath);
          setState(() {});
          // uploadProfile(_firebaseStorage, path, file);
        }
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = image;
      });
      // uploadImage(_image);
    }
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadProfile(
      FirebaseStorage _firebaseStorage, String path, File file) async {
    await Future.delayed(
      Duration(milliseconds: 100),
    );
    var snapshot = await _firebaseStorage.ref().child(path).putFile(file);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    storagePath = path;
    imageUrl = downloadUrl;
    print("Download URL  else -->  " + imageUrl);
    print("storagePath  else --> " + storagePath);
    setState(() {});
    // _homeContoller.isLoad.value = false;
  }
}

class MyCustomClipar extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2 - 50, size.height);
    path.quadraticBezierTo(
        size.width / 2 + 10, size.height, size.width, size.height / 3);

    path.lineTo(size.width, 0);

    // path.lineTo(size.width / 4, size.height / 2);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
