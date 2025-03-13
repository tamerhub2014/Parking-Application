import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:flutter_parking_ui_new/base/widget_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    FetchPixels.getDefaultHorSpaceFigma(context);
    CameraPosition? _kGooglePlex;
    _kGooglePlex = CameraPosition(
      target: LatLng(54.985934, -2.7372116),
      zoom: 14,
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
    );
    List<Polyline> _polyLine = [];

    _polyLine.add(Polyline(
      endCap: Cap.roundCap,
      polylineId: PolylineId("route1"),
      color: Colors.black,
      patterns: [PatternItem.dash(20.0), PatternItem.gap(10)],
      width: 3,
      points: [
        LatLng(54.985934, -2.7372116),
        LatLng(54.9841444, -2.7437832),
      ],
    ));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              polylines: _polyLine.toSet(),
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                // mapController.complete(controller);
              },
              zoomControlsEnabled: true,
              markers: {
                Marker(
                  markerId: MarkerId("marker2"),
                  position: LatLng(54.9841444, -2.7437832),
                ),
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: getAccentColor(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 16, top: 12, bottom: 12),
                  child: Row(
                    children: [
                      getAssetImage(context, "daireaction.png", 40, 40),
                      getHorSpace(12),
                      Expanded(
                          child: getCustomFont("To Tran tow Courts Street...",
                              17, getFontColor(context), 1)),
                      getCustomFont(
                          "800m",
                          20,
                          getFontColor(context),
                          fontWeight: FontWeight.w700,
                          1),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 56.h,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: getSvgImageWithSize(
                          context, "location_fill.svg", 24, 24))),
              getHorSpace(24),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  getCustomFont(
                      "29 Street Club Town Garden", 17, Colors.white, 1),
                  getVerSpace(6),
                  getCustomFont(
                      "20m Right To Parking Spot", 15, Colors.white, 1),
                ],
              )),
              GestureDetector(onTap: () {
                Get.back();
              },
                  child: getAssetImage(context, "primery_close.png", 40, 40))
            ],
          ),
        ),
      ),
    );
  }
}
