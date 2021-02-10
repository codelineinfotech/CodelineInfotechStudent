import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContoller extends GetxController {
  RxBool isOpen = false.obs;
  RxBool isLoad = false.obs;
  RxInt selectedIndex = 500.obs;
  RxInt splashIndex = 0.obs;
  RxInt langIndex = 0.obs;

  RxInt cLanguageTopicCount = 0.obs;
  RxInt cLanguageCompleteTopicCount = 0.obs;
  RxInt cppTopicCount = 0.obs;
  RxInt cppCompleteTopicCount = 0.obs;

  RxInt dartTopicCount = 0.obs;
  RxInt dartCompleteTopicCount = 0.obs;

  RxInt flutterTopicCount = 0.obs;
  RxInt flutterCompleteTopicCount = 0.obs;
}
