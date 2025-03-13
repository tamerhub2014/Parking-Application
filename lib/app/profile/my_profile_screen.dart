import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/login/data/repos/email_auth_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/toast/error_toast.dart';
import '../../base/toast/success_toast.dart';
import '../../base/widget_utils.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyProfileScreen();
  }
}

class ToggleEditController extends GetxController {
  // var isEditEnable = false.obs;
//
//   toggleEditOption() {
//     isEditEnable.toggle();
//   }
}

class _MyProfileScreen extends State<MyProfileScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  static const String passwordTextPlaceHolder = "12345678910";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ToggleEditController controller = Get.put(ToggleEditController());
  TextEditingController nameCon = TextEditingController(
      text: ProfileCubit.instance.user?.name ?? "Un Named");
  TextEditingController emailCon = TextEditingController(
      text: ProfileCubit.instance.user?.email ?? "No Email");

  TextEditingController passCon =
      TextEditingController(text: passwordTextPlaceHolder);

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Edit Profile", () {
              Get.back();
            }),
            getVerSpace(32),
            Expanded(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: edgeInsets,
                  shrinkWrap: true,
                  primary: true,
                  children: [
                    getVerSpace(15.h),
                    getDefaultTextFiledEditPage(context, validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                        s: "Enter Name",
                        label: "Name",
                        textEditingController: nameCon,
                        textInputAction: TextInputAction.next),
                    getVerSpace(24),
                    getDefaultTextFiledEditPage(
                      context,
                      textInputAction: TextInputAction.next,
                      s: "Enter Email",
                      label: "Email",
                      validator: (value) {
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
                      textEditingController: emailCon,
                      enabled: false,
                    ),
                    getVerSpace(24),
                    getDefaultTextFiledEditPage(context,
                        textInputAction: TextInputAction.done,
                        s: "Enter Password",
                        label: "Password", validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password.';
                      } else {
                        RegExp regExp =
                            RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
                        if (!regExp.hasMatch(value) &&
                            value != passwordTextPlaceHolder) {
                          return 'Password must be at least 8 characters long and include at least one letter and one number.';
                        }
                      }
                      return null;
                    }, obscureText: true, textEditingController: passCon),
                    getVerSpace(30),
                    // buildTextFieldWidget(context, nameCon),
                    // buildTextFieldWidget(context, emailCon),
                    // buildTextFieldWidget(context, numberCon),
                    // buildTextFieldWidget(context, passCon, isPass: true),
                    getButtonFigma(context, getAccentColor(context), true,
                        "Save", Colors.black, () async {
                      if (formKey.currentState!.validate()) {
                        if (nameCon.text != ProfileCubit.instance.user?.name) {
                          ProfileCubit.instance
                              .updateUser({"name": nameCon.text});
                        }

                        if (passCon.text != passwordTextPlaceHolder) {
                          final result =
                              await AuthService().updatePassword(passCon.text);

                          if (result) {
                            showSuccessToast("Password updated successfully");
                          } else {
                            showErrorToast("Password was NOt updated");
                          }
                        }

                        Get.back();
                      }
                    }, EdgeInsets.zero)
                  ],
                ),
              ),
              flex: 1,
            ),
            getVerSpace(40.h)
          ],
        ),
      ),
      // body: GetBuilder<ToggleEditController>(
      //   init: ToggleEditController(),
      //   builder: (controller) {
      //     return ;
      //   },
      // ),
    );
  }

// Widget buildTextFieldWidget(
//     BuildContext context, TextEditingController _controller,
//     {bool isPass = false}) {
//   return Obx(() => getPaddingWidget(
//       EdgeInsets.symmetric(vertical: 15.h),
//       Column(
//         children: [
//           TextField(
//             controller: _controller,
//             enabled: controller.isEditEnable.isTrue,
//             readOnly: controller.isEditEnable.isFalse,
//             obscureText: isPass,
//             style: buildTextStyle(
//                 context, getFontColor(context), FontWeight.w500, 16),
//             decoration: InputDecoration(
//                 isDense: true,
//                 disabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(width: 1.h, color: dividerColor)),
//                 hintStyle: buildTextStyle(
//                     context, getFontColor(context), FontWeight.w500, 16),
//                 contentPadding: EdgeInsets.only(bottom: 15.h),
//                 focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                         width: 1.h, color: getAccentColor(context))),
//                 border: UnderlineInputBorder(
//                     borderSide: BorderSide(width: 1.h, color: dividerColor))),
//           )
//         ],
//       )));
// }
}
