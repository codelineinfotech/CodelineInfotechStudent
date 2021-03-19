import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeline_students_app/collectionRoute/collection_route.dart';
import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:codeline_students_app/widgets/comman_widget.dart';
import 'package:get/get.dart';

class ContactUsService {

  ValidationController validationController = Get.put(ValidationController());

  Future<void> contactUs({String name, String email, String message}) async {
    cContactUsCollection
        .add({'name': name, 'email': email, 'message': message}).then((value) {
      CommanWidget.snackBar(title: "Contact US",message:"Successfully Send..." ,position: SnackPosition.TOP);

    }).catchError((e) => print("Error ${e.toString()}"));
  }
}
