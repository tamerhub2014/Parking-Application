import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/login/screen_check_mail.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class ScreenForgotPass extends StatefulWidget {
  const ScreenForgotPass({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenForgotPass();
  }
}

class _ScreenForgotPass extends State<ScreenForgotPass> {
  finish() {
    Constant.backToFinish(context);
  }

  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return getDetailWidget(context,backClick:  () {
      finish();
    },
      title:   "Forgot password",key: formKey,
       childWidget:  getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
            ListView(
              children: [
                getVerSpace(50.h),
                getDefaultTextFiled(
                    context, s: "Enter Email", validator: (value) {
                  RegExp regExp = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value!.isEmpty) {
                    return 'Please enter email address.';
                  } else {
                    if (!regExp.hasMatch(value)) {
                      return 'Please enter valid email address.';
                    } else {
                      return null;
                    }
                  }
                },textEditingController:  emailController,fontColor:  getFontColor(context)),
                getVerSpace(50.h),
                getButtonFigma(context, getAccentColor(context), true, "Send",
                    Colors.white, () {
                  if(formKey.currentState!.validate()){
                    Constant.sendToScreen(
                        ScreenCheckMail(
                            title: "Check Your Email",
                            msg:
                            "We have Sent a password recovery\ninstruction to you email",
                            btnText: "Ok",
                            fun: () {
                              Constant.sendToNext(
                                  context, Routes.verifyCodeRoute);
                            },
                            image: "mail.svg"),
                        context);
                  }

                }, EdgeInsets.zero),
                getVerSpace(20.h),
                getButtonFigma(
                    context,
                    Colors.transparent,
                    true,
                    "Back to login",
                    getFontColor(context),
                    () {
                      Get.back();
                    },
                    EdgeInsets.zero,
                    isBorder: true,
                    borderColor: getFontColor(context)),
              ],
            )));
  }
}
