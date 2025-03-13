// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/login/location_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';
import 'controller/login_controller.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenLogin();
  }
}

class _ScreenLogin extends State<ScreenLogin> {
  finish() {
    Constant.closeApp();
  }

  ValueNotifier<bool> isShowPass = ValueNotifier(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return WillPopScope(
      onWillPop: () async {
        finish();
        return true;
      },
      child: getDetailWidget(context, backClick: () {
        finish();
      }, title: "Login", key: formKey, childWidget: buildList(context)),
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
        }
      },
      child: Column(
        children: [
          GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
                  shrinkWrap: true,
                  primary: true,
                  children: [
                    getVerSpace(30.h),
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
                    getVerSpace(30.h),
                    getDefaultTextFiled(
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter password';
                          }
                        },
                        textInputAction: TextInputAction.done,
                        context,
                        obscureText: controller.isShowPass.value,
                        onTap: () {
                          controller.isShowPass.value =
                              !controller.isShowPass.value;
                          controller.update();
                        },
                        s: "Enter Password",
                        // constraints: BoxConstraints(maxHeight: 0.h),
                        suffixConstraints: BoxConstraints(maxHeight: 56.h),
                        withSufix: true,
                        sufixImage: controller.isShowPass.value
                            ? "eye_off.svg"
                            : "eye_open.svg",
                        textEditingController: controller.passController,
                        fontColor: getFontColor(context)),
                    getVerSpace(20.h),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Constant.sendToNext(context, Routes.forgotPassRoute);
                        },
                        child: getCustomFont(
                            "Forgot Password?", 17, getFontColor(context), 1,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.end),
                      ),
                    ),
                    getVerSpace(50.h),
                    getButtonFigma(context, getAccentColor(context), true,
                        "Log In", Colors.white, () {
                      if (formKey.currentState!.validate()) {
                        ProfileCubit.instance.loginWithEmail(
                            controller.emailController.text,
                            controller.passController.text);
                      }
                    }, EdgeInsets.zero),
                    getVerSpace(40.h),
                    SizedBox(
                      width: double.infinity,
                      child: getCustomFont(
                          "Or Login With", 17, getFontColor(context), 1,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center),
                    ),
                    getVerSpace(40.h),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    GestureDetector(
                      onTap: () {
                        ProfileCubit.instance.loginWithGoogle();
                      },
                      child: Container(
                        width: 139.w,
                        height: 46.h,
                        decoration: getButtonDecoration(
                          getCardColor(context),
                          withCorners: true,
                          corner: 23.h,
                          shadow: [
                            BoxShadow(
                              color: Color(0x1E000000),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getSvgImageWithSize(
                                context, "Google.svg", 20.h, 20.h,
                                fit: BoxFit.fill),
                            getHorSpace(11.h),
                            getCustomFont(
                                "Google", 17, getFontColor(context), 1,
                                fontWeight: FontWeight.w400)
                          ],
                        ),
                      ),
                    ),
                    //   getHorSpace(30.h),
                    //   Container(
                    //     width: 139.w,
                    //     height: 46.h,
                    //     decoration: getButtonDecoration(
                    //       getCardColor(context),
                    //       withCorners: true,
                    //       corner: 23.h,
                    //       shadow: [
                    //         BoxShadow(
                    //           color: Color(0x1E000000),
                    //           blurRadius: 6,
                    //           offset: Offset(0, 2),
                    //           spreadRadius: 0,
                    //         )
                    //       ],
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         getSvgImageWithSize(
                    //             context, "Facebook.svg", 20.h, 20.h,
                    //             fit: BoxFit.fill),
                    //         getHorSpace(11.h),
                    //         getCustomFont(
                    //             "Facebook", 17, getFontColor(context), 1,
                    //             fontWeight: FontWeight.w400)
                    //       ],
                    //     ),
                    //   ),
                    //   // Expanded(
                    //   //   child: getButtonFigma(context, Colors.white, true, "Google",
                    //   //       getFontColor(context), () {}, EdgeInsets.zero,
                    //   //       isIcon: true,
                    //   //       icons: "google.svg",
                    //   //       withGradient: false,
                    //   //       shadow: [
                    //   //         BoxShadow(
                    //   //             color: Colors.black.withOpacity(0.05),
                    //   //             blurRadius: 8,
                    //   //             spreadRadius: 2)
                    //   //       ]),
                    //   //   flex: 1,
                    //   // ),
                    //   // getHorSpace(FetchPixels.getDefaultHorSpaceFigma(context)),
                    //   // Expanded(
                    //   //   child: getButtonFigma(context, Colors.white, true, "Facebook",
                    //   //       getFontColor(context), () {}, EdgeInsets.zero,
                    //   //       isIcon: true,
                    //   //       icons: "facebook.svg",
                    //   //       withGradient: false,
                    //   //       shadow: [
                    //   //         BoxShadow(
                    //   //             color: Colors.black.withOpacity(0.05),
                    //   //             blurRadius: 8,
                    //   //             spreadRadius: 2)
                    //   //       ]),
                    //   //   flex: 1,
                    //   // ),
                    // ]),
                    // ),
                    getVerSpace(80.h),
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
                  "Don’t have an account? ", 17, getFontGreyColor(context), 1,
                  textAlign: TextAlign.start, fontWeight: FontWeight.w500),
              InkWell(
                onTap: () {
                  Constant.sendToNext(context, Routes.signUpRoute);
                },
                child: getCustomFont("Sign Up", 17, getFontColor(context), 1,
                    textAlign: TextAlign.start, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          getVerSpace(24)
        ],
      ),
    );
  }
}
