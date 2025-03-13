import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parking_ui_new/app/payment/data/repos/payment_cards_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/color_data.dart';
import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../home/data/models/payment_card_body.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardHolderNumberController = TextEditingController();
  TextEditingController cardExpDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    double horSpace = FetchPixels.getDefaultHorSpaceFigma(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: horSpace);

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getToolbarWidget(context, "Add New Card", () {
                Get.back();
              }),
              getVerSpace(32),
              Expanded(
                child: getPaddingWidget(
                  edgeInsets,
                  ListView(
                    children: [
                      getDefaultTextFiled(context,
                          textInputAction: TextInputAction.next,
                          textEditingController: cardHolderController,
                          s: "Card Holder Name", validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter card holder name";
                        }
                        return null;
                      }, fontColor: getFontColor(context)),
                      getVerSpace(20),
                      getDefaultTextFiled(context,
                          textInputAction: TextInputAction.next,
                          textEditingController: cardHolderNumberController,
                          s: "Card Number",
                          keyboardType: TextInputType.number,
                          inputFormatter: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                          ], validator: (value) {
                        if (value!.isEmpty || value.length < 16) {
                          return "Please enter card number";
                        }
                        return null;
                      }, fontColor: getFontColor(context)),
                      getVerSpace(20),
                      Row(
                        children: [
                          Expanded(
                            child: getDefaultTextFiled(context,
                                withSufix: true,
                                textInputAction: TextInputAction.next,
                                sufixImage: "calendar2.svg",
                                validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter card expiry date";
                              }
                              return null;
                            },
                                textEditingController: cardExpDateController,
                                s: "Exp Date",
                                keyboardType: TextInputType.number,
                                suffixConstraints:
                                    BoxConstraints(maxHeight: 56.h),
                                iconColor: cardExpDateController.text.isNotEmpty
                                    ? getFontColor(context)
                                    : getFontGreyColor(context),
                                inputFormatter: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(04),
                                  CardMonthInputFormatter(),
                                ],
                                fontColor: getFontColor(context)),
                          ),
                          getHorSpace(20),
                          Expanded(
                            child:
                                getDefaultTextFiled(context, inputFormatter: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ], validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter card cvv number";
                              }
                              return null;
                            },
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                    textEditingController: cardCvvController,
                                    s: "CVV",
                                    fontColor: getFontColor(context)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              getButtonFigma(context, getAccentColor(context), true, "Continue",
                  getFontColor(context), () {
                if (formKey.currentState!.validate()) {
                  PaymentCardsRepo.addPaymentCard(PaymentCardBody(
                    cardHolderName: cardHolderController.text,
                    cardNumber: cardHolderNumberController.text,
                    expiryDate: cardExpDateController.text,
                  ));

                  Get.back();
                }
              }, edgeInsets),
              getVerSpace(32),
            ],
          ),
        ),
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
