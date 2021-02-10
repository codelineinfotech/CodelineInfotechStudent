import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/langInfo/widgets/background_elements.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:codeline_students_app/widgets/drawer_.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'widgets/app_bar_.dart';

class ViewMoreScreen extends StatefulWidget {
  @override
  _ViewMoreScreenState createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String remotePDFpath = "", topicTitle = "Title", topicDescriptionUrl = "";
  DocumentSnapshot data;

  @override
  void initState() {
    // TODO: implement initState
/*
    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });*/
    data = Get.arguments;
    topicTitle = data['title'].toString();
    topicDescriptionUrl = data['description'].toString();
    print("DATA " + data['title'].toString());
    print("DATA URL" + data['description'].toString());
    super.initState();
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // final url = "http://www.pdf995.com/samples/pdf.pdf";
      // final url = "http://www.africau.edu/images/default/sample.pdf";
      final url = topicDescriptionUrl;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: buildDrawer(context),
      key: _scaffoldKey,
      body: Stack(
        children: [
          bgElement(),
          Column(
            children: [
              SizedBox(height: Get.height / 30),
              appBar(
                  onMenuTap: () => _scaffoldKey.currentState.openEndDrawer()),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        topicTitle.capitalize,
                        style: TextStyle(
                          fontFamily: 'Helvetica Neue',
                          fontSize: 25,
                          color: const Color(0xff707070),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: FutureBuilder<File>(
                            future: createFileOfPdfUrl(),
                            builder: (context, snapSort) {
                              if (snapSort.hasData) {
                                if (snapSort.data != null &&
                                    snapSort.data.path != null &&
                                    snapSort.data.path != "") {
                                  return Container(
                                    foregroundDecoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.black12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: PDFView(
                                        filePath: snapSort.data.path,
                                        // 'https://firebasestorage.googleapis.com/v0/b/studentapp-a47d3.appspot.com/o/CLanguage%2Fsample-pdf-file.pdf?alt=media&token=d64183b3-7156-4541-8715-73416b0b2632',
                                        enableSwipe: true,
                                        pageFling: false,
                                        fitEachPage: true,
                                        fitPolicy: FitPolicy.WIDTH,
                                        onRender: (_pages) {
                                          setState(() {
                                            // pages = _pages;
                                            // isReady = true;
                                          });
                                        },
                                        onError: (error) {
                                          print(error.toString());
                                        },
                                        onPageError: (page, error) {
                                          print('$page: ${error.toString()}');
                                        },
                                        onViewCreated: (PDFViewController
                                            pdfViewController) {
                                          // _controller.complete(pdfViewController);
                                        },
                                        onPageChanged: (int page, int total) {
                                          print('page change: $page/$total');
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  return Text("Something Went to wrong");
                                }
                              } else {
                                return CommanWidget.circularProgress();
                              }
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
