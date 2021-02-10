import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/controller/home_controller.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/genral_screen/on_board.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

//com.codelineInfotech.studentApp
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.native,
      debugShowCheckedModeBanner: false,
      title: 'Codeline Student',
      home: _auth.currentUser != null ? HomePage() : OnBoardPage(),
      // home: Demo(),
    );
  }
}
