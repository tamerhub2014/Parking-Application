import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../data/data_file.dart';
import '../model/model_category.dart';
import '../routes/app_routes.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<ModelCategory> _list = DataFile.getAllCategoryList();
    Constant.setupSize(context);

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Categories", () {
              Get.back();
            }),
            getVerSpace(32),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisExtent: 135,
              ),
              itemBuilder: (context, index) {
                ModelCategory modelCat = _list[index];
                return GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.locationDetailScreenRoute);
                  },
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: (index == 0) ? horSpace : (horSpace / 2),
                              right: (index == (_list.length - 1))
                                  ? horSpace
                                  : (horSpace / 2)),
                          width: 100.h,
                          height: 100.h,
                          decoration: getButtonDecoration(Color(0xFFF9F9F9),
                              withCorners: true,
                              corner: 8.h,
                              borderColor: Color(0xFFE6E6E6),
                              withBorder: true),
                          child: Center(
                            child: getAssetImage(
                                context, modelCat.image, 55.h, 55.h,
                                boxFit: BoxFit.fill),
                          ),
                        ),
                      ),
                      getVerSpace(8.h),
                      getCustomFont(
                          modelCat.title, 17, getFontColor(context), 1,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
