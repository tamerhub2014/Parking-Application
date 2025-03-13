// ignore_for_file: deprecated_member_use

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class BookingConfirmation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookingConfirmation();
  }
}

class _BookingConfirmation extends State<BookingConfirmation> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getToolbarWidget(context, "Booking Confirmation", () {}),
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      getVerSpace(30.h),
                      getPaddingWidget(
                          edgeInsets,
                          getCustomFont(
                            "Parking Name",
                            16,
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w600,
                          )),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 20.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        decoration: getButtonDecoration(getCardColor(context),
                            corner: 12.h,
                            shadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      61, 61, 61, 0.11999999731779099),
                                  offset: Offset(-4, 8),
                                  blurRadius: 25)
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomFont("Embassy Coffee Shop", 22,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w600),
                                  getVerSpace(8.h),
                                  Row(
                                    children: [
                                      getSvgImageWithSize(
                                          context, "location.svg", 16.h, 16.h,
                                          fit: BoxFit.fill),
                                      getHorSpace(7.w),
                                      getCustomFont("24, Bilpar Road , Tokoyo",
                                          12, getFontColor(context), 1,
                                          fontWeight: FontWeight.w500)
                                    ],
                                  )
                                ],
                              ),
                              flex: 1,
                            ),
                            getSvgImageWithSize(context, "Logo.svg", 32.h, 44.h,
                                fit: BoxFit.fill)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 40.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        width: double.infinity,
                        decoration:
                            getButtonDecoration(getCardColor(context), shadow: [
                          BoxShadow(
                              color: Color.fromRGBO(
                                  61, 61, 61, 0.11999999731779099),
                              offset: Offset(-4, 8),
                              blurRadius: 25)
                        ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Booking ID:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont("P021412365487", 14,
                                        getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    getCustomFont("Parking Slot:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont("Ground Floor-G08", 14,
                                        getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                )
                              ],
                            ),
                            getVerSpace(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Reserverd Date:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont("January 18,2022", 14,
                                        getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    getCustomFont("Time:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont(
                                        "6:30 PM", 14, getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                )
                              ],
                            ),
                            getVerSpace(20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Vehicle Details:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont("Toyota (AFD 6397)", 14,
                                        getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    getCustomFont("Vehicle Type:", 14,
                                        getFontGreyColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                    getVerSpace(4.h),
                                    getCustomFont("Luxury Sedan", 14,
                                        getFontColor(context), 1,
                                        fontWeight: FontWeight.w500),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20.h),
                              width: double.infinity,
                              decoration: DottedDecoration(
                                  linePosition: LinePosition.bottom),
                            ),
                            getCustomFont(
                                "Cost", 14, getFontGreyColor(context), 1,
                                fontWeight: FontWeight.w500),
                            getVerSpace(4.h),
                            Row(
                              children: [
                                Expanded(
                                  child: getCustomFont("Parking hours (60 min)",
                                      14, getFontColor(context), 1,
                                      fontWeight: FontWeight.w500),
                                  flex: 1,
                                ),
                                getCustomFont(
                                    "\$7", 14, getFontColor(context), 1,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            getVerSpace(4.h),
                            Row(
                              children: [
                                Expanded(
                                  child: getCustomFont(
                                      "Tax", 14, getFontColor(context), 1,
                                      fontWeight: FontWeight.w500),
                                  flex: 1,
                                ),
                                getCustomFont(
                                    "\$3", 14, getFontColor(context), 1,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            getVerSpace(12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: getCustomFont("Total Amount", 16,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w500),
                                  flex: 1,
                                ),
                                getCustomFont(
                                    "\$10", 16, getFontColor(context), 1,
                                    fontWeight: FontWeight.w500)
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 20.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        width: double.infinity,
                        decoration:
                            getButtonDecoration(getCardColor(context), shadow: [
                          BoxShadow(
                              color: Color.fromRGBO(
                                  61, 61, 61, 0.11999999731779099),
                              offset: Offset(-4, 8),
                              blurRadius: 25)
                        ]),
                        child: Row(
                          children: [
                            getSvgImageWithSize(
                                context, "paypal.svg", 30.h, 30.h,
                                fit: BoxFit.fill),
                            getHorSpace(20.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getCustomFont(
                                      "Paypal", 20, getFontColor(context), 1,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.start),
                                  getVerSpace(4.h),
                                  getCustomFont("xxxx xxxx xxxx 5416", 16,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.start)
                                ],
                              ),
                              flex: 1,
                            ),
                            getCustomFont(
                                "Change", 16, getFontColor(context), 1,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.start)
                          ],
                        ),
                      )
                    ],
                  ),
                  flex: 1),
              getButtonFigma(context, getAccentColor(context), true,
                  "Confirm Payment", Colors.black, () {
                // Get.defaultDialog(
                //   // content: Column(
                //   //   children: [
                //   //     getAssetImage(context, "check_img.png", 179.h, 155.h,
                //   //         boxFit: BoxFit.fill)
                //   //   ],
                //   // ),
                //   custom: getCustomFont("etoreitoryty",25,Colors.green,1),
                //   // custom: getAssetImage(context, "check_img.png", 179.h, 155.h,
                //   //     boxFit: BoxFit.fill),
                //   // title: "GeeksforGeeks",
                //   // middleText: "Hello world!",
                //   backgroundColor: Colors.green,
                //   titleStyle: TextStyle(color: Colors.white),
                //   middleTextStyle: TextStyle(color: Colors.white),
                // );
                Get.defaultDialog(
                    title: "",
                    content: Column(
                      children: [
                        Image.asset(
                          Constant.assetImagePath + "check_img.png",
                          width: 179.h,
                          height: 155.h,
                        ),
                        getVerSpace(12.h),
                        getCustomFont(
                            "Successful!", 28, getFontColor(context), 1,
                            fontWeight: FontWeight.w700),
                        getCustomFont(
                            "Successfully made payment for you\nparking",
                            14,
                            getFontColor(context),
                            2,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            txtHeight: 1.5),
                        getVerSpace(20.h),
                        getButtonFigma(context, getAccentColor(context), true,
                            "View Parking Ticket", Colors.black, () {
                          Get.back();
                          Constant.sendToNext(
                              context, Routes.parkingTicketScreen);
                        }, EdgeInsets.zero),
                        getVerSpace(20.h),
                        getButtonFigma(
                          context,
                          Colors.transparent,
                          true,
                          "Cancel",
                          Colors.black,
                          () {
                            Get.back();
                          },
                          EdgeInsets.zero,
                          isBorder: true,
                          borderColor: getFontColor(context),
                        )
                      ],
                    )
                    // content: getAssetImage(context, "check_img.png", 179.h, 155.h,
                    //     boxFit: BoxFit.fill),
                    );
              }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 30.h))
            ],
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}
