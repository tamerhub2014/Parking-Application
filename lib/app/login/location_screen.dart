import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/services/get_country_and_city_from_location.dart';
import 'package:flutter_parking_ui_new/services/get_current_location.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../base/constant.dart';
import '../../base/color_data.dart';
import '../../base/widget_utils.dart';

// ignore: must_be_immutable
class ScreenCheckMail extends StatefulWidget {
  String? title, msg, btnText, image;
  Function? fun;

  ScreenCheckMail({this.title, this.msg, this.btnText, this.fun, this.image});

  @override
  State<StatefulWidget> createState() {
    return _ScreenForgotPass();
  }
}

class _ScreenForgotPass extends State<ScreenCheckMail> {
  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);

    return BlocListener<ProfileCubit, ProfileState>(
      bloc: ProfileCubit.instance,
      listener: (context, state) {
        if (state is ProfileSuccess) {
          Constant.sendToNext(context, Routes.homeScreenRoute);
        }
      },
      child: Scaffold(
        backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
        appBar: getInVisibleAppBar(),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              horizontal: FetchPixels.getDefaultHorSpaceFigma(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // getVerSpace(10.h),
              // getToolbarIcons(context, "arrow_back.svg", () {}),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getSvgImageWithSize(
                          context, widget.image ?? "", 120.h, 120.h,
                          fit: BoxFit.fill),
                      getVerSpace(20.h),
                      getCustomFont(
                          widget.title ?? "", 28, getFontColor(context), 1,
                          fontWeight: FontWeight.w700),
                      getVerSpace(12.h),
                      getMultilineCustomFont(
                          widget.msg ?? "", 17, getFontGreyColor(context),
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center),
                      getVerSpace(40.h),
                      getButtonFigma(
                        context,
                        getAccentColor(context),
                        true,
                        "Current Location",
                        Colors.white,
                        () async {
                          final Position position = await getUserLocation();
                          final Map<String, String> location =
                              await getCityAndCountry(position);

                          ProfileCubit.instance
                              .updateUser({"location": location});
                        },
                        EdgeInsets.symmetric(horizontal: 50.w),
                      ),
                      // getButtonFigma(context, Colors.transparent, true,
                      //     widget.btnText ?? "", getFontColor(context), () {
                      //   if (widget.fun != null) {
                      //     widget.fun!();
                      //   } else {
                      //     Constant.sendToNext(
                      //         context, Routes.verifyCodeRoute);
                      //   }
                      // }, EdgeInsets.symmetric(horizontal: 50.w),
                      //     isBorder: true, borderColor: getFontColor(context))
                    ],
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
