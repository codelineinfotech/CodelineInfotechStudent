import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/resource/utility.dart';
import 'package:codeline_students_app/screens/homePage/home_page.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controller/validation_getx_controller.dart';

class FirebaseLoginService {
  final ValidationController validationController =
      Get.put(ValidationController());

  Future<void> firebaseLogin(
      {String email, String password, BuildContext buildContext}) async {
    cUserCollection.where("email", isEqualTo: email).get().then((value) async {
      if (value.docs.length > 0) {
        if (value.docs[0].get("approval")) {
          await kFirebaseAuth
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            Get.offAll(HomePage());
            validationController.progressVisible.value = false;
          }).catchError((e) {
            print(e);
            validationController.progressVisible.value = false;

            CommanWidget.snackBar(
                title: Utility.loginError,
                message: Utility.invalidPasswordMessage,
                position: SnackPosition.BOTTOM);
          });
        } else {
          validationController.progressVisible.value = false;

          CommanWidget.approvalDialog(buildContext);
        }
      } else {
        CommanWidget.snackBar(
            title: Utility.loginError,
            message: Utility.userNotExist,
            position: SnackPosition.BOTTOM);

        validationController.progressVisible.value = false;
      }
    });
  }

  Future<void> firebaseAdminLogin({String email, String password}) async {
    cAdminCollection.where("email", isEqualTo: email).get().then((value) async {
      if (value.docs.length > 0) {
        await kFirebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.offAll(HomePage());
          validationController.progressVisible.value = false;
        }).catchError((e) {
          print(e);
          validationController.progressVisible.value = false;
          CommanWidget.snackBar(
              title: Utility.loginError,
              message: Utility.invalidPasswordMessage,
              position: SnackPosition.BOTTOM);
        });
      } else {
        validationController.progressVisible.value = false;
        CommanWidget.snackBar(
            title: Utility.loginError,
            message: Utility.userNotExist,
            position: SnackPosition.BOTTOM);
      }
    });
  }
}
