import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../data/data_file.dart';
import '../model/model_notification.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<ModelNotification> notificationList = DataFile.getAllNotification();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    return Scaffold(
        body: SafeArea(
          child: Column(
                    children: [
          getToolbarWidget(context, "Notification", () {Get.back();}),
          getVerSpace(32),
                      notificationList.isNotEmpty? Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                ModelNotification modelNotification = notificationList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getPaddingWidget(
                        EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        getCustomFont(modelNotification.date, 16,
                            getFontColor(context), 1,
                            fontWeight: FontWeight.w600)),
                    getVerSpace(7.h),
                    Column(
                      children: List.generate(
                          modelNotification.detailList.length, (index1) {
                        NotificationDetail detail =
                            modelNotification.detailList[index1];
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.h),
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top: 20.h),
                                child: Row(children: [
                                  getAssetImage(context, detail.image, 48.h, 48.h),
                                  getHorSpace(20.w),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getCustomFont(detail.title, 16,
                                            getFontColor(context), 1,
                                            fontWeight: FontWeight.w600),
                                        getVerSpace(4.h),
                                        getCustomFont(detail.desc, 14,
                                            getFontGreyColor(context), 1,
                                            fontWeight: FontWeight.w500)
                                      ],
                                    ),
                                    flex: 1,
                                  )
                                ]),
                              ),
                              getVerSpace(20),
                              notificationList[index]==2?SizedBox():Divider(height: 1,        color: Color(0xFFE6E6E6),
                              thickness: 1,),
                            ],
                          ),
                        );
                      }),
                    ),
                    getVerSpace(7.h),
                  ],
                );
              },
              itemCount: notificationList.length,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              shrinkWrap: true,
            ),
            flex: 1,
          ):Expanded(
            child: Column(crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,children: [
                            Center(child: getAssetImage(context, "notificationEmpty.png", 120, 120)),
                            getVerSpace(24),
                            Text(
                              'No Notifications Yet!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 28.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            getVerSpace(12),
                            Text(
                              'No notifications at this moment',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF7D7D7D),
                                fontSize: 17.sp,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],),
          ),
                    ],
                  ),

        ));
  }
}
