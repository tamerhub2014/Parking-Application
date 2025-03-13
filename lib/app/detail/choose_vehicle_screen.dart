import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';
import '../contollers/default_controller.dart';
import '../model/model_category.dart';

class ChooseVehicleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseVehicleScreen();
  }
}

class _ChooseVehicleScreen extends State<ChooseVehicleScreen> {
  List<ModelCategory> catList = DataFile.getAllCategoryList();

  finish() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    Get.put(DefaultController());
    double defSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    // ignore: deprecated_member_use
    return WillPopScope(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              getToolbarWidget(context, "Choose Your Vehicle", () {
                finish();
              }),
              Expanded(
                child: GetBuilder<DefaultController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        ModelCategory modelCat = catList[index];

                        return Container(
                          width: double.infinity,
                          height: 90.h,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          margin: EdgeInsets.symmetric(
                              horizontal: defSpace, vertical: 10.h),
                          child: Row(
                            children: [
                              getAssetImage(context, modelCat.image, 68.h, 68.h,
                                  boxFit: BoxFit.fill),
                              getHorSpace(20.w),
                              Expanded(
                                child: getCustomFont(modelCat.title, 20,
                                    getFontColor(context), 1,
                                    fontWeight: FontWeight.w500),
                                flex: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.chooseVehicles(index);
                                },
                                child: getSvgImageWithSize(
                                    context,
                                    (controller.chooseVehicle == index)
                                        ? "Radio_selected.svg"
                                        : "Radio_unselected.svg",
                                    24.h,
                                    24.h,
                                    color: ((controller.chooseVehicle == index))
                                        ? getFontColor(context)
                                        : getFontGreyColor(context)),
                              )
                            ],
                          ),
                          decoration: getButtonDecoration(getCardColor(context),
                              withCorners: true,
                              corner: 6.h,
                              shadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        61, 61, 61, 0.11999999731779099),
                                    offset: Offset(-4, 8),
                                    blurRadius: 25)
                              ]),
                        );
                      },
                      itemCount: catList.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
                // GridView.count(
                //     crossAxisCount: crossCount,
                //     shrinkWrap: true,
                //     mainAxisSpacing: spacing,
                //     crossAxisSpacing: spacing,
                //     padding: EdgeInsets.all(
                //         FetchPixels.getDefaultHorSpaceFigma(context)),
                //     children: List.generate(catList.length, (index) {
                //       ModelCategory modelCat = catList[index];
                //       return Center(
                //         child: Container(
                //           // margin: EdgeInsets.only(
                //           //     left: (index == 0) ? horSpace : (horSpace / 2),
                //           //     right: (index == (_list.length - 1))
                //           //         ? horSpace
                //           //         : (horSpace / 2)),
                //           width: itemSize,
                //           height: itemSize,
                //           padding:
                //               EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
                //           decoration: getButtonDecoration(getCardColor(context),
                //               withCorners: true,
                //               corner: 6.h,
                //               shadow: [
                //                 BoxShadow(
                //                     color: Color.fromRGBO(
                //                         61, 61, 61, 0.11999999731779099),
                //                     offset: Offset(-4, 8),
                //                     blurRadius: 25)
                //               ]),
                //           child: Column(
                //             children: [
                //               Expanded(
                //                 child: getAssetImage(context, modelCat.image,
                //                     double.infinity, double.infinity,
                //                     boxFit: BoxFit.scaleDown),
                //                 flex: 1,
                //               ),
                //               getVerSpace(5.w),
                //               getCustomFont(
                //                   modelCat.title, 14, getFontColor(context), 1,
                //                   textAlign: TextAlign.center,
                //                   fontWeight: FontWeight.w500)
                //             ],
                //           ),
                //         ),
                //       );
                //     })),
                flex: 1,
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        finish();
        return false;
      },
    );
  }
}
