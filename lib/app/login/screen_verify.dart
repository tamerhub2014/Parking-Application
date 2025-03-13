import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/widget_utils.dart';

class ScreenVerify extends StatefulWidget {
  const ScreenVerify({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScreenVerify();
  }
}

class _ScreenVerify extends State<ScreenVerify> {
  finish() {
    Constant.backToFinish(context);
  }

  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return getDetailWidget(context, backClick: () {
      finish();
    },
        title: "Verification", key: formKey,
        childWidget: getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
            ListView(children: [
              getVerSpace(48),
              Pinput(
                errorText: "Please enter OTP",
                errorTextStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                  color: Color(0xFFE13030),
                ),
                textInputAction: TextInputAction.done,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                disabledPinTheme: PinTheme(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17.sp,
                      color: getFontColor(context),
                    ),
                    padding: EdgeInsets.only(left: 9.h, right: 9.h),
                    decoration: BoxDecoration(color: Color(0xFFFFF3D1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color:getAccentColor(context)))),
                controller: codeController,
                length: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid code";
                  }
                  if (value.length < 6) {
                    return "Please enter a valid code";
                  }
                  return null;
                },
                errorPinTheme: PinTheme(
                  padding: EdgeInsets.only(left: 8.5.h, right: 8.5.h),
                  decoration: BoxDecoration(color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color:Color(0xFFE13030))),
                  textStyle: TextStyle(
                    color: getFontColor(context),
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  width: 52.h,
                  height: 52.h,
                ),
                defaultPinTheme: PinTheme(
                  padding: EdgeInsets.only(left: 8.5.h, right: 8.5.h),
                  width: 52.h,
                  height: 52.h,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24.sp,
                    color: Colors.black,
                  ),
                    decoration: BoxDecoration(color: Color(0xFFFFF3D1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color:getAccentColor(context)))
                ),
              ),
              // PinCodeFields(
              //   length: 6,
              //   fieldBorderStyle: FieldBorderStyle.square,
              //   controller: codeController,
              //   activeBorderColor: getFontSkip(context),
              //   padding: EdgeInsets.zero,
              //   responsive: false,
              //   textStyle: TextStyle(
              //     color: getFontColor(context),
              //     fontSize: 24,
              //     fontFamily: Constant.fontsFamily,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   borderWidth: 1.h,
              //   borderColor: getCurrentTheme(context).focusColor,
              //   borderRadius: BorderRadius.all(Radius.circular(18.h)),
              //   fieldWidth: 50.h,
              //   fieldHeight: 50.h,
              //   onComplete: (result) {},
              // ),
              getVerSpace(50.h),

              getButtonFigma(
                  context,
                  getAccentColor(context),
                  true,
                  "Verify",
                  getFontColor(context), () {
                    if(formKey.currentState!.validate()){

                Constant.sendToNext(context, Routes.changePassRoute);
                    }
              },
                  EdgeInsets.zero),
              getVerSpace(32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustomFont(
                      "Don’t recive code?", 16, getFontGreyColor(context), 1,
                      fontWeight: FontWeight.w600),
                  getCustomFont(" Resend", 16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600)
                ],
              ),
            ])));
  }
}
