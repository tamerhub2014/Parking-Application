import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_parking_ui_new/app/payment/data/repos/payment_cards_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../data/data_file.dart';
import '../home/data/models/payment_card_model.dart';
import '../model/model_payment_list.dart';
import '../routes/app_routes.dart';
import 'data/repos/parking_tickets_repo.dart';

class ExtendTimeScreen extends StatefulWidget {
  final ParkingTicket ticket;

  const ExtendTimeScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ExtendTimeScreen();
  }
}

class _ExtendTimeScreen extends State<ExtendTimeScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<ModelPaymentList> allPaymentList = DataFile.getAllPaymentList();
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  List<String> orderTabList = ["15 Min", "30 Min", "45 Min", "1 Hour"];
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
            getToolbarWidget(context, "Payment Method", () {
              Get.back();
            }),
            Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    getVerSpace(32.h),
                    getPaddingWidget(
                        edgeInsets,
                        Row(
                          children: List.generate(orderTabList.length, (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex1 = index;
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  width: double.infinity,
                                  height: 36.h,
                                  decoration: getButtonDecoration(
                                    (selectedIndex1 == index)
                                        ? getFontColor(context)
                                        : Colors.transparent,
                                    withCorners: true,
                                    corner: 18.h,
                                    withBorder: (selectedIndex1 != index),
                                    borderColor: (getFontGreyColor(context)),
                                  ),
                                  child: Center(
                                      child: getCustomFont(
                                          orderTabList[index],
                                          16,
                                          (selectedIndex1 == index)
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
                    getVerSpace(32.h),
                    getPaddingWidget(
                        edgeInsets,
                        getCustomFont(
                            "Choose Payment", 16, getFontColor(context), 1,
                            fontWeight: FontWeight.w600)),
                    getVerSpace(15.h),
                    FutureBuilder<List<PaymentCardModel>>(
                        future: PaymentCardsRepo.getPaymentCards(),
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
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return buildPaymentContainer(
                                  EdgeInsets.symmetric(horizontal: 16),
                                  0,
                                  index,
                                  context,
                                  items[index], () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              }, selectedIndex);
                            },
                            itemCount: items.length,
                            primary: false,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                          );

                          ///
                        }),
                  ],
                ),
                flex: 1),
            getVerSpace(25.h),
            getButtonFigma(context, getAccentColor(context), true, "Pay \$ 4.5",
                Colors.black, () async {
              final newTo = widget.ticket.to!
                  .toUtc()
                  .add(Duration(minutes: (selectedIndex1 + 1) * 15));

              await ParkingTicketsRepo.updateParkingTicketEndingTime(
                  widget.ticket.id, newTo);

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
                                context,
                                Routes.parkingTicketScreen,
                                arguments: ParkingTicketBody(
                                  userId: widget.ticket.userId,
                                  parking: widget.ticket.parking,
                                  from: widget.ticket.from,
                                  to: newTo,
                                ),
                              );
                            }, EdgeInsets.symmetric(horizontal: 28.w)),
                            getVerSpace(20.h),
                            getButtonFigma(
                              context,
                              Colors.transparent,
                              true,
                              "Cancel",
                              Colors.black,
                              () {
                                Constant.sendToNext(
                                    context, Routes.homeScreenRoute);
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

              // Get.defaultDialog(backgroundColor: Colors.white,
              //     title: "",
              //     content: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(16.h),),
              //       child: Column(
              //         children: [
              //           Image.asset(
              //             Constant.assetImagePath + "check_img.png",
              //             width: 179.h,
              //             height: 155.h,
              //           ),
              //           getVerSpace(12.h),
              //           getCustomFont(
              //               "Successful!", 28, getFontColor(context), 1,
              //               fontWeight: FontWeight.w700),
              //           getCustomFont(
              //               "Successfully made payment for you\nparking",
              //               14,
              //               getFontColor(context),
              //               2,
              //               fontWeight: FontWeight.w500,
              //               textAlign: TextAlign.center,
              //               txtHeight: 1.5),
              //           getVerSpace(20.h),
              //           getButtonFigma(context, getAccentColor(context), true,
              //               "View Parking Ticket", Colors.black, () {
              //                 Get.back();
              //                 Constant.sendToNext(
              //                     context, Routes.parkingTicketScreen);
              //               }, EdgeInsets.zero),
              //           getVerSpace(20.h),
              //           getButtonFigma(
              //             context,
              //             Colors.transparent,
              //             true,
              //             "Cancel",
              //             Colors.black,
              //                 () {
              //               Get.back();
              //             },
              //             EdgeInsets.zero,
              //             isBorder: true,
              //             borderColor: getFontColor(context),
              //           )
              //         ],
              //       ),
              //     )
              //   // content: getAssetImage(context, "check_img.png", 179.h, 155.h,
              //   //     boxFit: BoxFit.fill),
              // );
              // Constant.sendToNext(context, Routes.homeScreenRoute);
            }, edgeInsets),
            getVerSpace(25.h)
          ],
        ),
      ),
    );
  }

  Widget buildRowItem(BuildContext context, String title1, String title2) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 9.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: getCustomFont(title1, 16, getFontGreyColor(context), 1,
                fontWeight: FontWeight.w500),
            flex: 1,
          ),
          getCustomFont(title2, 16, getFontColor(context), 1,
              fontWeight: FontWeight.w500)
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
