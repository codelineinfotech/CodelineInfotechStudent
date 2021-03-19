import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';

import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/validation_getx_controller.dart';

class GoogleLoginService {
  final GoogleSignIn _signIn = GoogleSignIn();

  final ValidationController validationController =
      Get.put(ValidationController());
  Future<void> googleLogin(BuildContext context) async {
    try {
      GoogleSignInAccount googleSignInAccount = await _signIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await kFirebaseAuth.signInWithCredential(credential);
      if (authResult.user != null) {
        print("USER ID${authResult.user.uid.toString()}");
        DocumentSnapshot _userDoc = await cUserCollection
            .doc(authResult.user.uid)
            .get()
            .catchError((e) => print("$e"));
        if (_userDoc.exists) {
          print("IS EXISTS");
          if (_userDoc.get('approval')) {
            print("IS APPROVED");
            validationController.progressVisible.value = false;

            Get.to(HomePage());
          } else {
            print("IS APPROVED ELSE");
            validationController.progressVisible.value = false;

            await kFirebaseAuth.signOut();
            CommanWidget.approvalDialog(context);
          }
        } else {
          print("IS NEW USER");

          cUserCollection.doc(authResult.user.uid).set({
            'fullName': authResult.user.displayName,
            'email': authResult.user.email,
            'password': "",
            'mobileNo': authResult.user.phoneNumber == null
                ? ""
                : authResult.user.phoneNumber,
            'address': "",
            'imageUrl': authResult.user.photoURL,
            'approval': false,
            'course': ['CLanguage', 'C++', 'Dart', 'Flutter'],
            'percentage': {'CLanguage': 0, 'C++': 0, 'Dart': 0, 'Flutter': 0},
            'storageLocation': ""
          }).then((value) {
            validationController.progressVisible.value = false;
            CommanWidget.approvalDialog(context);
          }).catchError((e) => print(e.toString()));
        }
      } else {
        validationController.progressVisible.value = false;

        CommanWidget.snackBar(title: Utility.loginError,message:"Login Field Please Try Again!" ,position: SnackPosition.BOTTOM);

      }
    } catch (e) {
      validationController.progressVisible.value = false;
      print(e);
    }
  }
}
