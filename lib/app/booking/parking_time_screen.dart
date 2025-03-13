import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../home/data/models/parking_ticket.dart';
import '../routes/app_routes.dart';
import 'data/repos/parking_tickets_repo.dart';

class ParkingTimeScreen extends StatefulWidget {
  final ParkingTicket ticket;

  const ParkingTimeScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParkingTimeScreen();
  }
}

class _ParkingTimeScreen extends State<ParkingTimeScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getToolbarWidget(context, "Parking time", () {
              Get.back();
            }),
            Expanded(
                child: ListView(
                  padding: edgeInsets,
                  shrinkWrap: true,
                  children: [
                    getVerSpace(32),
                    Center(
                        child: getAssetImage(
                            context, "parkingTime.png", 120, 125)),
                    getVerSpace(15),
                    Column(
                      children: [
                        getCustomFont(() {
                          final now = DateTime.now();
                          final toTime = widget.ticket.to;
                          if (toTime != null && toTime.isAfter(now)) {
                            final difference = toTime.difference(now);
                            final hours =
                                difference.inHours.toString().padLeft(2, '0');
                            final minutes = (difference.inMinutes % 60)
                                .toString()
                                .padLeft(2, '0');
                            final seconds = (difference.inSeconds % 60)
                                .toString()
                                .padLeft(2, '0');
                            return "$hours:$minutes:$seconds";
                          } else {
                            return "00:00:00";
                          }
                        }(), 22, getFontColor(context), 1,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                    getVerSpace(8),
                    Center(
                      child: getCustomFont("Parking Time Remaining", 15,
                          getFontGreyColor(context), 1,
                          fontWeight: FontWeight.w400),
                    ),
                    getVerSpace(32),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0F000000),
                            blurRadius: 23,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // margin: EdgeInsets.symmetric(horizontal: 40.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont(
                                        "Name", 17, getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont(
                                        "${widget.ticket.parking?.name}",
                                        17,
                                        getFontGreyColor(context),
                                        1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Vehicle", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont("Toypta Fortuner", 17,
                                        getFontGreyColor(context), 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          getVerSpace(27),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Parking Slot", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont("A05 Ground Floor", 17,
                                        getFontGreyColor(context), 1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Parking Slot", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont("A05 Ground Floor", 17,
                                        getFontGreyColor(context), 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          getVerSpace(27),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Arrive Time", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont(
                                        "${DateFormat("hh:mm a").format(widget.ticket.from ?? DateTime.now())}",
                                        17,
                                        getFontGreyColor(context),
                                        1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Exit Time", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont(
                                        "${DateFormat("hh:mm a").format(widget.ticket.to ?? DateTime.now())}",
                                        17,
                                        getFontGreyColor(context),
                                        1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          getVerSpace(27),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont(
                                        "Date", 17, getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont(
                                        "${DateFormat("dd MMMM yyyy").format(widget.ticket.from ?? DateTime.now())}",
                                        17,
                                        getFontGreyColor(context),
                                        1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("Total Amount", 17,
                                        getFontColor(context), 1),
                                    getVerSpace(4),
                                    getCustomFont("\$10.8", 17,
                                        getFontGreyColor(context), 1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    getVerSpace(32),
                    getButtonFigma(context, getAccentColor(context), true,
                        "End Parking Time", Colors.black, () async {
                      await ParkingTicketsRepo.updateParkingTicketCompleted(
                          widget.ticket.id);

                      Get.offAllNamed(Routes.homeScreenRoute);
                    }, EdgeInsets.zero),
                    getVerSpace(20.h),
                    getButtonFigma(
                        context,
                        Colors.transparent,
                        true,
                        borderColor: getFontColor(context),
                        "Extend Parking Time",
                        Colors.black, () {
                      Constant.sendToNext(context, Routes.extendTimeScreen,
                          arguments: widget.ticket);
                    }, isBorder: true, EdgeInsets.zero),
                    getVerSpace(32.h),
                  ],
                ),
                flex: 1),
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(BuildContext context, String title1, String title2,
      Color color, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 9.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: getCustomFont(title1, fontSize, color, 1,
                fontWeight: FontWeight.w500),
            flex: 1,
          ),
          getCustomFont(title2, fontSize, color, 1, fontWeight: FontWeight.w500)
        ],
      ),
    );
  }

  Widget buildListWidget(BuildContext context, String title, String desc,
      String title2, String desc2) {
    return getPaddingWidget(
        EdgeInsets.symmetric(vertical: 10.h),
        Row(
          children: [
            buildDetailItem(context, title, desc),
            buildDetailItem(context, title2, desc2),
          ],
        ));
  }

  Expanded buildDetailItem(
      BuildContext context, String title, String subtitle) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont(title, 16, getFontGreyColor(context), 1,
              fontWeight: FontWeight.w500),
          getVerSpace(6.h),
          getCustomFont(subtitle, 16, getFontColor(context), 1,
              fontWeight: FontWeight.w500)
        ],
      ),
      flex: 1,
    );
  }
}
