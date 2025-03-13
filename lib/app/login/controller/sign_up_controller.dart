import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  RxBool isShowPass = true.obs;
  RxBool isShowConfirmPass = true.obs;
}