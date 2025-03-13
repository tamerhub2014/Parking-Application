import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/base/toast/error_toast.dart';
import 'package:flutter_parking_ui_new/base/toast/success_toast.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../data/data_file.dart';
import '../home/data/models/payment_card_model.dart';
import '../model/model_payment_list.dart';
import '../model/model_slot_detail.dart';
import '../payment_details_screen/payment_details_screen.dart';
import 'data/repos/payment_cards_repo.dart';

class ChoosePaymentMethodScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseParkingSlotScreen();
  }
}

class _ChooseParkingSlotScreen extends State<ChoosePaymentMethodScreen> {
  late Future<List<PaymentCardModel>> _paymentCardsFuture;

  @override
  void initState() {
    super.initState();

    _paymentCardsFuture = PaymentCardsRepo.getPaymentCards();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    setState(() {
      _paymentCardsFuture = PaymentCardsRepo.getPaymentCards();
    });
  }

  finish() {
    Constant.backToFinish(context);
  }

  List<ModelPaymentList> allPaymentList = DataFile.PaymentList();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getToolbarWidget(context, "Payment", () {
                  Get.back();
                }),
                getVerSpace(32),
                Expanded(
                    child: ListView(
                      children: [
                        FutureBuilder<List<PaymentCardModel>>(
                            future: _paymentCardsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
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
                                  return Container(
                                    padding: edgeInsets,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: horSpace, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        // border: Border.all(
                                        //     color: selectedVal == index
                                        //         ? getAccentColor(context)
                                        //         : Colors.transparent,
                                        //     width: 1),
                                        borderRadius:
                                            BorderRadius.circular(12.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0x0F000000),
                                            blurRadius: 23,
                                            offset: Offset(0, 4),
                                            spreadRadius: 0,
                                          )
                                        ]),
                                    width: double.infinity,
                                    height: 64.h,
                                    child: Row(
                                      children: [
                                        getHorSpace(24.w),
                                        Expanded(
                                          child: getCustomFont(
                                            items[index].cardNumber.length == 16
                                                ? "${items[index].cardNumber.substring(0, 4)}*****${items[index].cardNumber.substring(12)}" +
                                                    "      EXP ${items[index].expiryDate}"
                                                : items[index].cardNumber +
                                                    "       EXP${items[index].expiryDate}",
                                            17,
                                            getFontColor(context),
                                            1,
                                            textAlign: TextAlign.start,
                                          ),
                                          flex: 3,
                                        ),
                                        Spacer(flex: 1),
                                        IconButton(
                                          onPressed: () async {
                                            if (items.length > 1) {
                                              final result =
                                                  await PaymentCardsRepo
                                                      .deletePaymentCard(
                                                          items[index].id);

                                              if (result) {
                                                showSuccessToast(
                                                    "Payment Method Deleted successfully");

                                                setState(() {
                                                  _paymentCardsFuture =
                                                      PaymentCardsRepo
                                                          .getPaymentCards();
                                                });
                                              } else {
                                                showErrorToast(
                                                    "Something went wrong while deleting payment method");
                                              }
                                            } else {
                                              showErrorToast(
                                                  "Cannot delete last payment method");
                                            }
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 24.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: items.length,
                                primary: false,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                              );

                              ///
                            }),
                        // ListView.builder(
                        //   padding: EdgeInsets.zero,
                        //   itemBuilder: (context, index) {
                        //     ModelPaymentList paymentModel =
                        //         allPaymentList[index];
                        //     return Container(
                        //       padding: edgeInsets,
                        //       margin: EdgeInsets.symmetric(
                        //           horizontal: horSpace, vertical: 10.h),
                        //       decoration: BoxDecoration(
                        //           color: Colors.white,
                        //           // border: Border.all(
                        //           //     color: selectedVal == index
                        //           //         ? getAccentColor(context)
                        //           //         : Colors.transparent,
                        //           //     width: 1),
                        //           borderRadius: BorderRadius.circular(12.h),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Color(0x0F000000),
                        //               blurRadius: 23,
                        //               offset: Offset(0, 4),
                        //               spreadRadius: 0,
                        //             )
                        //           ]),
                        //       width: double.infinity,
                        //       height: 64.h,
                        //       child: Row(
                        //         children: [
                        //           getSvgImageWithSize(
                        //               context, paymentModel.image, 24.h, 24.h,
                        //               fit: BoxFit.fill),
                        //           getHorSpace(30.w),
                        //           Expanded(
                        //             child: getCustomFont(paymentModel.title, 17,
                        //                 getFontColor(context), 1,
                        //                 textAlign: TextAlign.start),
                        //             flex: 1,
                        //           ),
                        //           // (selectedVal == index)
                        //           //     ? getSvgImageWithSize(context, "Radio_selected.svg", 24, 24)
                        //           //     : getAssetImage(context, "unselect_radio_primary_.png", 24, 24),
                        //           // Icon(
                        //           //         Icons.radio_button_checked_rounded,
                        //           //         color: getFontColor(context),
                        //           //         size: 24.h,
                        //           //       )
                        //           //     : Icon(
                        //           //         Icons.radio_button_off_rounded,
                        //           //         color: greyIconColor,
                        //           //         size: 24.h,
                        //           //       )
                        //         ],
                        //       ),
                        //     );
                        //   },
                        //   itemCount: allPaymentList.length,
                        //   primary: false,
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        // ),
                        getVerSpace(32.h),
                        getButtonFigma(
                            isIcon: true,
                            textSize: 16,
                            icons: "add.svg",
                            context,
                            Color(0xFFFFF8E5),
                            borderColor: getAccentColor(context),
                            true,
                            isBorder: true,
                            "Add New Card",
                            Colors.black, () {
                          Get.to(() => PaymentDetailsScreen());

                          // Get.back();
                          // Constant.sendToNext(context, Routes.selectVehicleScreen);
                        }, edgeInsets),
                        // getCustomFont("Add New +", 16, getFontColor(context), 1,
                        //     textAlign: TextAlign.center,
                        //     fontWeight: FontWeight.w500)
                      ],
                    ),
                    flex: 1),
                // getButtonFigma(context, getAccentColor(context), true, "Continue",
                //     Colors.black, () {
                //   Constant.sendToNext(context, Routes.paymentCardScreen);
                // }, EdgeInsets.symmetric(horizontal: horSpace, vertical: 30.h))
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }

  Widget getInfoItem(int type) {
    String title = (type == DataFile.slotUnAvailable)
        ? "Unavailable"
        : (type == DataFile.slotAvailable)
            ? "Available"
            : "Selected";
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          width: 24.h,
          height: 24.h,
          decoration: buildSlotBoxDecoration(type, true,
              radius1: BorderRadius.circular(4.h)),
        ),
        getHorSpace(10.w),
        getCustomFont(title, 14, getFontColor(context), 1,
            fontWeight: FontWeight.w500, textAlign: TextAlign.start)
      ],
    );
  }

  Stack buildSlotItem(bool isLast, ModelSlotDetail slotDetail, bool isFirst) {
    LinePosition linePosition =
        (isFirst) ? LinePosition.left : LinePosition.right;
    return Stack(
      children: [
        Container(
          decoration: DottedDecoration(
            color: Colors.black,
            strokeWidth: 0.5,
            linePosition: linePosition,
          ),
        ),
        Container(
          decoration: DottedDecoration(
            color: Colors.black,
            strokeWidth: 0.5,
            linePosition: LinePosition.top,
          ),
        ),
        (isLast)
            ? Container(
                decoration: DottedDecoration(
                  color: Colors.black,
                  strokeWidth: 0.5,
                  linePosition: LinePosition.bottom,
                ),
              )
            : getVerSpace(0),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: buildSlotBoxDecoration(slotDetail.availability, isFirst),
          margin: EdgeInsets.only(
              left: (isFirst) ? 12.w : 0,
              right: (!isFirst) ? 12.w : 0,
              top: 7.h,
              bottom: 7.h),
          child: Align(
            alignment: (isFirst) ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
                width: 42.w,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: darkGreyColor,
                  borderRadius: BorderRadius.horizontal(
                      right: (isFirst) ? Radius.circular(10.h) : Radius.zero,
                      left: (!isFirst) ? Radius.circular(10.h) : Radius.zero),
                ),
                child: Center(
                  child: getCustomFont(
                    slotDetail.title,
                    14,
                    Colors.white,
                    1,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
        )
      ],
    );
  }

  BoxDecoration buildSlotBoxDecoration(int type, bool isFirstList,
      {BorderRadius? radius1}) {
    BorderRadius? radius = radius1;
    Radius radiusSet = Radius.circular(10.h);

    if (radius == null) {
      radius = BorderRadius.horizontal(
          left: (!isFirstList) ? radiusSet : Radius.zero,
          right: (isFirstList) ? radiusSet : Radius.zero);
    }
    Color getColors = unAvailableColor;
    bool isBorder = false;
    switch (type) {
      case DataFile.slotUnAvailable:
        getColors = unAvailableColor;
        break;
      case DataFile.slotAvailable:
        getColors = Colors.transparent;
        isBorder = true;
        break;
      case DataFile.slotSelected:
        getColors = slotSelectedColor;
        break;
    }
    return BoxDecoration(
        color: getColors,
        border:
            (isBorder) ? Border.all(color: darkGreyColor, width: 1.h) : null,
        borderRadius: radius);
  }
}
