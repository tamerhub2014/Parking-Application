import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../controller/add_vehicle_controller.dart';
import '../data/data_file.dart';
import '../model/select_vehicale_model.dart';

class AddVehiclesScreen extends StatefulWidget {
  const AddVehiclesScreen({Key? key}) : super(key: key);

  @override
  State<AddVehiclesScreen> createState() => _AddVehiclesScreenState();
}

class _AddVehiclesScreenState extends State<AddVehiclesScreen> {
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
          children: [
            getToolbarWidget(context, "Add Vehicle", () {
              Get.back();
            }),
            getVerSpace(10),
            Expanded(
              child: getPaddingWidget(
                  edgeInsets,
                  GetBuilder<AddVehicleController>(
                    init: AddVehicleController(), builder: (controller) {
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
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        itemCount: vehicleList.length,
                        shrinkWrap: true);
                  },)
              ),
            ),

            getButtonFigma(isIcon: false,context, getAccentColor(context), true,
               "Add", Colors.black, () {
                Get.back();
                }, edgeInsets),
            getVerSpace(32)
          ],
        ),
      ),
    );
  }
}
