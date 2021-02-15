import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/validation_getx_controller.dart';

class GoogleLoginService {
  final GoogleSignIn _signIn = GoogleSignIn();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ValidationController validationController =
      Get.put(ValidationController());
  Future<void> googleLogin() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _signIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final authResult = await _auth.signInWithCredential(credential);
      if (authResult.user != null) {
        _fireStore.collection('User').doc(authResult.user.uid).set({
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
          'storageLocation': ''
        }).then((value) {
          validationController.progressVisible.value = false;
          // CommanWidget.approvalDialog();

          // Get.snackbar("Message", "Your Registration is Successfully");
          // Get.offAll(SignIn());

          // Get.offAll(HomePage());
        }).catchError((e) => print(e.toString()));
      } else {
        validationController.progressVisible.value = false;
        Get.snackbar('Login Error', 'Login Field Please Try Again!');
      }
    } catch (e) {
      validationController.progressVisible.value = false;
      print(e);
    }
  }
}
