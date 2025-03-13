// ignore_for_file: deprecated_member_use

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class BookingDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookingDetail();
  }
}

class _BookingDetail extends State<BookingDetail> {
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
              getToolbarWidget(context, "Booking Detail", () {}),
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      getVerSpace(30.h),
                      getPaddingWidget(
                          edgeInsets,
                          getCustomFont(
                            "Parking info",
                            18,
                            getFontColor(context),
                            1,
                            fontWeight: FontWeight.w500,
                          )),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 20.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        decoration: getButtonDecoration(getCardColor(context),
                            corner: 8.h,
                            shadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      61, 61, 61, 0.11999999731779099),
                                  offset: Offset(-4, 8),
                                  blurRadius: 25)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: getCustomFont(
                                      "Booking ID: P02141236548",
                                      16,
                                      getFontColor(context),
                                      1,
                                      fontWeight: FontWeight.w500),
                                  flex: 1,
                                ),
                                getSvgImageWithSize(
                                    context, "copy.svg", 24.h, 24.h)
                              ],
                            ),
                            getVerSpace(12.h),
                            Container(
                              decoration: getButtonDecoration(
                                  greenColor.withOpacity(0.11),
                                  withCorners: true,
                                  corner: 4.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                              child: getCustomFont(
                                  "Parking completed", 12, greenColor, 1,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 20.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        decoration: getButtonDecoration(getCardColor(context),
                            corner: 8.h,
                            shadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      61, 61, 61, 0.11999999731779099),
                                  offset: Offset(-4, 8),
                                  blurRadius: 25)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: getCustomFont("Hillview Hotel MC.", 18,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w500),
                                  flex: 1,
                                ),
                                getSvgImageWithSize(
                                    context, "location.svg", 16.h, 16.h,
                                    color: getFontGreyColor(context)),
                                getHorSpace(4.w),
                                getCustomFont("Vathalia ,Tokoyo", 12,
                                    getFontGreyColor(context), 1,
                                    fontWeight: FontWeight.w500)
                              ],
                            ),
                            getVerSpace(14.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                getSvgImageWithSize(
                                    context, "calendar.svg", 17.h, 17.h),
                                getHorSpace(8.w),
                                getCustomFont("Mon,12 june 9:00 AM", 12,
                                    getFontColor(context), 1,
                                    fontWeight: FontWeight.w500),
                                Expanded(
                                  child: getHorSpace(0),
                                  flex: 1,
                                ),
                                getSvgImageWithSize(
                                    context, "arrow_right.svg", 17.h, 17.h),
                                Expanded(
                                  child: getHorSpace(0),
                                  flex: 1,
                                ),
                                getSvgImageWithSize(
                                    context, "calendar.svg", 17.h, 17.h),
                                getHorSpace(8.w),
                                getCustomFont("Mon,12 june 9:00 AM", 12,
                                    getFontColor(context), 1,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 20.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: horSpace, vertical: 10.h),
                        decoration: getButtonDecoration(getCardColor(context),
                            corner: 8.h,
                            shadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(
                                      61, 61, 61, 0.11999999731779099),
                                  offset: Offset(-4, 8),
                                  blurRadius: 25)
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTotalRow(context, "3 Hours Parking", "\$10"),
                            buildTotalRow(context, "Tax", "\$3"),
                            buildTotalRow(context, "Service fee", "\$0"),
                            getPaddingWidget(
                                EdgeInsets.symmetric(vertical: 8.h),
                                DottedLine(
                                  direction: Axis.horizontal,
                                  lineThickness: 1.h,
                                  dashColor: getFontGreyColor(context),
                                )),
                            buildTotalRow(context, "Total Amount ", "\$13",
                                titleSize: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  flex: 1),
              getButtonFigma(
                  context,
                  getAccentColor(context),
                  true,
                  "Rebook Parking",
                  Colors.black,
                  () {},
                  EdgeInsets.symmetric(horizontal: horSpace, vertical: 30.h))
            ],
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  Widget buildTotalRow(BuildContext context, String title, String subTitle,
      {double titleSize = 14}) {
    return getPaddingWidget(
        EdgeInsets.symmetric(vertical: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: getCustomFont(
                title,
                titleSize,
                getFontColor(context),
                1,
                fontWeight: FontWeight.w500,
              ),
              flex: 1,
            ),
            getCustomFont(
              subTitle,
              14,
              getFontColor(context),
              1,
              fontWeight: FontWeight.w500,
            )
          ],
        ));
  }
}
