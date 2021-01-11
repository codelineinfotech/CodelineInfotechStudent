import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContoller extends GetxController {
  RxBool isOpen = false.obs;
  RxInt selectedIndex = 5000.obs;
  RxInt splashIndex = 0.obs;
  RxInt langIndex = 0.obs;
}
