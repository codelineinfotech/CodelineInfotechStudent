import 'package:get/get.dart';

class ValidationController extends GetxController {
  RxBool forgotPasswordFlag = false.obs;
  RxInt forgotPasswordPageIndex = 0.obs;
  RxBool progressVisible = false.obs;
  RxBool termCondition = false.obs;
  RxBool isLoading = false.obs;
}
