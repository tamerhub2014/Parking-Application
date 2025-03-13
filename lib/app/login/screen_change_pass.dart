import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/login/screen_check_mail.dart';
import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/widget_utils.dart';
import 'controller/change_controller.dart';

class ScreenChangePass extends StatefulWidget {
  const ScreenChangePass({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenChangePass();
  }
}

class _ScreenChangePass extends State<ScreenChangePass> {
  finish() {
    Constant.backToFinish(context);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return getDetailWidget(context, backClick: () {
      finish();
    },
        title: "Change password",
        key: formKey,
        childWidget: getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
            GetBuilder<ChangeController>(
              init: ChangeController(),
              builder: (controller) {
                return ListView(
                  children: [
                    getVerSpace(50.h),
                    getDefaultTextFiled(context,
                        s: "Enter New Password",
                        validator: (password) {
                          if (password!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter new password.';
                          }
                        },
                        sufixImage: controller.isShowPass.value
                            ? "eye_off.svg"
                            : "eye_open.svg",
                        onTap: () {
                          controller.isShowPass.value =
                              !controller.isShowPass.value;
                          controller.update();
                        },
                        obscureText: controller.isShowPass.value,
                        suffixConstraints: BoxConstraints(maxHeight: 56.h),
                        withSufix: true,
                        textEditingController: controller.emailController,
                        textInputAction: TextInputAction.next,
                        fontColor: getFontColor(context)),
                    getVerSpace(30.h),
                    getDefaultTextFiled(context, s: "Enter Confirm Password",
                        validator: (password) {
                      if (password!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Please enter confirm password.';
                      }
                    }, onTap: () {
                      controller.isShowConfirmPass.value =
                          !controller.isShowConfirmPass.value;
                      controller.update();
                    },
                        obscureText: controller.isShowConfirmPass.value,
                        withSufix: true,
                        sufixImage: controller.isShowConfirmPass.value
                            ? "eye_off.svg"
                            : "eye_open.svg",
                        suffixConstraints: BoxConstraints(maxHeight: 56.h),
                        textEditingController: controller.confirmController,
                        fontColor: getFontColor(context)),
                    getVerSpace(50.h),
                    getButtonFigma(context, getAccentColor(context), true,
                        "Reset Password", Colors.white, () {
                      if (formKey.currentState!.validate()) {
                        Constant.sendToScreen(
                            ScreenCheckMail(
                                title: "Password Changed",
                                msg:
                                    "You can now use your new password to\nlog in to your account.",
                                btnText: "Go to home",
                                fun: () {
                                  Constant.sendToNext(
                                      context, Routes.loginRoute);
                                },
                                image: "done.svg"),
                            context);
                      }
                    }, EdgeInsets.zero),
                  ],
                );
              },
            )));
  }
}
