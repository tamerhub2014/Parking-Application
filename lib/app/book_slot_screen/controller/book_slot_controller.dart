import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookASlotController extends GetxController{
  final DateRangePickerController startDateController =
  DateRangePickerController();
  RxString selectedDate = ''.obs;
  RxString dateCount = ''.obs;
  DateTime dateSelect = DateTime.now();
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    update();
    print("selectdatr===");
    if (args.value is PickerDateRange) {
      // ignore: unnecessary_statements
      '${DateFormat.yMd().format(args.value.startDate)} -'
      // ignore: lines_longer_than_80_chars
          ' ${DateFormat.yMd().format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate.value = args.value.toString();
      dateSelect = args.value;
      update();
    } else if (args.value is List<DateTime>) {
      dateCount.value = args.value.length.toString();
    } else {
      args.value.length.toString();
    }
    SchedulerBinding.instance.addPostFrameCallback((duration) {
      update();

      // DateFormat.yMd().format(args.value).toString();
    });
  }
}