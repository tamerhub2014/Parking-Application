import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_parking_ui_new/app/contollers/home_filter_controller.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_model.dart';
import 'package:flutter_parking_ui_new/app/home/data/repos/google_maps_repo.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/app/model/model_category.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_parking_ui_new/base/slider.dart' as sliders;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../categories/categories_screen.dart';
import '../../routes/app_routes.dart';
import '../controller/home_controller.dart';

class TabHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabHome();
  }
}

class _TabHome extends State<TabHome> {
  List<ModelCategory> _list = DataFile.getAllCategoryList();

  num long = 30.033333;
  num lat = 31.233334;

  @override
  void initState() {
    super.initState();

    long = num.parse(
        ProfileCubit.instance.user?.location?.longitude ?? "30.033333");
    lat = num.parse(
        ProfileCubit.instance.user?.location?.latitude ?? "31.233334");
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    Get.put(HomeFilterController());

    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    CameraPosition? _kGooglePlex;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat.toDouble(), long.toDouble()),
      zoom: 14,
      bearing: 0.8334901395799,
      tilt: 59.440717697143555,
    );

    // _polyLine.add(Polyline(
    //   endCap: Cap.roundCap,
    //   polylineId: PolylineId("route1"),
    //   color: Colors.black,
    //   patterns: [PatternItem.dash(20.0), PatternItem.gap(10)],
    //   width: 3,
    //   points: [
    //     LatLng(54.985934, -2.7372116),
    //     LatLng(54.9841444, -2.7437832),
    //   ],
    // ));
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(30.h),
          getPaddingWidget(
              edgeInsets,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        getCustomFont(
                            "Your Location", 14, getFontColor(context), 1,
                            fontWeight: FontWeight.w500),
                        getVerSpace(6.h),
                        Row(
                          children: [
                            getSvgImageWithSize(
                                context,
                                "location_fill.svg",
                                color: accentColor,
                                24.h,
                                24.h),
                            getHorSpace(8.w),
                            BlocBuilder<ProfileCubit, ProfileState>(
                              bloc: ProfileCubit.instance,
                              builder: (context, state) {
                                if (state is ProfileSuccess) {
                                  return getCustomFont(
                                      state.userModel.location.toString(),
                                      17,
                                      getFontColor(context),
                                      1);
                                }
                                return getCustomFont(
                                    "Un Known", 17, getFontColor(context), 1);
                              },
                            ),
                            getHorSpace(6.w),
                            getSvgImageWithSize(
                                context, "arrow-down.svg", 24, 24,
                                color: getFontColor(context)),
                          ],
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    flex: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.notificationScreen);
                      },
                      child: getAssetImage(
                          context, "notification.png", 46.h, 46.h))
                  // getCircleImage(context, "profile.png", 60.h)
                ],
              )),
          getVerSpace(24.h),
          getPaddingWidget(
            edgeInsets,
            getCustomFont(
                "Let’s find best parking place",
                22,
                getFontColor(context),
                fontWeight: FontWeight.w700,
                1),
          ),
          getVerSpace(24.h),
          getPaddingWidget(
            edgeInsets,
            Container(
              width: double.infinity,
              height: getEditHeightFigma(),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      decoration: getButtonDecoration(Colors.transparent,
                          withCorners: true,
                          corner: getEditRadiusSizeFigma(),
                          withBorder: true,
                          borderColor: Color(0xFFDFDFDF)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getSvgImageWithSize(
                              context,
                              "search.svg",
                              getEditIconSizeFigma().h,
                              getEditIconSizeFigma().h,
                              fit: BoxFit.scaleDown,
                              color: getFontColor(context)),
                          getHorSpace(12.w),
                          Expanded(
                            child: IntrinsicHeight(
                              child: TextField(
                                readOnly: false,
                                // controller: _searchController,
                                onChanged: (v) async {
                                  if (v.isNotEmpty) {
                                    final result =
                                        await GoogleMapsRepo.getCoordinates(v);
                                    if (result != null) {
                                      print("${result}📌⭐📌⭐");

                                      setState(() {
                                        lat = result["lat"]!;
                                        long = result["lng"]!;
                                      });
                                    }
                                  } else if (lat !=
                                          num.parse(ProfileCubit.instance.user
                                                  ?.location?.latitude ??
                                              "31.233334") &&
                                      long !=
                                          num.parse(ProfileCubit.instance.user
                                                  ?.location?.longitude ??
                                              "30.033333")) {
                                    setState(() {
                                      lat = num.parse(ProfileCubit.instance.user
                                              ?.location?.latitude ??
                                          "31.233334");
                                      long = num.parse(ProfileCubit.instance
                                              .user?.location?.longitude ??
                                          "30.033333");
                                    });
                                  }
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontFamily: Constant.fontsFamily,
                                        fontSize: getEditFontSizeFigma().sp,
                                        fontWeight: FontWeight.w500,
                                        color: getFontHint(context))),
                                style: TextStyle(
                                    fontFamily: Constant.fontsFamily,
                                    fontSize: getEditFontSizeFigma().sp,
                                    fontWeight: FontWeight.w500,
                                    color: getFontColor(context)),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  getHorSpace(8.w),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(
                          isScrollControlled: true,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32.h),
                                    topRight: Radius.circular(32.h))),
                            child: getPaddingWidget(
                                edgeInsets, filtterBottomSheet(context)),
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32.h)),
                          ));
                    },
                    child: getSvgImageWithSize(
                        context, "filter.svg", 46.h, 46.h,
                        fit: BoxFit.scaleDown),
                  ),
                ],
              ),
            ),
          ),
          getVerSpace(24.h),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 24),
              children: [
                getPaddingWidget(
                    edgeInsets,
                    Row(
                      children: [
                        Expanded(
                          child: getCustomFont(
                              "Categories",
                              20,
                              getFontColor(context),
                              fontWeight: FontWeight.w700,
                              1),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => CategoriesScreen());
                          },
                          child: getCustomFont(
                              "See all", 15.sp, getFontGreyColor(context), 1,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )),
                getVerSpace(14.h),

                Container(
                  height: 128.h,
                  // color: Colors.red,
                  child: ListView.builder(
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
                                    left: (index == 0)
                                        ? horSpace
                                        : (horSpace / 2),
                                    right: (index == (_list.length - 1))
                                        ? horSpace
                                        : (horSpace / 2)),
                                width: 78.h,
                                height: 78.h,
                                decoration: getButtonDecoration(
                                    Color(0xFFF9F9F9),
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
                    itemCount: 4,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                // getVerSpace(24.h),
                getPaddingWidget(
                  edgeInsets,
                  Text(
                    'Nearby You',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                getVerSpace(13.h),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 307,
                      child: GoogleMap(
                        compassEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        // polylines: _polyLine.toSet(),
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          // mapController.complete(controller);
                        },
                        zoomControlsEnabled: true,
                        markers: {
                          Marker(
                            markerId: MarkerId("marker2"),
                            position: LatLng(lat.toDouble(), long.toDouble()),
                          ),
                        },
                      ),
                    ),

                    // getCircularImage(
                    //     context, double.infinity, 307, 0.h, "map_bg.png",
                    //     boxFit: BoxFit.cover),
                    Container(
                      height: 207,
                      child: FutureBuilder<List<ParkingModel>>(
                        future: GoogleMapsRepo.searchNearbyParking(lat, long),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No parking found.'));
                          } else {
                            final parkingList = snapshot.data!;
                            return ListView.separated(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w),
                              itemCount: parkingList.length,
                              // itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  getHorSpace(12.w),
                              itemBuilder: (context, index) {
                                return ParkingCard(
                                  parkingModel: parkingList[index],
                                );
                              },
                            );
                          }
                        },
                      ),
                      //  ListView.separated(
                      //                     padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      //                     itemCount: 3,
                      //                     scrollDirection: Axis.horizontal,
                      //                     separatorBuilder: (context, index) => getHorSpace(12.w),
                      //                     itemBuilder: (context, index) {
                      //                       return ParkingCard(parkingModel: );
                      //                     },
                      //                   ),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   height: double.infinity,
                    //   padding:
                    //   EdgeInsets.symmetric(horizontal: horSpace, vertical: 20.h),
                    //   child:  Align(
                    //     alignment: Alignment.center,
                    //     child: Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 20.h, vertical: 20.h),
                    //       width: 334.h,
                    //       height: 146.h,
                    //       decoration: getButtonDecoration(
                    //         getCardColor(context),
                    //         withCorners: true,
                    //         corner: 18.h,
                    //       ),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.start,
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Expanded(
                    //                 child: Column(
                    //                   mainAxisAlignment: MainAxisAlignment.start,
                    //                   crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //                   children: [
                    //                     getCustomFont("Embassy Coffee Shop", 16,
                    //                         getFontColor(context), 1,
                    //                         fontWeight: FontWeight.w700),
                    //                     getVerSpace(4.h),
                    //                     Row(
                    //                       children: [
                    //                         getSvgImageWithSize(context,
                    //                             "location.svg", 16.h, 16.h,
                    //                             color: getFontGreyColor(context)),
                    //                         getHorSpace(7.h),
                    //                         Expanded(
                    //                           child: getCustomFont(
                    //                               "24, Bilpar Road , Tokoyo",
                    //                               12,
                    //                               getFontGreyColor(context),
                    //                               1,
                    //                               fontWeight: FontWeight.w400),
                    //                           flex: 1,
                    //                         )
                    //                       ],
                    //                     )
                    //                   ],
                    //                 ),
                    //                 flex: 1,
                    //               ),
                    //               Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   getCustomFont(
                    //                       "\$5", 22, getFontColor(context), 1,
                    //                       fontWeight: FontWeight.w600),
                    //                   getHorSpace(7.h),
                    //                   getCustomFont("Per Hour", 12,
                    //                       getFontGreyColor(context), 1,
                    //                       fontWeight: FontWeight.w400)
                    //                 ],
                    //               )
                    //             ],
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               Constant.sendToNext(
                    //                   context, Routes.locationDetailScreenRoute);
                    //             },
                    //             child: Container(
                    //               width: double.infinity,
                    //               height: 40.h,
                    //               decoration: getButtonDecoration(
                    //                 getAccentColor(context),
                    //                 withCorners: true,
                    //                 corner: 20.h,
                    //               ),
                    //               child: Center(
                    //                 child: getCustomFont(
                    //                     "Book Now", 14, getFontColor(context), 1,
                    //                     fontWeight: FontWeight.w600),
                    //               ),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final ParkingModel parkingModel;

  const ParkingCard({
    super.key,
    required this.parkingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374.h,
      height: 206.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                getAssetImage(context, "homeImage1.png", 64, 64),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCustomFont(
                          "${parkingModel.name}",
                          // "Some Parking name",
                          17,
                          getFontColor(context),
                          1,
                          fontWeight: FontWeight.w400),
                      Row(
                        children: [
                          getAssetImage(context, "location_black.png", 16, 16),
                          getVerSpace(6),
                          getCustomFont("20m Right To Parking Spot", 15,
                              getFontGreyColor(context), 1,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      getVerSpace(12),
                      Divider(
                        height: 0,
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                      getVerSpace(10.w),
                      Row(
                        children: [
                          getAssetImage(context, "locationKm.png", 24, 24),
                          SizedBox(width: 7.w),
                          getCustomFont("2.5 KM", 12, getFontColor(context), 1,
                              fontWeight: FontWeight.w400),
                          SizedBox(width: 15.w),
                          getAssetImage(context, "clock.png", 24, 24),
                          SizedBox(width: 7.w),
                          getCustomFont(
                              "(20 Reviews)", 15, getFontGreyColor(context), 1,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            getVerSpace(20),
            Row(
              children: [
                Expanded(
                  child: getButtonFigma(context, getAccentColor(context), true,
                      "Book Now", getFontColor(context), () {
                    Get.toNamed(Routes.locationDetailScreenRoute,
                        arguments: parkingModel);
                  }, EdgeInsets.zero),
                ),
                getHorSpace(8.w),
                Container(
                  width: 111.h,
                  height: 48,
                  padding: const EdgeInsets.only(
                      top: 5, left: 24, right: 24, bottom: 6),
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            '\$10',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          'per hour',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
//
  }

// @override
// void paint(PaintingContext context, Offset center, {Animation activationAnimation, Animation enableAnimation, bool isDiscrete, TextPainter labelPainter, RenderBox parentBox, SliderThemeData sliderTheme, TextDirection textDirection, double value}) {
//   final Canvas canvas = context.canvas;
//
//   final fillPaint = Paint()
//     ..color = Colors.white
//     ..style = PaintingStyle.fill;
//
//   final borderPaint = Paint()
//     ..color = sliderTheme.thumbColor
//     ..strokeWidth = 2
//     ..style = PaintingStyle.stroke;
//
//   canvas.drawCircle(center, thumbRadius, fillPaint);
//   canvas.drawCircle(center, thumbRadius, borderPaint);
// }
}

Widget filtterBottomSheet(BuildContext context) {
  List<String> filterList = [
    "Ground parking",
    "Underground parking",
    "Valet parking",
    "Singlelevel parking",
    "Multilevel parking",
    "Smart parking",
    "Local parking",
    "Business Central parking"
  ];
  List<String> shortByList = [
    "All",
    "Available Slot",
    "Higher Price",
    "Low Price",
  ];
  return GetBuilder<HomeController>(
    init: HomeController(),
    builder: (controller) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getVerSpace(12.h),

          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: getAssetImage(context, "close.png", 32, 32, listen: false),
            ),
          ),
          // Center(
          //   child: SizedBox(
          //     width: 40.w,
          //     child: Divider(
          //       color: getFontGreyColor(context),
          //       thickness: 4.h,
          //     ),
          //   ),
          // ),
          // getVerSpace(16.h),
          Center(
              child: getCustomFont("Filter", 28, getFontColor(context), 1,
                  fontWeight: FontWeight.w700, textAlign: TextAlign.center)),
          getVerSpace(24.h),
          getCustomFont(
            "Category for Parking",
            18,
            getFontColor(context),
            1,
            fontWeight: FontWeight.w500,
          ),
          getVerSpace(16.h),

          Wrap(
            alignment: WrapAlignment.start,

            direction: Axis.horizontal,
            runSpacing: 12,
            spacing: 12,

            children: List.generate(
              filterList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedIndex = index;
                    controller.update();
                  },
                  child: Container(
                    // height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      color: controller.selectedIndex == index
                          ? getAccentColor(context)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: controller.selectedIndex == index
                              ? Colors.transparent
                              : Color(0xFFE6E6E6),
                          width: 1),
                    ),
                    child: getCustomFont(
                      filterList[index],
                      15,
                      getFontColor(context),
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );

                // return Container(
                //   height: 36,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(24),
                //     border: Border.all(color: Color(0xFFE6E6E6), width: 1),
                //   ),
                // );
              },
            ),
            // child: ListView.builder(
            //   itemCount: filterList.length,
            //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   //   crossAxisCount: 2,
            //   //   // childAspectRatio: 1,
            //   //   mainAxisSpacing: 10,
            //   //   crossAxisSpacing: 10,
            //   //   mainAxisExtent: 36,
            //   //   // mainAxisExtent: 135,
            //   // ),
            //   itemBuilder: (context, index) {
            //     return Container(
            //       height: 36,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(24),
            //         border: Border.all(color: Color(0xFFE6E6E6), width: 1),
            //       ),
            //       child: Center(
            //         child: getCustomFont(
            //           filterList[index],
            //           14,
            //           getFontColor(context),
            //           1,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: List.generate(
          //       HomeFilterController().sortList.length,
          //       (index) => addRadioButton(
          //           context, HomeFilterController().sortList[index])),
          // ),
          getVerSpace(24.h),
          getCustomFont(
            "Short By",
            18,
            getFontColor(context),
            1,
            fontWeight: FontWeight.w500,
          ),
          getVerSpace(16.h),
          // Wrap(
          //   alignment: WrapAlignment.start,
          //
          //   direction: Axis.horizontal,
          //   runSpacing: 12,
          //   spacing: 12,
          //
          //   children: List.generate(
          //     shortByList.length,
          //         (index) {
          //       return GestureDetector(
          //         onTap: () {
          //           controller.shortByIndex = index;
          //           controller.update();
          //         },
          //         child: Container(
          //           // height: 36,
          //           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          //           decoration: BoxDecoration(
          //             color: controller.shortByIndex == index
          //                 ? getAccentColor(context)
          //                 : Colors.transparent,
          //             borderRadius: BorderRadius.circular(24),
          //             border: Border.all(color:controller.shortByIndex==index?Colors.transparent:Color(0xFFE6E6E6), width: 1),
          //           ),
          //           child: getCustomFont(
          //             shortByList[index],
          //             15,
          //             getFontColor(context),
          //             1,
          //             fontWeight: FontWeight.w400,
          //           ),
          //         ),
          //       );
          //
          //       // return Container(
          //       //   height: 36,
          //       //   decoration: BoxDecoration(
          //       //     borderRadius: BorderRadius.circular(24),
          //       //     border: Border.all(color: Color(0xFFE6E6E6), width: 1),
          //       //   ),
          //       // );
          //     },
          //   ),
          //   // child: ListView.builder(
          //   //   itemCount: filterList.length,
          //   //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   //   //   crossAxisCount: 2,
          //   //   //   // childAspectRatio: 1,
          //   //   //   mainAxisSpacing: 10,
          //   //   //   crossAxisSpacing: 10,
          //   //   //   mainAxisExtent: 36,
          //   //   //   // mainAxisExtent: 135,
          //   //   // ),
          //   //   itemBuilder: (context, index) {
          //   //     return Container(
          //   //       height: 36,
          //   //       decoration: BoxDecoration(
          //   //         borderRadius: BorderRadius.circular(24),
          //   //         border: Border.all(color: Color(0xFFE6E6E6), width: 1),
          //   //       ),
          //   //       child: Center(
          //   //         child: getCustomFont(
          //   //           filterList[index],
          //   //           14,
          //   //           getFontColor(context),
          //   //           1,
          //   //           fontWeight: FontWeight.w500,
          //   //         ),
          //   //       ),
          //   //     );
          //   //   },
          //   // ),
          // ),
          Container(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.shortByIndex = index;
                    controller.update();
                  },
                  child: Container(
                      height: 36,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: controller.shortByIndex == index
                            ? getAccentColor(context)
                            : Colors.transparent,
                        border: Border.all(
                            color: controller.shortByIndex == index
                                ? Colors.transparent
                                : Color(0xFFE6E6E6),
                            width: 1),
                      ),
                      child: Center(
                        child: getCustomFont(
                          shortByList[index],
                          17,
                          getFontColor(context),
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                );
              },
              itemCount: shortByList.length,
              separatorBuilder: (context, index) => SizedBox(
                width: 8,
              ),
            ),
          ),
          getVerSpace(24),
          getCustomFont(
            "Add Duration",
            18,
            getFontColor(context),
            1,
            fontWeight: FontWeight.w500,
          ),
          getVerSpace(16),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
                showValueIndicator: ShowValueIndicator.onlyForContinuous,
                trackHeight: 6.h,
                valueIndicatorColor: getAccentColor(context),
                // overlayShape: RoundSliderOverlayShape(overlayRadius: 1),
                thumbShape: CircleThumbShape(thumbRadius: 10.h),
                valueIndicatorTextStyle: buildTextStyle(
                    context,
                    getFontColor(context),
                    FontWeight.w500,
                    17) // This is what you are asking for

                ),
            child: GetBuilder<HomeFilterController>(
              builder: (controller) {
                return sliders.Slider(
                  label: "${controller.progress.toInt()} km",
                  thumbColor: getAccentColor(context),
                  activeColor: getAccentColor(context),
                  inactiveColor: Color(0xFFF4F4F4),
                  onChanged: (value) {
                    controller.changeProgress(value);
                  },
                  value: controller.progress,
                  max: 20,
                  min: 1,
                );
              },
            ),
          ),
          getVerSpace(32),
          // Expanded(
          //   child: getVerSpace(0),
          //   flex: 1,
          // ),
          Row(
            children: [
              Expanded(
                child: getSubButton(context, Colors.transparent, true, "Reset",
                    getFontColor(context), () {
                  controller.shortByIndex = 0;
                  controller.selectedIndex = 0;
                  controller.update();
                }, EdgeInsets.zero,
                    isBorder: true, borderColor: getFontColor(context)),
                flex: 1,
              ),
              getHorSpace(20.w),
              Expanded(
                child: getSubButton(
                  context,
                  getAccentColor(context),
                  true,
                  "Apply Filter",
                  Colors.black,
                  () {
                    Get.back();
                  },
                  EdgeInsets.zero,
                ),
                flex: 1,
              )
            ],
          ),
          // Expanded(
          //   child: getVerSpace(0),
          //   flex: 1,
          // )
          getVerSpace(24),
        ],
      );
    },
  );
}

Widget addRadioButton(BuildContext context, String title) {
  return GetBuilder<HomeFilterController>(
    builder: (controller) {
      bool selected = controller.selectedSort == title;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              controller.onClickRadioButton(title);
            },
            child: getSvgImageWithSize(
                context,
                (selected) ? "Radio_selected.svg" : "Radio_unselected.svg",
                24.h,
                24.h,
                color: (selected)
                    ? getAccentColor(context)
                    : getFontGreyColor(context)),
          ),
          getHorSpace(10.w),
          // Radio(
          //   onChanged: (value) {
          //     controller.onClickRadioButton(value.toString());
          //   },
          //   value: title,
          //   groupValue: controller.selectedSort,),
          getCustomFont(title, 16, getFontColor(context), 1,
              fontWeight: FontWeight.w500),
          getHorSpace(20.w)
        ],
      );
    },
  );
}
