import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/on_board.dart';
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

class MyApp extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
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

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Demo");
    return Material(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Get.to(SecondScreen());
          },
          child: Text("Second Screen"),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Second Screen");
    return Material(
      child: Center(child: TextField()),
    );
  }
}