import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';
import '../../model/modal_bookmark.dart';
import '../../model/model_category.dart';

class TabMyBookMark extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabMyBookMark();
  }
}

class _TabMyBookMark extends State<TabMyBookMark> {
  List<ModelCategory> catList = DataFile.getAllCategoryList();
  TextEditingController searchController = TextEditingController();
  List<ModelBookMark> bookmarkList = DataFile.getMyBookMarks();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: getCustomFont("Bookmark", 22, getFontColor(context), 1,
                fontWeight: FontWeight.w700),
          ),
          // getToolbarWidget(context, "My Boomark", () {}),
          getVerSpace(30.h),
          // getPaddingWidget(
          //     edgeInsets,
          //     getSearchFigmaWidget(context, searchController, () {}, (value) {},
          //         showFilter: false, hint: "Search")),
          bookmarkList.isNotEmpty
              ? Expanded(
                  child: getPaddingWidget(
                    edgeInsets,
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16.h),
                      itemBuilder: (context1, index) {
                        ModelBookMark modelBookmark = bookmarkList[index];
                        return buildBookMarkCell(
                            horSpace, context, modelBookmark, () {
                          // Get.toNamed(
                          //     Routes.locationDetailScreenRoute);
                        });
                      },
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shrinkWrap: true,
                      itemCount: bookmarkList.length,
                    ),
                  ),
                  flex: 1,
                )
              : Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getAssetImage(context, "bookMark.png", 120, 120),
                        getVerSpace(24),
                        getCustomFont(
                            "No Bookmark Yet!", 28, getFontColor(context), 1,
                            fontWeight: FontWeight.w700),
                        getVerSpace(12.h),
                        getCustomFont("Add your bookmark here!", 17,
                            getFontGreyColor(context), 1,
                            fontWeight: FontWeight.w400),
                        getVerSpace(64),
                        getButtonFigma(
                            context,
                            getAccentColor(context),
                            true,
                            "Add Bookmark",
                            getFontColor(context),
                            () {},
                            EdgeInsets.symmetric(horizontal: 64.w)),
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
