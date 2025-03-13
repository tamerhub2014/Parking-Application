// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingScreen();
  }
}

class _SettingScreen extends State<SettingScreen> {
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
            body: Column(
          children: [
            getToolbarWidget(context, "Settings", () {}),
            Expanded(
              child: ListView(
                padding: edgeInsets,
                shrinkWrap: true,
                children: [
                  getVerSpace(30.h),
                  buildProfileRowItem(context, "Help & Support", () {
                    Constant.sendToNext(context, Routes.helpScreen);
                  },"sign_out.png"),
                  buildProfileRowItem(context, "Privacy Policy", () {},"sign_out.png"),
                  buildProfileRowItem(context, "Language", () {},"sign_out.png"),
                  buildProfileRowItem(context, "Terms & Condition", () {},"sign_out.png"),
                  buildProfileRowItem(context, "Security", () {},"sign_out.png"),
                ],
              ),
              flex: 1,
            )
          ],
        )),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
