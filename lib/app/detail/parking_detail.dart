import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../book_slot_screen/book_slot_screen.dart';
import '../home/data/models/parking_model.dart';
import '../model/model_category.dart';
import '../model/select_vehicale_model.dart';
import '../profile/controller/select_vehicle_controller.dart';
import '../profile/my_vehicle_screen.dart';
import 'controller/parking_details_controller.dart';

class ParkingDetailScreen extends StatefulWidget {
  final ParkingModel parking;
  const ParkingDetailScreen({super.key, required this.parking});

  @override
  State<StatefulWidget> createState() {
    return _ScreenLocationDetail();
  }
}

class _ScreenLocationDetail extends State<ParkingDetailScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    controller.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() {});
    super.initState();
  }

  ParkingDetailController controller = Get.put(ParkingDetailController());
  // List<String> strList=[]
  List<ModelCategory> facList = DataFile.getAllFacilitiesList();

  finish() {
    Constant.backToPrev(context);
  }

  List<String> text = ["CCTV", "Elevator", "Car Wash", "24*7", "Pickup"];

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    List<SelectVehicleModel> vehicleList = DataFile.getSelectVehicleList();

    // ignore: deprecated_member_use
    return WillPopScope(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
            appBar: getInVisibleAppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // getVerSpace(10.h),
                getToolbarWidget(context, "Parking Detail", () {
                  Get.back();
                }),
                GetBuilder<ParkingDetailController>(
                  init: ParkingDetailController(),
                  builder: (controller) {
                    return Expanded(
                      child: ListView(
                        children: [
                          getVerSpace(20),
                          getPaddingWidget(
                            edgeInsets,
                            getAssetImage(context, "detailsImage.png",
                                double.infinity, 200.h,
                                boxFit: BoxFit.contain),
                          ),
                          getVerSpace(32.h),
                          getPaddingWidget(
                            edgeInsets,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: getCustomFont(
                                          "${widget.parking.name}",
                                          20,
                                          getFontColor(context),
                                          1,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    GestureDetector(
                                        onTap: () async {
                                          // await FlutterShare.share(
                                          //     title: 'Example share',
                                          //     text: 'Example share text',
                                          //     linkUrl: 'https://flutter.dev/',
                                          //     chooserTitle: 'Example Chooser Title');
                                        },
                                        child: getAssetImage(
                                            context, "share.png", 32, 32))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    getAssetImage(context, "location_black.png",
                                        16.h, 16.h),
                                    // getSvgImageWithSize(
                                    //   context, "location_black.png", 16.h, 16.h,
                                    //   // color: getFontColor(context)
                                    // ),
                                    getHorSpace(8.h),
                                    Expanded(
                                      child: getCustomFont(
                                          "20m Right To Parking Spot",
                                          15,
                                          Color(0xFF7D7D7D),
                                          1,
                                          fontWeight: FontWeight.w400),
                                      flex: 1,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          getVerSpace(15.h),
                          getPaddingWidget(
                              edgeInsets,
                              Divider(
                                height: 1.h,
                                color: Color(0xFFF4F4F4),
                              )),
                          getVerSpace(16.h),
                          getPaddingWidget(
                            edgeInsets,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                getAssetImage(
                                    context, "location_container.png", 28, 28),
                                // getSvgImageWithSize(
                                //     context, "location.svg", 28, 28),
                                getHorSpace(10.h),
                                Expanded(
                                  child: Text(
                                    '2.5 KM',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.sp,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                // getHorSpace(28),
                                getAssetImage(context, "clock.png", 28, 28),
                                getHorSpace(10.h),
                                Text(
                                  '8:00AM-9:00PM',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                getHorSpace(28),
                                getAssetImage(context, "rating.png", 28, 28),
                                getHorSpace(10.h),
                                Text(
                                  '${widget.parking.rating ?? 5.0}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.sp,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                          getVerSpace(28.h),
                          getPaddingWidget(
                            edgeInsets,
                            getButtonFigma(
                              context,
                              buttonheight: 40,
                              getAccentColor(context),
                              true,
                              "Direction",
                              Colors.transparent,
                              () {
                                launchPDFUrl(
                                  Uri.parse(
                                    "https://www.google.com/maps/search/?api=1&query=${widget.parking.latitude},${widget.parking.longitude}",
                                  ),
                                );
                              },
                              EdgeInsets.zero,
                              isBorder: true,
                              buttonRedius: 20,
                              borderColor: Colors.transparent,
                            ),
                          ),
                          controller.tabBarController!.index == 1
                              ? Container()
                              : getVerSpace(32.h),
                          controller.tabBarController!.index == 1
                              ? Container()
                              : getPaddingWidget(
                                  edgeInsets,
                                  getCustomFont("Facilities", 20,
                                      getFontColor(context), 1,
                                      fontWeight: FontWeight.w700),
                                ),
                          getVerSpace(16.h),
                          controller.tabBarController!.index == 1
                              ? Container()
                              : Container(
                                  height: 40,
                                  child: ListView.separated(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 36,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 6),
                                          decoration: ShapeDecoration(
                                            color: Color.fromARGB(
                                                255, 128, 205, 207),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              text[index],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp,
                                                fontFamily: 'SF Pro Display',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return getHorSpace(12);
                                      },
                                      itemCount: text.length),
                                ),
                          getVerSpace(32.h),
                          getPaddingWidget(
                            edgeInsets,
                            TabBar(
                                onTap: (value) {
                                  controller.tabBarController!.index = value;
                                  controller.update();
                                },
                                indicatorPadding: EdgeInsets.zero,
                                controller: controller.tabBarController,
                                indicatorWeight: 1,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                indicatorColor: getAccentColor(context),
                                padding: EdgeInsets.zero,
                                dividerColor: Color(0xFFF4F4F4),
                                unselectedLabelColor: Color(0xFF7D7D7D),
                                labelColor: Colors.black,
                                tabAlignment: TabAlignment.start,
                                unselectedLabelStyle: TextStyle(
                                  color: Color(0xFF7D7D7D),
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.label,
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                                tabs: [
                                  Tab(
                                    text: "Description",
                                  ),
                                  Tab(
                                    text: "Image",
                                  ),
                                ]),
                          ),
                          getVerSpace(25),
                          getPaddingWidget(
                            edgeInsets,
                            Container(
                              height: 90,
                              child: TabBarView(
                                  controller: controller.tabBarController,
                                  children: [
                                    ReadMoreText(
                                      "Lorem ipsum dolor sit amet, "
                                              "consectetur adipiscing elit, sed do eiusmod tempor "
                                              "incididunt ut labore et dolore magna aliqua. Justo donec  "
                                          .tr,
                                      trimLines: 3,
                                      lessStyle: TextStyle(
                                        color: getFontColor(context),
                                        fontSize: 17,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),

                                      style: TextStyle(
                                        color: getFontGreyColor(context),
                                        fontSize: 17,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: 'See more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(
                                        color: getFontColor(context),
                                        fontSize: 17,
                                        fontFamily: 'Satoshi',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            child: getAssetImage(context,
                                                "homeImage1.png", 79, 73)),
                                        getHorSpace(20),
                                        Expanded(
                                            child: getAssetImage(context,
                                                "homeImage2.png", 79, 73)),
                                        getHorSpace(20),
                                        Expanded(
                                            child: getAssetImage(context,
                                                "homeImage3.png", 79, 73)),
                                        getHorSpace(20),
                                        Expanded(
                                            child: getAssetImage(context,
                                                "homeImage4.png", 79, 73)),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                          // getPaddingWidget(
                          //     edgeInsets,
                          //     getMultilineCustomFont(
                          //         "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit Read More",
                          //         14,
                          //         getFontGreyColor(context),
                          //         fontWeight: FontWeight.w400)),
                          getVerSpace(25.h),
                          controller.tabBarController!.index == 1
                              ? Container()
                              : getPaddingWidget(
                                  edgeInsets,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: getCustomFont("Select Vehicle",
                                            20, getFontColor(context), 1,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(MyVehicleScreen());
                                        },
                                        child: getCustomFont("See all", 15,
                                            getFontGreyColor(context), 1,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                ),
                          getVerSpace(16.h),
                          controller.tabBarController!.index == 1
                              ? Container()
                              : getPaddingWidget(
                                  edgeInsets,
                                  GetBuilder<SelectVehicleController>(
                                    init: SelectVehicleController(),
                                    builder: (controller) {
                                      return ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 20.h),
                                          itemBuilder: (context, index) {
                                            SelectVehicleModel
                                                selectVehicleModel =
                                                vehicleList[index];
                                            // bool isSelected=controller.selectedIndex.value==index;
                                            return GestureDetector(
                                              onTap: () {
                                                controller.isSelectedDetails
                                                    .value = index;
                                                controller.update();
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 48.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF9F9F9),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    color: Color(0xFFE6E6E6),
                                                    width: 1,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 8.h),
                                                  child: Row(
                                                    children: [
                                                      getAssetImage(
                                                          context,
                                                          selectVehicleModel
                                                              .image!,
                                                          32,
                                                          32),
                                                      getHorSpace(10),
                                                      Expanded(
                                                          child: getCustomFont(
                                                              selectVehicleModel
                                                                  .text!,
                                                              17,
                                                              getFontColor(
                                                                  context),
                                                              1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                      getAssetImage(
                                                          context,
                                                          controller.isSelectedDetails
                                                                      .value ==
                                                                  index
                                                              ? "select_radio.png"
                                                              : "unselect_radio.png",
                                                          24,
                                                          24),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          itemCount: 2,
                                          shrinkWrap: true);
                                    },
                                  )),
                          getVerSpace(32)
                          // Container(
                          //   height: 58.h,
                          //   child: ListView.builder(
                          //     itemBuilder: (context, index) {
                          //       ModelCategory modelCat = facList[index];
                          //       return Container(
                          //         margin: EdgeInsets.only(
                          //             left: (index == 0) ? horSpace : 24.w,
                          //             right: (index == facList.length - 1)
                          //                 ? horSpace
                          //                 : 24.w),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             getSvgImageWithSize(
                          //                 context, modelCat.image, 34.h, 34.h,
                          //                 fit: BoxFit.fill),
                          //             Expanded(
                          //               child: getVerSpace(0),
                          //               flex: 1,
                          //             ),
                          //             getCustomFont(modelCat.title, 12,
                          //                 getFontColor(context), 1,
                          //                 fontWeight: FontWeight.w500)
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //     itemCount: facList.length,
                          //     padding: EdgeInsets.zero,
                          //     scrollDirection: Axis.horizontal,
                          //   ),
                          // ),
                          // getVerSpace(20.h),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: horSpace, vertical: 10.h),
                          //   width: double.infinity,
                          //   height: 56.h,
                          //   decoration: getButtonDecoration(getCardColor(context),
                          //       withCorners: true,
                          //       corner: 6.h,
                          //       shadow: [
                          //         BoxShadow(
                          //             color: Color.fromRGBO(
                          //                 61, 61, 61, 0.11999999731779099),
                          //             offset: Offset(-4, 8),
                          //             blurRadius: 25)
                          //       ]),
                          //   child: InkWell(
                          //     onTap: () {
                          //       Constant.sendToNext(
                          //           context, Routes.dateTimeSelectorScreen);
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         getSvgImageWithSize(
                          //             context, "calendar.svg", 24.h, 24.h,
                          //             color: getFontColor(context)),
                          //         getHorSpace(18.w),
                          //         getCustomFont("Select Date & Time", 16,
                          //             getFontColor(context), 1,
                          //             fontWeight: FontWeight.w500)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: horSpace, vertical: 10.h),
                          //   width: double.infinity,
                          //   height: 56.h,
                          //   decoration: getButtonDecoration(getCardColor(context),
                          //       withCorners: true,
                          //       corner: 6.h,
                          //       shadow: [
                          //         BoxShadow(
                          //             color: Color.fromRGBO(
                          //                 61, 61, 61, 0.11999999731779099),
                          //             offset: Offset(-4, 8),
                          //             blurRadius: 25)
                          //       ]),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       getSvgImageWithSize(
                          //           context, "parking_area.svg", 24.h, 24.h,
                          //           color: getFontColor(context)),
                          //       getHorSpace(18.w),
                          //       InkWell(
                          //         onTap: () {
                          //           Constant.sendToNext(
                          //               context, Routes.chooseParkingSlotScreen);
                          //         },
                          //         child: getCustomFont("Choose Parking Slot", 16,
                          //             getFontColor(context), 1,
                          //             fontWeight: FontWeight.w500),
                          //       )
                          //     ],
                          //   ),
                          // ),
                          // getVerSpace(20.h),
                        ],
                      ),
                      flex: 1,
                    );
                  },
                ),
                getPaddingWidget(
                  edgeInsets,
                  getButtonFigma(context, getAccentColor(context), true,
                      "Booking", Colors.black, () {
                    Get.to(() => BookASlotScreen(
                          parking: widget.parking,
                        ));
                    // Constant.sendToNext(context, Routes.bookingConfirmationScreen);
                  }, EdgeInsets.zero),
                ),
                getVerSpace(20.h),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
}

void launchPDFUrl(Uri pdfUrl) async {
  if (await canLaunchUrl(pdfUrl)) {
    await launchUrl(pdfUrl);
    print("done");
  } else {
    throw 'Could not launch $pdfUrl';
  }
}
