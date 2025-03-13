import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/contollers/default_controller.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../add_vehicle_screen/add_vehicle_screen.dart';
import '../model/model_vehicle.dart';

class SelectVehicleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelectVehicleScreen();
  }
}

class _SelectVehicleScreen extends State<SelectVehicleScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<ModelVehicle> vehicleList = DataFile.getAllVehicles();

  DefaultController controller = Get.put(DefaultController());

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
            getToolbarWidget(context, "My Vehicles", () {
              Get.back();
            }),
            getVerSpace(32.h),
            getPaddingWidget(
              edgeInsets,
              Container(
                width: double.infinity,
                height: 56,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 23,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Type Of Vehicle',
                        style: TextStyle(
                          color: Color(0xFF7D7D7D),
                          fontSize: 17.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'Car',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    getHorSpace(4),
                    getSvgImageWithSize(context, "arrow-down.svg", 24, 24,
                        color: getFontGreyColor(context))
                  ],
                ),
              ),
            ),
            getVerSpace(20),
            getPaddingWidget(
              edgeInsets,
              Container(
                width: double.infinity,
                height: 56,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 23,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Vehicle Number Plate',
                        style: TextStyle(
                          color: Color(0xFF7D7D7D),
                          fontSize: 17.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'GR 458-EFGH',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // getHorSpace(4),
                    // getSvgImageWithSize(context, "arrow-down.svg", 24, 24,color: getFontGreyColor(context))
                  ],
                ),
              ),
            ),
            getVerSpace(20),
            getPaddingWidget(
              edgeInsets,
              Container(
                width: double.infinity,
                height: 56,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 23,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Model of vehicle',
                        style: TextStyle(
                          color: Color(0xFF7D7D7D),
                          fontSize: 17.sp,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      'Toyota Fortuner (SUV)',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // getHorSpace(4),
                    // getSvgImageWithSize(context, "arrow-down.svg", 24, 24,color: getFontGreyColor(context))
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //       itemBuilder: (context, index) {
            //         ModelVehicle vehicleModel = vehicleList[index];
            //         // bool isSelected=controller.selectedIndex.value==index;
            //         return Obx(() => InkWell(
            //               onTap: () {
            //                 controller.changePosition(index);
            //               },
            //               child: Container(
            //                 width: double.infinity,
            //                 padding: EdgeInsets.symmetric(horizontal: 25.w),
            //                 height: 100.h,
            //                 margin: EdgeInsets.symmetric(
            //                     horizontal: horSpace, vertical: 12.h),
            //                 decoration: getButtonDecoration(
            //                     getCardColor(context),
            //                     withCorners: true,
            //                     corner: 18.h,
            //                     withBorder:
            //                         controller.selectedIndex.value == index,
            //                     borderColor: getFontColor(context),
            //                     shadow: [
            //                       BoxShadow(
            //                           color: Color.fromRGBO(
            //                               61, 61, 61, 0.11999999731779099),
            //                           offset: Offset(-4, 8),
            //                           blurRadius: 25)
            //                     ]),
            //                 child: Row(
            //                   children: [
            //                     getAssetImage(
            //                         context, vehicleModel.image, 105.h, 50.h,
            //                         boxFit: BoxFit.fill),
            //                     getHorSpace(horSpace),
            //                     Expanded(
            //                       child: Column(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.center,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           getCustomFont(vehicleModel.title, 16,
            //                               getFontColor(context), 1,
            //                               fontWeight: FontWeight.w500),
            //                           getVerSpace(5.h),
            //                           getCustomFont(vehicleModel.model, 12,
            //                               getFontGreyColor(context), 1,
            //                               fontWeight: FontWeight.w500)
            //                         ],
            //                       ),
            //                       flex: 1,
            //                     ),
            //                     getSvgImageWithSize(
            //                         context,
            //                         (controller.selectedIndex.value == index)
            //                             ? "Radio_selected.svg"
            //                             : "Radio_unselected.svg",
            //                         24.h,
            //                         24.h,
            //                         fit: BoxFit.fill)
            //                   ],
            //                 ),
            //               ),
            //             ));
            //       },
            //       padding: EdgeInsets.symmetric(vertical: 10.h),
            //       itemCount: vehicleList.length,
            //       shrinkWrap: true),
            //   flex: 1,
            // ),
            getVerSpace(32.h),
            getButtonFigma(
                isIcon: true,
                icons: "add.svg",
                context,
                Color.fromARGB(255, 128, 205, 207),
                borderColor: getAccentColor(context),
                true,
                textSize: 16,
                isBorder: true,
                "Add Vehicle",
                Colors.black, () {
              Get.to(() => AddVehiclesScreen());
              // Constant.sendToNext(context, Routes.selectVehicleScreen);
            }, edgeInsets),
            getVerSpace(32.h)
          ],
        ),
      ),
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
