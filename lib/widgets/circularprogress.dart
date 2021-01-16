import 'package:codeline_students_app/controller/validation_getx_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircularProgress {
  static ValidationController validationController =
      Get.put(ValidationController());

  static Widget circularProgress() {
    print("CIRCULAR PROGRESS" +
        validationController.progressVisible.value.toString());
    return Container(
      color: Colors.black38,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
