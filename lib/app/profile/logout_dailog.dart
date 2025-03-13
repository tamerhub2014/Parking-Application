import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/pref_data.dart';
import '../routes/app_routes.dart';

// ignore: must_be_immutable
class LogOutPopupDialog extends StatelessWidget {
  LogOutPopupDialog({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign Out',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.sp,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to Sign Out?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7D7D7D),
                fontSize: 17.sp,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 157.h,
                      height: 40.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.h),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ProfileCubit.instance.logOut();

                      Get.toNamed(Routes.loginRoute);
                    },
                    child: Container(
                      width: 157.h,
                      height: 40.h,
                      decoration: ShapeDecoration(
                        color: accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
