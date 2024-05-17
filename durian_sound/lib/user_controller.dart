import 'package:get/get.dart';

class UserController extends GetxController {
  RxString username = ''.obs;
  RxString password = ''.obs;

  void setUsername(String value) => username.value = value;
  void setPassword(String value) => password.value = value;
}
