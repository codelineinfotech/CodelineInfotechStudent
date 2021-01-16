import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/screens/login_register/sign_in.dart';
import 'package:codeline_students_app/widgets/circularprogress.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../controller/validation_getx_controller.dart';

class SignUpService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final ValidationController validationController =
      Get.put(ValidationController());

  Future<void> signUp({
    String email,
    String password,
    String fullName,
  }) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("SIGNUP SUCCESSFULLY ");
      print("full name $fullName");
      print("email $email");
      print("Password $password");

      _fireStore.collection('User').doc(value.user.uid).set({
        'fullName': fullName,
        'email': email,
        'password': password,
        'approval': false,
      }).then((value) {
        print("SIGNUP SUCCESSFULLY");
        _auth.signOut();
        validationController.progressVisible.value = false;
        CircularProgress.circularProgress();

        Get.offAll(SignIn());
      }).catchError((e) {
        // validationController.updateWidget();

        validationController.progressVisible.value = false;
        print('cloud Error ' +
            validationController.progressVisible.value.toString());
      });
    }).catchError((e) {
      validationController.progressVisible.value = false;

      print('catch Error ' +
          validationController.progressVisible.value.toString());
      print(e);
      Get.snackbar('Sign Up Failed', 'Account is Already Exist!');
    });
  }
}
