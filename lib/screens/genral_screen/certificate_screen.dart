import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/resource/color.dart';
import 'package:codeline_students_app/resource/constant.dart';
import 'package:codeline_students_app/resource/image_path.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/background_elements.dart';
import 'package:codeline_students_app/screens/login_register/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../login_register/widgets/back_string_button.dart';

class CertificateScreen extends StatefulWidget {
  @override
  _CertificateScreenState createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  Size deviceSize;
  DocumentSnapshot userData;

  ScreenshotController _screenshotController = ScreenshotController();

  String certificateHtml = "";

  Dio dio = Dio();
  String studentName, courseName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData = Get.arguments;
    getCertificateHTML();
  }

  void getCertificateHTML() {
    studentName = (userData["fullName"] as String).capitalize;

    certificateHtml =
        """<div style="width:800px; height:600px; padding:20px; text-align:center; border: 10px solid #787878">
  <div style="width:750px; height:550px; padding:20px; text-align:center; border: 5px solid #787878">
  <span style="font-size:50px; font-weight:bold">Certificate of Completion</span>
  <br>Flutter<br>
  <span style="font-size:25px"><i>This is to certify that</i></span>
  <br><br>
  <span style="font-size:30px"><b>$studentName</b></span><br/><br/>
  <span style="font-size:25px"><i>has completed the course</i></span> <br/><br/>
  <span style="font-size:30px">$courseName</span> <br/><br/>
  <span style="font-size:20px"><b>Good Performance</b></span> <br/><br/><br/><br/>
  <span style="font-size:25px"><i>Date</i></span><br>
  <span style="font-size:30px">${DateFormat.yMMMMd().format(DateTime.now())}</span>
  </div>
  </div>""";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Material(
      color: ColorsPicker.offWhite,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          bgElements1(deviceWidth: deviceSize.width),
          bgElement2(deviceWidth: deviceSize.width),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SafeArea(
                    child: backStringButton(
                      onTap: () => Navigator.pop(context),
                      title: "",
                      deviceWidth: deviceSize.width,
                    ),
                  ),
                ),
                Text(
                  'Certificate',
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
                Screenshot(
                  controller: _screenshotController,
                  child: Container(
                    width: deviceSize.width,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: deviceSize.height / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://p7.hiclipart.com/preview/470/15/832/the-colored-aristocracy-of-st-louis-wedding-invitation-the-pencil-of-nature-clip-art-border-frame-thumbnail.jpg",
                            ),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Html(data: certificateHtml)],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    /* bool downloaded = await downloadCertificate(certificateHtml,
                        "Student Name${DateTime.now().millisecondsSinceEpoch}");
                    if (downloaded) {
                      Get.snackbar(
                        "Message",
                        "Certificate Download Successfully",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      print("File Downloaded");
                    } else {
                      Get.snackbar(
                        "Message",
                        "Problem Downloading Certificate",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      print("Problem Downloading File");
                    }*/
                  },
                  child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      alignment: Alignment.center,
                      width: Get.width,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "Download",
                              style:kButtonTextStyle,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // Spacer(),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child:
                                  SvgPicture.asset(ImagePath.arrowSvg),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> downloadCertificate(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
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
        } else {
          return false;
        }
      }
      else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
            url, directory.path, fileName);
        print("GENRATED FILE ${generatedPdfFile.path}");
        if (Platform.isIOS) {
          Directory directoryIos = await getApplicationDocumentsDirectory();

          var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
              url, directoryIos.path, fileName);
          print("GENRATED FILE ${generatedPdfFile.path}");
          print("GENRATED FILE ${directoryIos.path}");
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
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

  Widget bgElement2({deviceWidth}) {
    return Positioned(
      bottom: -deviceWidth / 5,
      right: -deviceWidth / 3,
      child: Container(
        height: deviceWidth,
        width: deviceWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
             ImagePath.bg2Png,
            ),
          ),
        ),
      ),
    );
  }
}
