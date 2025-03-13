import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeController extends GetxController{
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  RxBool isShowPass = true.obs;
  RxBool isShowConfirmPass = true.obs;
}