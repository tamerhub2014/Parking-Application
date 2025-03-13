// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/app/home/tabs/tab_my_bookmark.dart';
import 'package:flutter_parking_ui_new/app/home/tabs/tab_home.dart';
import 'package:flutter_parking_ui_new/app/home/tabs/tab_my_booking.dart';
import 'package:flutter_parking_ui_new/app/home/tabs/tab_profile.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/constant.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/home_controller.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  List<String> imgList = ["home", "booking", "bookMark", "profile"];
  List<String> labelList = ["Home", "Booking", "Bookmark", "Profile"];

  List<Widget> tabList = [
    TabHome(),
    TabMyBooking(),
    // TabLocation(),
    TabMyBookMark(),
    TabProfile(),
    // Container(width: double.infinity, height: double.infinity,)
  ];

  finish() {
    Constant.closeApp();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.selectedVal == 0) {
              controller.update();
              finish();
            } else {
              setState(() {
                controller.update();

                controller.selectedVal = 0;
              });
            }
            return false;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: getCurrentTheme(context).scaffoldBackgroundColor,
              body: tabList[controller.selectedVal],
              // body: Stack(
              //   children: <Widget>[
              //     Align(
              //       alignment: FractionalOffset.center,
              //       //in this demo, only the button text is updated based on the bottom app bar clicks
              //       child: RaisedButton(
              //         child: Text(text),
              //         onPressed: () {},
              //       ),
              //     ),
              //     //this is the code for the widget container that comes from behind the floating action button (FAB)
              //     Align(
              //       alignment: FractionalOffset.bottomCenter,
              //       child: AnimatedContainer(
              //         duration: Duration(milliseconds: 250),
              //         //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
              //         height:
              //         clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
              //         width: clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
              //         decoration: BoxDecoration(
              //             borderRadius:
              //             BorderRadius.circular(clickedCentreFAB ? 0.0 : 300.0),
              //             color: Colors.blue),
              //       ),
              //     )
              //   ],
              // ),
              // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              // //specify the location of the FAB
              // floatingActionButton: InkWell(
              //   onTap: () {
              //     setState(() {
              //       selectedVal = 2;
              //     });
              //   },
              //   child: Container(
              //
              //     width: 54.h,
              //     height: 54.h,
              //     decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: getAccentColor(context),
              //     ),
              //     child: Center(
              //        child: getSvgImageWithSize(context, "location.svg", 24.h, 24.h),
              //     ),
              //   ),
              // ),
              bottomNavigationBar: Container(
                height: (Platform.isIOS) ? 120.h : 83.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 16,
                      offset: Offset(0, -4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: controller.selectedVal,
                  onTap: (value) {
                    controller.selectedVal = value;
                    controller.update();
                  },
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  unselectedLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                  ),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  selectedLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                  ),
                  items: List.generate(imgList.length, (index) {
                    return BottomNavigationBarItem(
                      backgroundColor: Colors.white,
                      icon: GestureDetector(
                        onTap: () {
                          controller.selectedVal = index;
                          controller.update();
                        },
                        child: getSvgImageWithSize(
                            context,
                            "${(controller.selectedVal == index) ? "${imgList[index]}_selected" : imgList[index]}.svg",
                            73.h,
                            40.h),
                      ),
                      label: labelList[index],
                    );
                  }),
                  backgroundColor: Colors.white,
                ),
              )
              // BottomAppBar(
              //   notchMargin: 10.h,
              //   elevation: 7.h,
              //   child: Container(
              //     color: Colors.transparent,
              //     height: 100.h,
              //     // margin: EdgeInsets.only(left: 12.0, right: 12.0),
              //     child: Row(
              //         mainAxisSize: MainAxisSize.max,
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: List.generate(imgList.length, (index) {
              //           return Expanded(
              //             child: (imgList[index].isEmpty)
              //                 ? SizedBox(
              //               width: 0,
              //             )
              //                 : Center(
              //               child: InkWell(
              //                 onTap: () {
              //                   setState(() {
              //                     selectedVal = index;
              //                   });
              //                 },
              //                 child: getSvgImageWithSize(
              //                     context,
              //                     "${(selectedVal == index)
              //                         ? "${imgList[index]}_selected"
              //                         : imgList[index]}.svg",
              //                     24.h,
              //                     24.h),
              //               ),
              //             ),
              //             flex: 1,
              //           );
              //         })
              //       // <Widget>[
              //       //   IconButton(
              //       //     //update the bottom app bar view each time an item is clicked
              //       //     onPressed: () {
              //       //       updateTabSelection(0, "Home");
              //       //     },
              //       //     iconSize: 27.0,
              //       //     icon: Icon(
              //       //       Icons.home,
              //       //       //darken the icon if it is selected or else give it a different color
              //       //       color: selectedIndex == 0
              //       //           ? Colors.blue.shade900
              //       //           : Colors.grey.shade400,
              //       //     ),
              //       //   ),
              //       //   IconButton(
              //       //     onPressed: () {
              //       //       updateTabSelection(1, "Outgoing");
              //       //     },
              //       //     iconSize: 27.0,
              //       //     icon: Icon(
              //       //       Icons.call_made,
              //       //       color: selectedIndex == 1
              //       //           ? Colors.blue.shade900
              //       //           : Colors.grey.shade400,
              //       //     ),
              //       //   ),
              //       //   //to leave space in between the bottom app bar items and below the FAB
              //       //   SizedBox(
              //       //     width: 50.0,
              //       //   ),
              //       //   IconButton(
              //       //     onPressed: () {
              //       //       updateTabSelection(2, "Incoming");
              //       //     },
              //       //     iconSize: 27.0,
              //       //     icon: Icon(
              //       //       Icons.call_received,
              //       //       color: selectedIndex == 2
              //       //           ? Colors.blue.shade900
              //       //           : Colors.grey.shade400,
              //       //     ),
              //       //   ),
              //       //   IconButton(
              //       //     onPressed: () {
              //       //       updateTabSelection(3, "Settings");
              //       //     },
              //       //     iconSize: 27.0,
              //       //     icon: Icon(
              //       //       Icons.settings,
              //       //       color: selectedIndex == 3
              //       //           ? Colors.blue.shade900
              //       //           : Colors.grey.shade400,
              //       //     ),
              //       //   ),
              //
              //     ),
              //   ),
              //   //to add a space between the FAB and BottomAppBar
              //   shape: CircularNotchedRectangle(),
              //   //color of the BottomAppBar
              //   color: getCurrentTheme(context).scaffoldBackgroundColor,
              // ),
              ),
        );
      },
    );
  }
}
