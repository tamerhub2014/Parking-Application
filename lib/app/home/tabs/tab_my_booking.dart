import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/data/data_file.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/color_data.dart';
import '../../../base/widget_utils.dart';
import '../../booking/data/repos/parking_tickets_repo.dart';
import '../../model/model_my_booking.dart';
import '../../my_booking_screen/my_booking_details_screen.dart';

class TabMyBooking extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabMyBooking();
  }
}

class _TabMyBooking extends State<TabMyBooking> {
  int selectedIndex = 0;
  List<String> orderTabList = ["Ongoing", "Completed"];

  List<ModelMyBooking> bookingList = DataFile.getAllOnGoingBookings();
  List<ModelMyBooking> bookingHistoryList = DataFile.getAllHistoryBookings();
  // List<ModelMyBooking> cancelledBookingsList = DataFile.getCancelledBookings();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: getCustomFont("Bookmark", 22, getFontColor(context), 1,
                fontWeight: FontWeight.w700),
          ),
          getVerSpace(31.h),
          getPaddingWidget(
              EdgeInsets.symmetric(horizontal: 10.w),
              Row(
                children: List.generate(orderTabList.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        width: double.infinity,
                        height: 36.h,
                        decoration: getButtonDecoration(
                          (selectedIndex == index)
                              ? getFontColor(context)
                              : Colors.transparent,
                          withCorners: true,
                          corner: 18.h,
                          withBorder: (selectedIndex != index),
                          borderColor: (selectedIndex != index)
                              ? Color(0xFFE6E6E6)
                              : Colors.transparent,
                        ),
                        child: Center(
                            child: getCustomFont(
                                orderTabList[index],
                                16,
                                (selectedIndex == index)
                                    ? Colors.white
                                    : getFontColor(context),
                                1,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center)),
                      ),
                    ),
                    flex: 1,
                  );
                }),
              )),
          getVerSpace(26.h),
          Expanded(
            child: (selectedIndex == 0)
                ? FutureBuilder<List<ParkingTicket>>(
                    future: ParkingTicketsRepo.getParkingTickets(
                        ParkingTicketStatus.pending),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No items found."));
                      }

                      final items = snapshot.data!;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return buildBookingItemContainer(
                              horSpace,
                              context,
                              Column(
                                children: [
                                  buildBookingItem(
                                      context, items[index], false),
                                  getVerSpace(24.h),
                                  getSubButton(
                                    context,
                                    getAccentColor(context),
                                    true,
                                    "View Detail",
                                    getFontColor(context),
                                    () {
                                      Get.to(() => MyBookingDetailsPage(
                                          ticket: items[index]));
                                    },
                                    EdgeInsets.zero,
                                  )
                                ],
                              ),
                              () {});
                        },
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                      );
                    })
                : selectedIndex == 1
                    ? FutureBuilder<List<ParkingTicket>>(
                        future: ParkingTicketsRepo.getParkingTickets(
                            ParkingTicketStatus.completed),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No items found."));
                          }

                          final items = snapshot.data!;

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return buildBookingItemContainer(
                                  horSpace,
                                  context,
                                  Column(
                                    children: [
                                      buildBookingItem(
                                          context, items[index], false),
                                      getVerSpace(24.h),
                                      // getSubButton(
                                      //   context,
                                      //   getAccentColor(context),
                                      //   true,
                                      //   "View Detail",
                                      //   getFontColor(context),
                                      //   () {
                                      //     Get.to(() => MyBookingDetailsPage(
                                      //         ticket: items[index]));
                                      //   },
                                      //   EdgeInsets.zero,
                                      // )
                                    ],
                                  ),
                                  () {});
                            },
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                          );
                        })
                    : FutureBuilder<List<ParkingTicket>>(
                        future: ParkingTicketsRepo.getParkingTickets(
                            ParkingTicketStatus.completed),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError) {
                            return Center(
                                child: Text("Error: ${snapshot.error}"));
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(child: Text("No items found."));
                          }

                          final items = snapshot.data!;

                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return buildBookingItemContainer(
                                  horSpace,
                                  context,
                                  Column(
                                    children: [
                                      buildBookingItem(
                                          context, items[index], false),
                                      getVerSpace(24.h),
                                      // getSubButton(
                                      //   context,
                                      //   getAccentColor(context),
                                      //   true,
                                      //   "View Detail",
                                      //   getFontColor(context),
                                      //   () {
                                      //     Get.to(() => MyBookingDetailsPage(
                                      //         ticket: items[index]));
                                      //   },
                                      //   EdgeInsets.zero,
                                      // )
                                    ],
                                  ),
                                  () {});
                            },
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: items.length,
                          );
                        }),
            flex: 1,
          )
          // Expanded(
          //   child: ListVi,
          //   flex: 1,
          // )
        ],
      ),
    );
  }

  Container buildBookingItemContainer(
      double horSpace, BuildContext context, Widget child, Function function) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: getButtonDecoration(getCardColor(context),
          withCorners: true,
          corner: 12.h,
          shadow: [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 23,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      margin: EdgeInsets.symmetric(horizontal: horSpace, vertical: 10.h),
      child: InkWell(
          onTap: () {
            function();
          },
          child: child),
    );
  }

  Widget buildBookingItem(
      BuildContext context, ParkingTicket ticket, bool isHistory) {
    return Row(
      children: [
        getAssetImage(context, "homeImage1.png", 80, 80, boxFit: BoxFit.cover),
        getHorSpace(20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCustomFont(
                  ticket.parking?.name ?? "", 17, getFontColor(context), 1,
                  fontWeight: FontWeight.w400),
              getVerSpace(2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getAssetImage(context, "location_black.png", 16, 16),
                  // getSvgImageWithSize(context, "location.svg", 16.h, 16.h),
                  getHorSpace(6.w),
                  Expanded(
                    child: getCustomFont(ticket.parking?.vicinity ?? "", 15,
                        getFontGreyColor(context), 1,
                        fontWeight: FontWeight.w500),
                    flex: 1,
                  )
                ],
              ),
              getVerSpace(2.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: ticket.id,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      // text: '/hr',
                      text: "",
                      style: TextStyle(
                        color: Color(0xFF7D7D7D),
                        fontSize: 15.sp,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          flex: 1,
        )
      ],
    );
  }
}
