import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ContactUsService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ValidationController validationController = Get.put(ValidationController());

  Future<void> contactUs({String name, String email, String message}) async {
    _firestore
        .collection("ContactUs")
        .add({'name': name, 'email': email, 'message': message}).then((value) {
      Get.snackbar("Contact US", "Successfully");
    }).catchError((e) => print("Error ${e.toString()}"));
  }
}
