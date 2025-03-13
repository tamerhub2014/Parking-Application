import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket.dart';
import 'package:flutter_parking_ui_new/app/routes/app_routes.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';

class MyBookingDetailsPage extends StatefulWidget {
  final ParkingTicket ticket;

  const MyBookingDetailsPage({Key? key, required this.ticket})
      : super(key: key);

  @override
  State<MyBookingDetailsPage> createState() => _MyBookingDetailsPageState();
}

class _MyBookingDetailsPageState extends State<MyBookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Booking Detail", () {
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
                                getCustomFont("${widget.ticket.parking?.name}",
                                    17, getFontColor(context), 1),
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
                      // color: Color(0xFFFFF8E5),
                      color: Color.fromARGB(255, 128, 205, 207),
                      border:
                          Border.all(color: getAccentColor(context), width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: getCustomFont(
                                "#${widget.ticket.parking?.placeId}",
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
                        // getVerSpace(12),
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
                                "${DateFormat("dd/MM/yyyy").format(widget.ticket.from ?? DateTime.now())}",
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
                                "${widget.ticket.to?.difference(widget.ticket.from ?? DateTime.now()).inHours} Hours",
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
                                "${DateFormat("hh:mm a").format(widget.ticket.from ?? DateTime.now())} - ${DateFormat("hh:mm a").format(widget.ticket.to ?? DateTime.now())}",
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
                  getVerSpace(40),
                  getButtonFigma(context, getAccentColor(context), true,
                      "Re-Booking", getFontColor(context), () {
                    Get.toNamed(Routes.parkingTimeScreen,
                        arguments: widget.ticket);
                    // Get.to(ParkingTimeScreen());
                  }, EdgeInsets.zero),
                  getVerSpace(32),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
