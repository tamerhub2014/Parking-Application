// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/contollers/default_controller.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../model/model_my_card.dart';

class MyCardsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCardsScreen();
  }
}

class _MyCardsScreen extends State<MyCardsScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<ModelMyCard> getAllMyCardList = DataFile.getAllMyCardList();
  DefaultController controller = Get.put(DefaultController());

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
              getToolbarWidget(context, "Select Your Vehicle", () {}),
              getVerSpace(10.h),
              Expanded(
                child: ListView(
                  primary: true,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    ListView.builder(
                        itemBuilder: (context, index) {
                          ModelMyCard vehicleModel = getAllMyCardList[index];
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                top: 20.h, left: horSpace, right: horSpace),
                            margin: EdgeInsets.symmetric(
                                horizontal: horSpace, vertical: 10.h),
                            height: 98.h,
                            decoration: getButtonDecoration(
                                getCardColor(context),
                                withCorners: true,
                                corner: 12.h,
                                shadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(
                                          61, 61, 61, 0.11999999731779099),
                                      offset: Offset(-4, 8),
                                      blurRadius: 25)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getSvgImageWithSize(
                                    context, vehicleModel.image, 30.h, 30.h,
                                    fit: BoxFit.fill),
                                getHorSpace(20.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(vehicleModel.title, 20,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w500),
                                      getVerSpace(4.h),
                                      getCustomFont(vehicleModel.cardNumber, 16,
                                          getFontColor(context), 1,
                                          fontWeight: FontWeight.w500)
                                    ],
                                  ),
                                  flex: 1,
                                )
                              ],
                            ),
                          );
                        },
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        itemCount: getAllMyCardList.length,
                        primary: false,
                        shrinkWrap: true),
                    getVerSpace(15.h),
                    getButtonFigma(context, getAccentColor(context), true,
                        "Add New Cart", Colors.black, () {}, edgeInsets),
                    getVerSpace(30.h)
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  Container buildMyVehicleRow(EdgeInsets edgeInsets, double horSpace,
      String title, String subtitle, BuildContext context,
      {bool isDropDown = false, Function? fun}) {
    return Container(
      width: double.infinity,
      height: 64.h,
      padding: edgeInsets,
      margin: EdgeInsets.symmetric(horizontal: horSpace, vertical: 10.h),
      decoration: getButtonDecoration(getCardColor(context),
          withCorners: true,
          corner: 12.h,
          shadow: [
            BoxShadow(
                color: Color.fromRGBO(61, 61, 61, 0.11999999731779099),
                offset: Offset(-4, 8),
                blurRadius: 25)
          ]),
      child: Row(
        children: [
          Expanded(
            child: getCustomFont(title, 16, getFontGreyColor(context), 1,
                fontWeight: FontWeight.w600, textAlign: TextAlign.start),
            flex: 1,
          ),
          (isDropDown)
              ? InkWell(
                  onTap: () {
                    if (fun != null) {
                      fun();
                    }
                  },
                  child: Row(
                    children: [
                      getCustomFont(subtitle, 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.start),
                      getHorSpace(6.w),
                      getSvgImageWithSize(context, "arrow_down.svg", 16.h, 16.h,
                          fit: BoxFit.fill)
                    ],
                  ),
                )
              : getCustomFont(subtitle, 16, getFontColor(context), 1,
                  fontWeight: FontWeight.w600, textAlign: TextAlign.start)
        ],
      ),
    );
  }
}
