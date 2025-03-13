import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool isShowPass = true.obs;
}