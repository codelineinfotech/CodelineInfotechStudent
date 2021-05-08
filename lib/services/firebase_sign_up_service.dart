import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controller/validation_getx_controller.dart';

class SignUpService {
  final ValidationController validationController =
      Get.put(ValidationController());

  Future<void> signUp(
      {String email,
      String password,
      String fullName,
      String mobileNo,
      BuildContext buildContext}) async {
    kFirebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      cUserCollection.doc(value.user.uid).set({
        'fullName': fullName,
        'email': email,
        'password': password,
        'mobileNo': mobileNo,
        'address': "",
        'imageUrl': "",
        'approval': false,
        'course': ['CLanguage', 'C++', 'Dart', 'Flutter'],
        'percentage': {'CLanguage': 0, 'C++': 0, 'Dart': 0, 'Flutter': 0},
        'storageLocation': ""
      }).then((value) {
        print("SIGNUP SUCCESSFULLY");
        kFirebaseAuth.signOut();
        validationController.progressVisible.value = false;
        CommanWidget.approvalDialog(buildContext);
      }).catchError((e) {
        validationController.progressVisible.value = false;
        print('cloud Error ' +
            validationController.progressVisible.value.toString());
      });
    }).catchError((e) {
      validationController.progressVisible.value = false;

      print('catch Error ' +
          validationController.progressVisible.value.toString());
      print(e);

      CommanWidget.snackBar(
          title: 'Sign Up Failed',
          message: 'Account is Already Exist!',
          position: SnackPosition.BOTTOM);
    });
  }
}
