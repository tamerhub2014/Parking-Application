import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Search", () {
              Get.back();
            }),
            getVerSpace(32),
            getPaddingWidget(
                edgeInsets,
                getDefaultTextFiled(
                  context,
                  s: "Search...",
                  textEditingController: searchController,
                  textInputAction: TextInputAction.done,
                  withPrefix: true,
                  imgName: "search.svg",
                  constraints: BoxConstraints(maxHeight: 56.h),
                )),
            getVerSpace(24),
            getPaddingWidget(
              edgeInsets,
              getCustomFont("Recent", 17, getFontColor(context), 1),
            ),
            getVerSpace(12),
            getPaddingWidget(
              edgeInsets,
              Divider(
                thickness: 1,
                color: Color(0xFFF4F4F4),
              ),
            ),
            getVerSpace(12),
            Row(
              children: [
                getHorSpace(20),
                Expanded(
                    child: getCustomFont(
                        "Cinema Park", 15, getFontGreyColor(context), 1)),
                getAssetImage(context, "close2.png", 16, 16),
                getHorSpace(20),
              ],
            ),
            getVerSpace(14),
            Row(
              children: [
                getHorSpace(20),
                Expanded(
                    child: getCustomFont("Easkarton Shopping Mall", 15,
                        getFontGreyColor(context), 1)),
                getAssetImage(context, "close2.png", 16, 16),
                getHorSpace(20),
              ],
            ),
            getVerSpace(14),
            Row(
              children: [
                getHorSpace(20),
                Expanded(
                    child: getCustomFont("Alzebia Center Mall", 15,
                        getFontGreyColor(context), 1)),
                getAssetImage(context, "close2.png", 16, 16),
                getHorSpace(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
