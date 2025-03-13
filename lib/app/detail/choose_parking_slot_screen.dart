// import 'package:dotted_border/dotted_border.dart';
// ignore_for_file: deprecated_member_use

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';

import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';

import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../data/data_file.dart';
import '../home/data/models/parking_ticket_body.dart';
import '../model/model_slot_detail.dart';

class ChooseParkingSlotScreen extends StatefulWidget {
  final ParkingTicketBody parkingTicket;

  const ChooseParkingSlotScreen({super.key, required this.parkingTicket});

  @override
  State<StatefulWidget> createState() {
    return _ChooseParkingSlotScreen();
  }
}

class _ChooseParkingSlotScreen extends State<ChooseParkingSlotScreen> {
  List<String> getFloorList = DataFile.getAllFloorList();

  finish() {
    Constant.backToFinish(context);
  }

  int selectedPos = 0;
  List<ModelSlotDetail> slotList1 = DataFile.getAllSlotList();
  List<ModelSlotDetail> slotList2 = DataFile.getAllSlotSecList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getToolbarWidget(context, "Pick Your Parking Slot", () {
                  Get.back();
                }),
                getVerSpace(25),
                Expanded(
                    child: getPaddingWidget(
                  edgeInsets,
                  getAssetImage(context, "parking_slot.png", double.infinity,
                      double.infinity),
                )),
                // Expanded(
                //   // child: Container(),
                //   child: Container(
                //     width: double.infinity,
                //     height: double.infinity,
                //     // child: Container(),
                //     child: ListView(
                //       shrinkWrap: true,
                //       primary: true,
                //       // mainAxisSize: MainAxisSize.min,
                //       padding: EdgeInsets.zero,
                //       children: [
                //         getVerSpace(20.h),
                //         Container(
                //           width: double.infinity,
                //           padding: EdgeInsets.symmetric(
                //               horizontal:
                //                   FetchPixels.getDefaultHorSpaceFigma(context)),
                //           height: 40.h,
                //           child: ListView.separated(separatorBuilder: (context, index) => SizedBox(width: 10.w,),
                //               itemBuilder: (context, index) {
                //                 return GestureDetector(
                //                   onTap: () {
                //                     setState(() {
                //                       selectedPos = index;
                //                     });
                //                   },
                //                   child: Container(
                //                     height: double.infinity,
                //                     // margin: EdgeInsets.only(
                //                     //     left: (index != 0) ? 20.w : 0,
                //                     //     right: (index != getFloorList.length - 1)
                //                     //         ? 20.w
                //                     //         : 0),
                //                     padding:
                //                         EdgeInsets.symmetric(horizontal: 20.w),
                //                     decoration: getButtonDecoration(
                //                         ((selectedPos != index))
                //                             ? Colors.transparent
                //                             : getFontColor(context),
                //                         withCorners: true,
                //                         corner: 20.h,
                //                         withBorder: (selectedPos != index),
                //                         borderColor: Color(0xFFE6E6E6)),
                //                     child: Center(
                //                       child: getCustomFont(
                //                           getFloorList[index],
                //                           14,
                //                           (selectedPos == index)
                //                               ? Colors.white
                //                               : getFontColor(context),
                //                           1,
                //                           textAlign: TextAlign.center,
                //                           fontWeight: FontWeight.w500),
                //                     ),
                //                   ),
                //                 );
                //               },
                //               scrollDirection: Axis.horizontal,
                //               shrinkWrap: true,
                //               itemCount: getFloorList.length),
                //         ),
                //         getVerSpace(26.h),
                //         Center(
                //           child: getCustomFont(
                //               "Exit", 18, getFontColor(context), 1,
                //               fontWeight: FontWeight.w500),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Container(
                //               width: 160.w,
                //               child: ListView.builder(
                //                   reverse: true,
                //                   padding: EdgeInsets.zero,
                //                   itemBuilder: (context, index) {
                //                     ModelSlotDetail slotDetail = slotList1[index];
                //                     bool isLast = (index == 0);
                //                     // return Container(
                //                     //   height: 50,
                //                     //   margin: EdgeInsets.all(5),
                //                     //   width: double.infinity,
                //                     //   color: Colors.green,
                //                     // );
                //                     return Container(
                //                       margin: EdgeInsets.only(left: horSpace),
                //                       // decoration: DottedDecoration(
                //                       //   color: Colors.black,
                //                       //   strokeWidth: 0.5,
                //                       //   linePosition: LinePosition.left,
                //                       // ),
                //                       width: 160.h,
                //                       height: 60.h,
                //                       // height: (isLast) ? 67.h : 60.h,
                //                       child:
                //                           buildSlotItem(isLast, slotDetail, true),
                //                     );
                //                     // return Container(
                //                     //   width: double.infinity,
                //                     //   height: 50.h,
                //                     //   margin: EdgeInsets.all(7),
                //                     //   decoration: DottedDecoration(
                //                     //       shape: Shape.box,
                //                     //       color: Colors.blue,
                //                     //       borderRadius: BorderRadius.only(
                //                     //           topLeft: Radius.circular(15)),
                //                     //       linePosition: LinePosition.top,
                //                     //       strokeWidth: 5),
                //                     //   // child: FDottedLine(
                //                     //   //   width: double.infinity,
                //                     //   //   height: double.infinity,
                //                     //   //   color: Colors.green,
                //                     //   //
                //                     //   //   corner: FDottedLineCorner(
                //                     //   //       leftBottomCorner: 0,
                //                     //   //       leftTopCorner: 5,
                //                     //   //       rightBottomCorner: 0,
                //                     //   //       rightTopCorner: 0),
                //                     //   //   child: Container(
                //                     //   //     width: double.infinity,
                //                     //   //     height: double.infinity,
                //                     //   //   ),
                //                     //   // ),
                //                     // );
                //                   },
                //                   physics: NeverScrollableScrollPhysics(),
                //                   itemCount: slotList1.length,
                //                   shrinkWrap: true),
                //             ),
                //             Expanded(
                //               child: getVerSpace(0),
                //               flex: 1,
                //             ),
                //             Container(
                //               width: 160.w,
                //               child: ListView.builder(
                //                   padding: EdgeInsets.zero,
                //                   itemBuilder: (context, index) {
                //                     ModelSlotDetail slotDetail = slotList2[index];
                //                     bool isLast = (index == slotList2.length - 1);
                //                     // return Container(
                //                     //   height: 50,
                //                     //   margin: EdgeInsets.all(5),
                //                     //   width: double.infinity,
                //                     //   color: Colors.green,
                //                     // );
                //                     return Container(
                //                       margin: EdgeInsets.only(right: horSpace),
                //                       // decoration: DottedDecoration(
                //                       //   color: Colors.black,
                //                       //   strokeWidth: 0.5,
                //                       //   linePosition: LinePosition.left,
                //                       // ),
                //                       width: 160.h,
                //                       height: 60.h,
                //                       child: buildSlotItem(
                //                           isLast, slotDetail, false),
                //                     );
                //                     // return Container(
                //                     //   width: double.infinity,
                //                     //   height: 50.h,
                //                     //   margin: EdgeInsets.all(7),
                //                     //   decoration: DottedDecoration(
                //                     //       shape: Shape.box,
                //                     //       color: Colors.blue,
                //                     //       borderRadius: BorderRadius.only(
                //                     //           topLeft: Radius.circular(15)),
                //                     //       linePosition: LinePosition.top,
                //                     //       strokeWidth: 5),
                //                     //   // child: FDottedLine(
                //                     //   //   width: double.infinity,
                //                     //   //   height: double.infinity,
                //                     //   //   color: Colors.green,
                //                     //   //
                //                     //   //   corner: FDottedLineCorner(
                //                     //   //       leftBottomCorner: 0,
                //                     //   //       leftTopCorner: 5,
                //                     //   //       rightBottomCorner: 0,
                //                     //   //       rightTopCorner: 0),
                //                     //   //   child: Container(
                //                     //   //     width: double.infinity,
                //                     //   //     height: double.infinity,
                //                     //   //   ),
                //                     //   // ),
                //                     // );
                //                   },
                //                   physics: NeverScrollableScrollPhysics(),
                //                   itemCount: slotList2.length,
                //                   shrinkWrap: true),
                //             )
                //           ],
                //         ),
                //         Center(
                //           child: getCustomFont(
                //               "Entry", 18, getFontColor(context), 1,
                //               fontWeight: FontWeight.w500),
                //         ),
                //         getVerSpace(14.h),
                //         getPaddingWidget(
                //             edgeInsets,
                //             Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 getInfoItem(DataFile.slotUnAvailable),
                //                 getInfoItem(DataFile.slotAvailable),
                //                 getInfoItem(DataFile.slotSelected),
                //               ],
                //             ))
                //       ],
                //     ),
                //   ),
                //   flex: 1,
                // ),
                // Container(
                //   width: double.infinity,
                //   height: 99.h,
                //   margin: EdgeInsets.only(top: 10.h),
                //   decoration: ShapeDecoration(
                //       color: getCardColor(context),
                //       shadows: [
                //         BoxShadow(
                //             // color: Colors.green,
                //             color: Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                //             offset: Offset(0, -4),
                //             blurRadius: 17)
                //       ],
                //       shape: SmoothRectangleBorder(
                //           borderRadius: SmoothBorderRadius.vertical(
                //               top: SmoothRadius(
                //                   cornerRadius: 21.h, cornerSmoothing: 0.5)))),
                //   padding: edgeInsets,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: [
                //                 getCustomFont(
                //                   "Your Selected Slot = ",
                //                   14,
                //                   getFontColor(context),
                //                   1,
                //                   fontWeight: FontWeight.w400,
                //                 ),
                //                 Expanded(
                //                   child: getCustomFont(
                //                     "G06",
                //                     16,
                //                     getFontColor(context),
                //                     1,
                //                     fontWeight: FontWeight.w600,
                //                   ),
                //                   flex: 1,
                //                 )
                //               ],
                //             ),
                //             getVerSpace(5.h),
                //             getCustomFont(
                //               "\$7",
                //               18,
                //               getFontColor(context),
                //               1,
                //               fontWeight: FontWeight.w600,
                //             ),
                //           ],
                //         ),
                //         flex: 1,
                //       ),
                //       InkWell(
                //         onTap: () {
                //           Constant.sendToNext(
                //               context, Routes.choosePaymentMethodScreen);
                //         },
                //         child: Container(
                //           width: 120.w,
                //           height: 40.h,
                //           decoration: getButtonDecoration(getAccentColor(context),
                //               withCorners: true, corner: 20.h, withBorder: true),
                //           child: Center(
                //             child: getCustomFont("Confirm", 14, Colors.black, 1,
                //                 fontWeight: FontWeight.w500),
                //           ),
                //         ),
                //       )
                //       // SizedBox(
                //       //   width: 120.h,
                //       //   height: 40.h,
                //       //   child: getButtonFigma(
                //       //       context,
                //       //       getAccentColor(context),
                //       //       true,
                //       //       "Confirm",
                //       //       Colors.black,
                //       //       () {},
                //       //       EdgeInsets.zero),
                //       // )
                //     ],
                //   ),
                // )
                getPaddingWidget(
                  edgeInsets,
                  getButtonFigma(context, getAccentColor(context), true,
                      "Continue", Colors.black, () {
                    Constant.sendToNext(
                      context,
                      Routes.paymentCardScreen,
                      arguments: widget.parkingTicket,
                    );
                  }, EdgeInsets.zero),
                ),
                getVerSpace(32)
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  Widget getInfoItem(int type) {
    String title = (type == DataFile.slotUnAvailable)
        ? "Unavailable"
        : (type == DataFile.slotAvailable)
            ? "Available"
            : "Selected";
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 24.h,
          height: 24.h,
          decoration: buildSlotBoxDecoration(type, true,
              radius1: BorderRadius.circular(4.h)),
        ),
        getHorSpace(10.w),
        getCustomFont(title, 14, getFontColor(context), 1,
            fontWeight: FontWeight.w500, textAlign: TextAlign.start)
      ],
    );
  }

  Stack buildSlotItem(bool isLast, ModelSlotDetail slotDetail, bool isFirst) {
    LinePosition linePosition =
        (isFirst) ? LinePosition.left : LinePosition.right;
    return Stack(
      children: [
        Container(
          decoration: DottedDecoration(
            color: Colors.black,
            strokeWidth: 0.5,
            linePosition: linePosition,
          ),
        ),
        Container(
          decoration: DottedDecoration(
            color: Colors.black,
            strokeWidth: 0.5,
            linePosition: LinePosition.top,
          ),
        ),
        (isLast)
            ? Container(
                decoration: DottedDecoration(
                  color: Colors.black,
                  strokeWidth: 0.5,
                  linePosition: LinePosition.bottom,
                ),
              )
            : getVerSpace(0),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: buildSlotBoxDecoration(slotDetail.availability, isFirst),
          margin: EdgeInsets.only(
              left: (isFirst) ? 12.w : 0,
              right: (!isFirst) ? 12.w : 0,
              top: 7.h,
              bottom: 7.h),
          child: Align(
            alignment: (isFirst) ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
                width: 42.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.horizontal(
                      right: (isFirst) ? Radius.circular(10.h) : Radius.zero,
                      left: (!isFirst) ? Radius.circular(10.h) : Radius.zero),
                ),
                child: Center(
                  child: getCustomFont(
                    slotDetail.title,
                    14,
                    Colors.white,
                    1,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        )
      ],
    );
  }

  BoxDecoration buildSlotBoxDecoration(int type, bool isFirstList,
      {BorderRadius? radius1}) {
    BorderRadius? radius = radius1;
    Radius radiusSet = Radius.circular(10.h);

    if (radius == null) {
      radius = BorderRadius.horizontal(
          left: (!isFirstList) ? radiusSet : Radius.zero,
          right: (isFirstList) ? radiusSet : Radius.zero);
    }
    Color getColors = unAvailableColor;
    bool isBorder = false;
    switch (type) {
      case DataFile.slotUnAvailable:
        getColors = unAvailableColor;
        break;
      case DataFile.slotAvailable:
        getColors = Colors.transparent;
        isBorder = true;
        break;
      case DataFile.slotSelected:
        getColors = slotSelectedColor;
        break;
    }
    return BoxDecoration(
        color: getColors,
        border:
            (isBorder) ? Border.all(color: darkGreyColor, width: 1.h) : null,
        borderRadius: radius);
  }
}
