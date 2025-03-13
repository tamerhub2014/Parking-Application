// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class HelpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HelpScreen();
  }
}

class _HelpScreen extends State<HelpScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    return WillPopScope(
        child: Scaffold(
            body: SafeArea(
          child: Column(
            children: [
              getToolbarWidget(context, "Help & Support", () {
                Get.back();
              }),
              Expanded(
                child: ListView(
                  padding: edgeInsets,
                  shrinkWrap: true,
                  children: [
                    getVerSpace(32.h),
                    getMultilineCustomFont(
                        "Contact Information:", 20, getFontColor(context),
                        fontWeight: FontWeight.w700),
                    getVerSpace(8.h),
                    getMultilineCustomFont(
                        "For immediate assistance, feel free to reach out to our dedicated support team. We're here to help!",
                        17,
                        getFontGreyColor(context),
                        fontWeight: FontWeight.w400),
                    getVerSpace(40.h),
                    getMultilineCustomFont(
                        "Customer Support Email:", 20, getFontColor(context),
                        fontWeight: FontWeight.w700),
                    getVerSpace(8.h),
                    getMultilineCustomFont(
                        "estherhoward@gmail.com", 17, getFontGreyColor(context),
                        fontWeight: FontWeight.w400),
                    getVerSpace(40.h),
                    getMultilineCustomFont(
                        "Customer Support Hotline:", 20, getFontColor(context),
                        fontWeight: FontWeight.w700),
                    getVerSpace(8.h),
                    getMultilineCustomFont(
                        "+00 52 5485 2125", 17, getFontGreyColor(context),
                        fontWeight: FontWeight.w400),
                    getVerSpace(40.h),
                    getMultilineCustomFont(
                        "Emergency Assistance:", 20, getFontColor(context),
                        fontWeight: FontWeight.w700),
                    getVerSpace(8.h),
                    getMultilineCustomFont(
                        "In case of emergencies or urgent situations, please call local emergency services.",
                        17,
                        getFontGreyColor(context),
                        fontWeight: FontWeight.w400),
                    getVerSpace(40.h),
                    getMultilineCustomFont(
                        "Get the assistance you need with our Help & Support services. Our dedicated team is here to address your inquiries, resolve issues, and provide guidance whenever you need it",
                        17,
                        getFontColor(context),
                        fontWeight: FontWeight.w400),
                  ],
                ),
                flex: 1,
              )
            ],
          ),
        )),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
