import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/services/get_country_and_city_from_location.dart';
import 'package:flutter_parking_ui_new/services/get_current_location.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/pref_data.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  checkLogin() async {
    bool isLogin = await PrefData.isLogIn();
    bool isFirst = await PrefData.isIntroAvailable();
    print("chkval===$isLogin===$isFirst");
    Timer(
      const Duration(seconds: 3),
      () {
        (isLogin)
            ? Constant.sendToNext(context, Routes.homeScreenRoute)
            : (isFirst)
                ? Constant.sendToNext(context, Routes.introRoute)
                : Constant.sendToNext(context, Routes.loginRoute);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkLogin();

    Future.sync(() async {
      final Position position = await getUserLocation();
      final Map<String, String> location = await getCityAndCountry(position);

      ProfileCubit.instance.updateUser({"location": location});
    });

    // PrefData.isLogIn().then((value) {
    //   Timer(
    //     const Duration(seconds: 1),
    //     () {
    //       (value)
    //           ? Constant.sendToNext(context, Routes.homeScreenRoute)
    //           : Constant.sendToNext(context, Routes.introRoute);
    //     },
    //   );
    // });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    // FetchPixels(context);
    Constant.setupSize(context);

    return Scaffold(
      // appBar: getInVisibleAppBar(color: yellowBgColor),
      backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: getAssetImage(context, "logo.png", 184.h, 153.h,
                  boxFit: BoxFit.fill)),
          //   Expanded(
          //       child: Container(
          //     decoration: BoxDecoration(
          //         color: yellowBgColor,
          //         borderRadius:
          //             BorderRadius.only(bottomRight: Radius.circular(80.h))),
          //     width: double.infinity,
          //     height: double.infinity,
          //     child: ClipRRect(
          //       borderRadius:
          //           BorderRadius.only(bottomRight: Radius.circular(80.h)),
          //       child: getAssetImage(context, "welcomeScreen.png",
          //           double.infinity, double.infinity,
          //           boxFit: BoxFit.fill),
          //     ),
          //   )),
          //   getVerSpace(37.h),
          //   getPaddingWidget(
          //       edgeInsets,
          //       getCustomFont("Welcome to", 44, getFontColor(context), 1,
          //           fontWeight: FontWeight.w400,
          //           fontFamily: Constant.fontsFamilySansita)),
          //   getVerSpace(8.h),
          //   getPaddingWidget(
          //       edgeInsets,
          //       getCustomFont(
          //         "Parking",
          //         44,
          //         accentColor,
          //         1,
          //         fontWeight: FontWeight.w600,
          //       )),
          //   getVerSpace(8.h),
          // getPaddingWidget(edgeInsets,   getMultilineCustomFont(
          //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ",
          //     14,
          //     getFontColor(context),
          //     fontWeight: FontWeight.w500)),
          //   getVerSpace(50.h),
        ],
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImageWithSize(context, "Logo.svg", 154.h, 172.h,
            fit: BoxFit.fill),
      ],
    );
  }
}
