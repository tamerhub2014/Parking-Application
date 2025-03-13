import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/booking/data/repos/parking_tickets_repo.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class TransactionDetailScreen extends StatefulWidget {
  final ParkingTicketBody parkingTicketBody;
  const TransactionDetailScreen({Key? key, required this.parkingTicketBody})
      : super(key: key);

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getToolbarWidget(context, "Transaction Detail", () {
              Get.back();
            }),
            getVerSpace(32),
            Expanded(
                child: getPaddingWidget(
              edgeInsets,
              ListView(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 23,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getAssetImage(context, "homeImage1.png", 64, 64),
                          getHorSpace(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                getCustomFont(
                                    "${widget.parkingTicketBody.parking?.name}",
                                    17,
                                    getFontColor(context),
                                    1),
                                getVerSpace(8),
                                Row(
                                  children: [
                                    getAssetImage(
                                        context, "location_black.png", 16, 16),
                                    getHorSpace(6),
                                    getCustomFont("20m Right To Parking Spot",
                                        15, getFontGreyColor(context), 1)
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  getVerSpace(24),
                  getCustomFont("Parking ID", 16, getFontColor(context), 1,
                      fontWeight: FontWeight.w600),
                  getVerSpace(8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 12, top: 10, bottom: 8, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xFFFFF8E5),
                      border:
                          Border.all(color: getAccentColor(context), width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: getCustomFont(
                                "#${widget.parkingTicketBody.parking?.placeId}",
                                15,
                                getFontColor(context),
                                1)),
                        getAssetImage(context, "copy.png", 20, 20)
                      ],
                    ),
                  ),
                  getVerSpace(24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 23,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: getCustomFont("Vehicle Type", 17,
                        //             getFontGreyColor(context), 1)),
                        //     getCustomFont("Toyota Fortuner (SUV)", 15,
                        //         getFontColor(context), 1)
                        //   ],
                        // ),
                        // getVerSpace(12),
                        // Divider(
                        //   color: Color(0xFFF4F4F4),
                        //   thickness: 1,
                        //   height: 1,
                        // ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont("Parking Slot", 17,
                                    getFontGreyColor(context), 1)),
                            getCustomFont("A 05 Ground Floor", 15,
                                getFontColor(context), 1)
                          ],
                        ),
                        getVerSpace(12),
                        Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 1,
                          height: 1,
                        ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont(
                                    "Date", 17, getFontGreyColor(context), 1)),
                            getCustomFont(
                                "${DateFormat("dd/MM/yyyy").format(widget.parkingTicketBody.from ?? DateTime.now())}",
                                15,
                                getFontColor(context),
                                1)
                          ],
                        ),
                        getVerSpace(12),
                        Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 1,
                          height: 1,
                        ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont("Duration", 17,
                                    getFontGreyColor(context), 1)),
                            getCustomFont(
                                "${widget.parkingTicketBody.to?.difference(widget.parkingTicketBody.from ?? DateTime.now()).inHours} Hours",
                                15,
                                getFontColor(context),
                                1)
                          ],
                        ),
                        getVerSpace(12),
                        Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 1,
                          height: 1,
                        ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont(
                                    "Hours", 17, getFontGreyColor(context), 1)),
                            getCustomFont(
                                "${DateFormat("hh:mm a").format(widget.parkingTicketBody.from ?? DateTime.now())} - ${DateFormat("hh:mm a").format(widget.parkingTicketBody.to ?? DateTime.now())}",
                                15,
                                getFontColor(context),
                                1)
                          ],
                        ),
                        // getVerSpace(12),
                        // Divider(
                        //   color: Color(0xFFF4F4F4),
                        //   thickness: 1,
                        //   height: 1,
                        // ),
                        // getVerSpace(12),
                      ],
                    ),
                  ),
                  getVerSpace(24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 23,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont("Total Amount", 17,
                                    getFontGreyColor(context), 1)),
                            getCustomFont("\$10", 17, getFontColor(context), 1)
                          ],
                        ),
                        getVerSpace(12),
                        Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 1,
                          height: 1,
                        ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont("Tax (10 %)", 17,
                                    getFontGreyColor(context), 1)),
                            getCustomFont("\$0.8", 15, getFontColor(context), 1)
                          ],
                        ),
                        getVerSpace(12),
                        Divider(
                          color: Color(0xFFF4F4F4),
                          thickness: 1,
                          height: 1,
                        ),
                        getVerSpace(12),
                        Row(
                          children: [
                            Expanded(
                                child: getCustomFont(
                                    "Total", 17, getFontColor(context), 1)),
                            getCustomFont(
                                "\$10.8", 15, getFontColor(context), 1)
                          ],
                        ),
                      ],
                    ),
                  ),
                  getVerSpace(24),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 12, top: 10, bottom: 8, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xFFFFF8E5),
                      border:
                          Border.all(color: getAccentColor(context), width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getAssetImage(context, "mastercard.png", 24, 24),
                        getHorSpace(16),
                        Expanded(
                            child: getCustomFont(
                                "Mastercard", 17, getFontColor(context), 1)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: getCustomFont(
                              "Change", 17, getAccentColor(context), 1,
                              fontWeight: FontWeight.w400),
                        ),
                        // getAssetImage(context, "copy.png", 20, 20)
                      ],
                    ),
                  ),
                  getVerSpace(40),
                ],
              ),
            )),
            getButtonFigma(context, getAccentColor(context), true, "Continue",
                getFontColor(context), () async {
              ParkingTicketsRepo.addParkingTicket(widget.parkingTicketBody);

              Get.dialog(AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  surfaceTintColor: Colors.transparent,
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.h),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Constant.assetImagePath + "successful.png",
                              width: 120.h,
                              height: 120.h,
                            ),
                            // getAssetImage(context, "successful.png", 120, 120),
                            getVerSpace(24.h),
                            getCustomFont("Reservation Successful!", 28,
                                getFontColor(context), 1,
                                fontWeight: FontWeight.w700),
                            getCustomFont(
                                "You parking slot successfully booked. You can check your booking on home menu.",
                                14,
                                getFontGreyColor(context),
                                2,
                                fontWeight: FontWeight.w500,
                                textAlign: TextAlign.center,
                                txtHeight: 1.5),
                            getVerSpace(40.h),
                            getButtonFigma(context, getAccentColor(context),
                                true, "View Parking Ticket", Colors.black, () {
                              Get.back();
                              Constant.sendToNext(
                                  context, Routes.parkingTicketScreen,
                                  arguments: widget.parkingTicketBody);
                            }, EdgeInsets.symmetric(horizontal: 28.w)),
                            getVerSpace(20.h),
                            getButtonFigma(
                              context,
                              Colors.transparent,
                              true,
                              "Cancel",
                              Colors.black,
                              () {
                                Get.offAllNamed(Routes.homeScreenRoute);
                              },
                              EdgeInsets.symmetric(horizontal: 28.w),
                              isBorder: true,
                              borderColor: getFontColor(context),
                            )
                          ],
                        ),
                      ),
                    ),
                  )));

              // Get.to(ParkingTimeScreen());
            }, edgeInsets),
            getVerSpace(32),
          ],
        ),
      ),
    );
  }
}
