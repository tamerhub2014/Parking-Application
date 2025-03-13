import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/widget_utils.dart';
import '../../model/model_category.dart';
import '../../payment/choose_payment_method_screen.dart';
import '../../profile/logout_dailog.dart';

class TabProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabProfile();
  }
}

class _TabProfile extends State<TabProfile> {
  List<ModelCategory> catList = DataFile.getAllCategoryList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpaceFigma(context));

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 30.h),
              child: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: edgeInsets,
                shrinkWrap: true,
                primary: true,
                children: [
                  getVerSpace(50.h),
                  buildProfilePhotoWidget(context),
                  getVerSpace(16.h),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    bloc: ProfileCubit.instance,
                    builder: (context, state) {
                      return Text(
                        state is ProfileSuccess
                            ? state.userModel.name
                            : "No Named",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  getVerSpace(24.h),
                  Divider(
                    color: Color(0xFFF4F4F4),
                    thickness: 1,
                  ),
                  getVerSpace(32.h),
                  buildProfileRowItem(context, "Edit Profile", () {
                    Constant.sendToNext(context, Routes.myProfileScreen);
                  }, "edit_profile.png"),
                  // getVerSpace(20),
                  // buildProfileRowItem(context, "My Vehicles", () {
                  //   Constant.sendToNext(context, Routes.myVehicleScreen);
                  // }, "my_vehicles.png"),
                  getVerSpace(20),
                  buildProfileRowItem(context, "Payment", () {
                    Get.to(() => ChoosePaymentMethodScreen());
                    // Constant.sendToNext(context, Routes.paymentCardScreen);
                  }, "payment.png"),
                  getVerSpace(20),
                  buildProfileRowItem(context, "Help & Support", () {
                    Constant.sendToNext(context, Routes.helpScreen);
                  }, "help.png"),
                  getVerSpace(20),
                  buildProfileRowItem(context, "Privacy Policy", () {
                    // Constant.sendToNext(context, Routes.settingScreen);
                  }, "privacy.png"),
                  getVerSpace(20),
                  buildProfileRowItem(context, "Sign Out", () {
                    Get.dialog(AlertDialog(
                      backgroundColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      insetPadding: const EdgeInsets.only(left: 0),
                      content: LogOutPopupDialog(
                          //   Get.put(
                          //     LogOutPopupController(),
                          //   ),
                          ),
                    ));
                  }, "sign_out.png"),
                  getVerSpace(20),
                ],
              ),
              flex: 1,
            ),
            // getVerSpace(20.h),
            // getButtonFigma(
            //     context, getAccentColor(context), true, "Log out", Colors.black,
            //     () {
            //   Get.bottomSheet(
            //       SizedBox.fromSize(
            //         size: Size(double.infinity, 356.h),
            //         child: getPaddingWidget(
            //             edgeInsets,
            //             Column(
            //               children: [
            //                 getVerSpace(10.h),
            //                 SizedBox(
            //                   width: 40.w,
            //                   child: Divider(
            //                     color: getFontGreyColor(context),
            //                     thickness: 4.h,
            //                   ),
            //                 ),
            //                 getVerSpace(20.h),
            //                 getCustomFont(
            //                   "Log out",
            //                   22,
            //                   getFontColor(context),
            //                   1,
            //                   fontWeight: FontWeight.w600,
            //                 ),
            //                 getVerSpace(20.h),
            //                 Divider(
            //                   thickness: 2.h,
            //                   color: dividerColor,
            //                 ),
            //                 getVerSpace(20.h),
            //                 getMultilineCustomFont(
            //                   "Are you sure you want to logout?",
            //                   18,
            //                   getFontColor(context),
            //                   fontWeight: FontWeight.w500,
            //                 ),
            //                 getVerSpace(20.h),
            //                 getButtonFigma(
            //                     context,
            //                     getAccentColor(context),
            //                     true,
            //                     "Yes, Logout",
            //                     Colors.black,
            //                     () {
            //                       PrefData.setLogIn(false);
            //                       Constant.backToFinish(context);
            //                       Constant.sendToNext(context,Routes.homeRoute);
            //
            //                     },
            //                     EdgeInsets.zero),
            //                 getVerSpace(12.h),
            //                 getButtonFigma(
            //                     context,
            //                     Colors.transparent,
            //                     true,
            //                     "Cancel",
            //                     getFontColor(context),
            //                     () {
            //                       Constant.backToFinish(context);
            //                     },
            //                     EdgeInsets.zero,
            //                     isBorder: true,
            //                     borderColor: getFontColor(context)),
            //                 Expanded(
            //                   child: getVerSpace(0),
            //                   flex: 1,
            //                 )
            //               ],
            //             )),
            //       ),
            //       backgroundColor: getCardColor(context),
            //       shape: RoundedRectangleBorder(
            //         borderRadius:
            //             BorderRadius.vertical(top: Radius.circular(32.h)),
            //       ));
            // }, edgeInsets),
            // getVerSpace(40.h)
          ],
        ),
      ),
    );
  }
}
