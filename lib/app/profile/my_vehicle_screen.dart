import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../data/data_file.dart';
import '../model/select_vehicale_model.dart';
import 'controller/select_vehicle_controller.dart';

class MyVehicleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyVehicleScreen();
  }
}

class _MyVehicleScreen extends State<MyVehicleScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<SelectVehicleModel> vehicleList = DataFile.getSelectVehicleList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Select Vehicle", () {
              Get.back();
            }),
            getVerSpace(47),
            getPaddingWidget(
                edgeInsets,
                GetBuilder<SelectVehicleController>(
                  init: SelectVehicleController(), builder: (controller) {
                  return ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 20.h),
                      itemBuilder: (context, index) {
                        SelectVehicleModel selectVehicleModel = vehicleList[index];
                        // bool isSelected=controller.selectedIndex.value==index;
                        return GestureDetector(
                          onTap: () {
                            controller.isSelected.value = index;
                            controller.update();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 72.h,
                            decoration: BoxDecoration(
                              // color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: controller.isSelected.value ==index?getAccentColor(context):Color(0xFFE6E6E6),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 16.h),
                              child: Row(
                                children: [
                                  getAssetImage(
                                      context, selectVehicleModel.image!, 32, 32),
                                  getHorSpace(10),
                                  Expanded(
                                      child: getCustomFont(
                                          selectVehicleModel.text!,
                                          17, getFontColor(context), 1,
                                          fontWeight: FontWeight.w400)),
                                  getAssetImage(context,
                                      controller.isSelected.value == index
                                          ? "select_radio.png"
                                          : "unselect_radio.png",
                                           24, 24),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      itemCount: vehicleList.length,
                      shrinkWrap: true);
                },)
            ),
            // Expanded(
            //   child: ListView(
            //     children: [
            //       buildMyVehicleRow(
            //           edgeInsets, horSpace, "Vehicle Type", "Car", context,
            //           isDropDown: true, fun: () {}),
            //       buildMyVehicleRow(edgeInsets, horSpace, "License Plate No",
            //           "321456987410", context),
            //       buildMyVehicleRow(edgeInsets, horSpace, "Car Model",
            //           "Toyota  Land Cruiser", context),
            //       getVerSpace(20.h),
            //       getButtonFigma(context, getAccentColor(context), true,
            //           "Add Vehicle", Colors.black, () {
            //         finish();
            //         // Constant.sendToNext(context, Routes.selectVehicleScreen);
            //       }, edgeInsets)
            //     ],
            //     shrinkWrap: true,
            //     padding: EdgeInsets.symmetric(vertical: 15.h),
            //   ),
            //   flex: 1,
            // ),
          ],
        ),
      ),
      // body: GetBuilder<ToggleEditController>(
      //   init: ToggleEditController(),
      //   builder: (controller) {
      //     return ;
      //   },
      // ),
    );
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
