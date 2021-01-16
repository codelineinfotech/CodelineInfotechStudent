import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/widgets/circularprogress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/validation_getx_controller.dart';

class FirebaseLoginService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValidationController validationController =
      Get.put(ValidationController());
  Future<void> firebaseLogin({String email, String password}) async {
    // CircularProgress.circularProgress();

    FirebaseFirestore.instance
        .collection("User")
        .where("email", isEqualTo: email)
        .get()
        .then((value) async {
      if (value.docs.length > 0) {
        if (value.docs[0].get("approval")) {
          await _auth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            Get.offAll(HomePage());
            validationController.progressVisible.value = false;
            // CircularProgress.circularProgress();
          }).catchError((e) {
            print(e);
            validationController.progressVisible.value = false;
            Get.snackbar('Login Error',
                "The password is invalid or the user does not have a password.");
            // CircularProgress.circularProgress();
          });
        } else {
          validationController.progressVisible.value = false;
          // CircularProgress.circularProgress();

          Get.defaultDialog(
            title: "Alert !",
            radius: 10,
            content: Text(
              "Your Account is not Approved By Codeline Infotech.\n Please Contact Codeline Infotech",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xff17a2b8)),
            ),
          );
        }
      } else {
        validationController.progressVisible.value = false;

        Get.snackbar('Login Error', 'User Not Exists !');
      }
    });
  }
}
