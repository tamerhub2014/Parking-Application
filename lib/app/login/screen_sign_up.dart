// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import 'controller/sign_up_controller.dart';
import 'location_screen.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenSignUp();
  }
}

class _ScreenSignUp extends State<ScreenSignUp> {
  // finish() {
  //   Constant.backToFinish(context);
  // }

  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: getDetailWidget(context, backClick: () {
        () {
          Get.back();
        };
      }, title: "Sign Up", key: formKey, childWidget: buildList(context)),
    );
  }

  Widget buildList(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      bloc: ProfileCubit.instance,
      listener: (context, state) {
        if (state is ProfileSuccess) {
          Constant.sendToScreen(
              ScreenCheckMail(
                  title: "What is Your Location",
                  msg:
                      "We need to know your location to\nsuggest nearby parking",
                  btnText: "Ok",
                  fun: () {},
                  image: "location.svg"),
              context);
          // Constant.sendToNext(context, Routes.homeScreenRoute);
        }
      },
      child: Column(
        children: [
          GetBuilder<SignUpController>(
            init: SignUpController(),
            builder: (controller) {
              return Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
                  shrinkWrap: true,
                  primary: true,
                  children: [
                    getVerSpace(32.h),
                    getDefaultTextFiled(textInputAction: TextInputAction.next,
                        validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter name';
                      }
                      return null;
                    }, context,
                        s: "Enter Name",
                        textEditingController: controller.fullNameController,
                        fontColor: getFontColor(context)),
                    getVerSpace(24.h),
                    getDefaultTextFiled(validator: (value) {
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
                    },
                        textInputAction: TextInputAction.next,
                        context,
                        s: "Enter Email",
                        textEditingController: controller.emailController,
                        fontColor: getFontColor(context)),
                    getVerSpace(24.h),
                    getDefaultTextFiled(
                        textInputAction: TextInputAction.next,
                        context,
                        s: "Enter Password", validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }, onTap: () {
                      controller.isShowPass.value =
                          !controller.isShowPass.value;
                      controller.update();
                    },
                        withSufix: true,
                        suffixConstraints: BoxConstraints(maxHeight: 56.h),
                        sufixImage: controller.isShowPass.value
                            ? "eye_off.svg"
                            : "eye_open.svg",
                        obscureText: controller.isShowPass.value,
                        textEditingController: controller.passwordController,
                        fontColor: getFontColor(context)),
                    getVerSpace(24.h),
                    getDefaultTextFiled(
                        textInputAction: TextInputAction.done,
                        context,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter confirm password';
                          }
                          return null;
                        },
                        withSufix: true,
                        suffixConstraints: BoxConstraints(maxHeight: 56.h),
                        obscureText: controller.isShowConfirmPass.value,
                        sufixImage: controller.isShowConfirmPass.value
                            ? "eye_off.svg"
                            : "eye_open.svg",
                        onTap: () {
                          controller.isShowConfirmPass.value =
                              !controller.isShowConfirmPass.value;
                          controller.update();
                        },
                        s: "Enter Confirm Password",
                        textEditingController: controller.confirmPassController,
                        fontColor: getFontColor(context)),
                    getVerSpace(56.h),
                    getButtonFigma(context, getAccentColor(context), true,
                        "Sign Up", Colors.white, () {
                      if (formKey.currentState!.validate()) {
                        ProfileCubit.instance.signUpWithEmail(
                            controller.fullNameController.text,
                            controller.emailController.text,
                            controller.passwordController.text);
                      }
                    }, EdgeInsets.zero),
                  ],
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getCustomFont(
                  "Already have an account?", 17, getFontGreyColor(context), 1,
                  fontWeight: FontWeight.w400, textAlign: TextAlign.center),
              InkWell(
                onTap: () {
                  Get.back();
                  // Constant.sendToNext(context,Routes.loginRoute);
                },
                child: getCustomFont(" Log In", 17, getFontColor(context), 1,
                    fontWeight: FontWeight.w700, textAlign: TextAlign.center),
              )
            ],
          ),
          getVerSpace(20.h),
        ],
      ),
    );
  }
}
