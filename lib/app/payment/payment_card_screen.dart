import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_parking_ui_new/app/payment/data/repos/payment_cards_repo.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/resizer/fetch_pixels.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../data/data_file.dart';
import '../home/data/models/payment_card_model.dart';
import '../model/model_payment_list.dart';
import '../model/model_slot_detail.dart';
import '../payment_details_screen/payment_details_screen.dart';
import '../transaction_detail_screen/transaction_detail_screen.dart';

class PaymentCardScreen extends StatefulWidget {
  final ParkingTicketBody parkingTicketBody;

  const PaymentCardScreen({Key? key, required this.parkingTicketBody})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PaymentCardScreen();
  }
}

class _PaymentCardScreen extends State<PaymentCardScreen> {
  finish() {
    Constant.backToFinish(context);
  }

  List<ModelPaymentList> allPaymentList = DataFile.getAllPayment();
  int selectedIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  late Future<List<PaymentCardModel>> _paymentCardsFuture;

  @override
  void initState() {
    super.initState();

    _paymentCardsFuture = PaymentCardsRepo.getPaymentCards();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _paymentCardsFuture = PaymentCardsRepo.getPaymentCards();
      });
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getToolbarWidget(context, "Payment Method", () {
              Get.back();
            }),
            getVerSpace(32),
            Expanded(
                child: getPaddingWidget(
                  edgeInsets,
                  ListView(
                    children: [
                      getCustomFont(
                          "Choose Payment", 16, getFontColor(context), 1,
                          fontWeight: FontWeight.w600),
                      getVerSpace(28),
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
                      getVerSpace(32),
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
                      }, EdgeInsets.zero),
                      getVerSpace(20),
                    ],
                  ),
                ),
                flex: 1),
            FutureBuilder<int>(
                future: PaymentCardsRepo.numOfPaymentMethods(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data! > 0) {
                    return getButtonFigma(context, getAccentColor(context),
                        true, "Continue", Colors.black, () {
                      // Get.back();
                      Get.to(() => TransactionDetailScreen(
                          parkingTicketBody: widget.parkingTicketBody));
                      // Constant.sendToNext(context, Routes.changePassRoute);
                    }, edgeInsets);
                  } else {
                    return SizedBox.shrink();
                  }
                }),
            getVerSpace(32),
          ],
        ),
      ),
    );
  }

  Widget buildTextFields(
      BuildContext context, TextEditingController controller, String hint,
      {List<TextInputFormatter>? formatter, int? maxSize}) {
    return TextFormField(
      inputFormatters: formatter,
      // validator: CardUtils.validateDate,

      controller: controller,
      style:
          buildTextStyle(context, getFontColor(context), FontWeight.w500, 16),
      maxLength: maxSize,
      decoration: InputDecoration(
          counterText: "",
          isDense: true,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: getAccentColor(context))),
          // enabledBorder: UnderlineInputBorder(
          //     borderSide: BorderSide(color: getAccentColor(context))),
          border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: getCurrentTheme(context).focusColor)),
          hintText: hint,
          hintStyle: buildTextStyle(
              context, getFontHint(context), FontWeight.w500, 16)),
    );
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
