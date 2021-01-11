import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> signUp({
    String email,
    String password,
    String fullName,
  }) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => _fireStore.collection('User').doc(value.user.uid).set({
              'fullName': fullName,
              'email': email,
              'password': password,
              'approval': false,
            }).then((value) {
              _auth.signOut();
              validationController.progressVisible.value = false;
              Get.offAll(SignIn());
            }).catchError((e) {
              validationController.progressVisible.value = false;
              print('cloud Error $e');
            }))
        .catchError((e) {
      validationController.progressVisible.value = false;
      print(e);
      Get.snackbar('Sign Up Failed', 'Account is Already Exist!');
    });
  }
}
