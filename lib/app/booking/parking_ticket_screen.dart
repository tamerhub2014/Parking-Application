import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';

class ParkingTicketScreen extends StatefulWidget {
  final ParkingTicketBody ticket;

  const ParkingTicketScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ParkingTicketScreen();
  }
}

class _ParkingTicketScreen extends State<ParkingTicketScreen> {
  finish() {
    Constant.sendToNext(context, Routes.homeScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return WillPopScope(
      onWillPop: () async {
        finish();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getToolbarWidget(context, "E-Receipt", () {
                finish();
              }),
              getVerSpace(22.h),

              Expanded(
                child: getPaddingWidget(
                  edgeInsets,
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      getAssetImage(
                          context, "Subtract.png", double.infinity, 600),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45.0, vertical: 30.0),
                        child: Column(
                          children: [
                            getCustomFont("${widget.ticket.parking?.vicinity}",
                                22, Colors.white, 1),
                            getVerSpace(22.h),
                            getAssetImage(context, "scan_qe.png", 150, 150),
                            getVerSpace(78.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Name", 17, Colors.white, 1),
                                      getVerSpace(4),
                                      getCustomFont(
                                          "${widget.ticket.parking?.name}",
                                          15,
                                          getFontGreyColor(context),
                                          1),
                                    ],
                                  ),
                                ),
                                getHorSpace(20),
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       getCustomFont(
                                //           "Vehicle", 17, Colors.white, 1),
                                //       getVerSpace(4),
                                //       getCustomFont("Toypta Fortuner", 15,
                                //           getFontGreyColor(context), 1),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            getVerSpace(18.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Parking Slot", 17, Colors.white, 1),
                                      getVerSpace(4),
                                      getCustomFont("A05 Ground Floor", 15,
                                          getFontGreyColor(context), 1),
                                    ],
                                  ),
                                ),
                                getHorSpace(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Duration", 17, Colors.white, 1),
                                      getVerSpace(4),
                                      getCustomFont(
                                          "${widget.ticket.to?.difference(widget.ticket.from ?? DateTime.now()).inHours} Hour",
                                          15,
                                          getFontGreyColor(context),
                                          1),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            getVerSpace(18.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Hours", 17, Colors.white, 1),
                                      getVerSpace(4),
                                      getCustomFont(
                                          "${DateFormat("hh:mm a").format(widget.ticket.from ?? DateTime.now())} - ${DateFormat("hh:mm a").format(widget.ticket.to ?? DateTime.now())}",
                                          15,
                                          getFontGreyColor(context),
                                          1),
                                    ],
                                  ),
                                ),
                                getHorSpace(20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(
                                          "Date", 17, Colors.white, 1),
                                      getVerSpace(4),
                                      getCustomFont(
                                          "${DateFormat.yMd().format(widget.ticket.from ?? DateTime.now())}",
                                          15,
                                          getFontGreyColor(context),
                                          1),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              getVerSpace(34.h),
              getButtonFigma(context, getAccentColor(context), true,
                  "Get Direction", Colors.black, () {
                String googleUrl =
                    "https://www.google.com/maps/search/?api=1&query=${widget.ticket.parking?.latitude},${widget.ticket.parking?.longitude}";
                launchUrlString(googleUrl);
              }, edgeInsets),
              // getVerSpace(15.h),
              // getButtonFigma(
              //   context,
              //   Colors.transparent,
              //   true,
              //   "Not Now",
              //   getFontColor(context),
              //   () {},
              //   edgeInsets,
              //   isBorder: true,
              //   borderColor: getFontColor(context),
              // ),
              getVerSpace(37.h),
            ],
          ),
        ),
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
