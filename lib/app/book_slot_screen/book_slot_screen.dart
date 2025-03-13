import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_model.dart';
import 'package:flutter_parking_ui_new/app/home/data/models/parking_ticket_body.dart';
import 'package:flutter_parking_ui_new/app/login/cubit/profile_cubit.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../routes/app_routes.dart';
import 'controller/book_slot_controller.dart';

class BookASlotScreen extends StatefulWidget {
  final ParkingModel parking;
  const BookASlotScreen({Key? key, required this.parking}) : super(key: key);

  @override
  State<BookASlotScreen> createState() => _BookASlotScreenState();
}

class _BookASlotScreenState extends State<BookASlotScreen> {
  finish() {
    Constant.backToPrev(context);
  }

  DateTime arriveTime = DateTime.now();

  DateTime exitTime = DateTime.now().add(const Duration(hours: 1));

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
            getToolbarWidget(context, "Book A Slot", finish),
            getVerSpace(32),
            Expanded(
              child: getPaddingWidget(
                edgeInsets,
                GetBuilder<BookASlotController>(
                  init: BookASlotController(),
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFF9F9F9),
                          ),
                          child: SfDateRangePicker(
                              backgroundColor: Colors.transparent,
                              view: DateRangePickerView.month,
                              // headerHeight: 30.h,
                              viewSpacing: 90,
                              onSelectionChanged: controller.selectionChanged,
                              controller: controller.startDateController,
                              allowViewNavigation: true,
                              showNavigationArrow: true,
                              selectionTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w500,
                              ),
                              initialSelectedDate: DateTime.now(),
                              selectionColor: getFontColor(context),
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              navigationDirection:
                                  DateRangePickerNavigationDirection.horizontal,
                              todayHighlightColor: getFontColor(context),
                              // toggleDaySelection: true,
                              monthViewSettings:
                                  const DateRangePickerMonthViewSettings(
                                dayFormat: 'E',
                              ),
                              headerStyle: DateRangePickerHeaderStyle(
                                  backgroundColor: Colors.transparent,
                                  textStyle: TextStyle(
                                    color: getFontColor(context),
                                    fontSize: 18,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                  )),
                              monthCellStyle: DateRangePickerMonthCellStyle(
                                  textStyle: TextStyle(
                                    color: getFontColor(context),
                                    fontSize: 14,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                  todayTextStyle: TextStyle(
                                    color: getFontColor(context),
                                    fontSize: 15,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                  ))),
                        ),
                        getVerSpace(33),
                        Text(
                          'Select Time',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        getVerSpace(16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Arrive Time',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  getVerSpace(7),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Select Time'),
                                            content: Container(
                                              height: 200,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initialDateTime: DateTime.now(),
                                                onDateTimeChanged: (value) {
                                                  setState(() {
                                                    arriveTime = DateTime(
                                                      controller
                                                          .dateSelect.year,
                                                      controller
                                                          .dateSelect.month,
                                                      controller.dateSelect.day,
                                                      value.hour,
                                                      value.minute,
                                                    );
                                                  });
                                                },
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF9F9F9),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DateFormat('hh:mm a')
                                                  .format(arriveTime),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF7D7D7D),
                                                fontSize: 15,
                                                fontFamily: 'SF Pro Display',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          getAssetImage(
                                              context, "time.png", 16, 16),
                                          getHorSpace(20)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            getHorSpace(20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Exit Time',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  getVerSpace(7),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Select Time'),
                                            content: Container(
                                              height: 200,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                initialDateTime: DateTime.now(),
                                                onDateTimeChanged: (value) {
                                                  setState(() {
                                                    exitTime = DateTime(
                                                      controller
                                                          .dateSelect.year,
                                                      controller
                                                          .dateSelect.month,
                                                      controller.dateSelect.day,
                                                      value.hour,
                                                      value.minute,
                                                    );
                                                  });
                                                },
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFFF9F9F9),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DateFormat('hh:mm a')
                                                  .format(exitTime),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF7D7D7D),
                                                fontSize: 15,
                                                fontFamily: 'SF Pro Display',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          getAssetImage(
                                              context, "time.png", 16, 16),
                                          getHorSpace(20)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            getPaddingWidget(
              edgeInsets,
              getButtonFigma(context, getAccentColor(context), true, "Continue",
                  Colors.black, () {
                Constant.sendToNext(
                  context,
                  Routes.chooseParkingSlotScreen,
                  arguments: ParkingTicketBody(
                    userId: ProfileCubit.instance.user?.id ?? "",
                    parking: widget.parking,
                    from: arriveTime,
                    to: exitTime,
                  ),
                );
              }, EdgeInsets.zero),
            ),
            getVerSpace(32)
          ],
        ),
      ),
    );
  }
}
