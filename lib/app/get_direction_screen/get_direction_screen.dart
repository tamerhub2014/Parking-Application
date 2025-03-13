import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parking_ui_new/base/color_data.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../base/constant.dart';
import '../../base/resizer/fetch_pixels.dart';
import '../../base/widget_utils.dart';
import '../map_screen/map_screen.dart';

class GetDirectionScreen extends StatefulWidget {
  const GetDirectionScreen({Key? key}) : super(key: key);

  @override
  State<GetDirectionScreen> createState() => _GetDirectionScreenState();
}

class _GetDirectionScreenState extends State<GetDirectionScreen> {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    Constant.setupSize(context);
    FetchPixels.getDefaultHorSpaceFigma(context);
    CameraPosition? _kGooglePlex;
    _kGooglePlex = CameraPosition(
      target: LatLng(54.985934,-2.7372116),
      zoom: 14,
      bearing: 192.8334901395799,
      tilt: 59.440717697143555,
    );
    List<Polyline> _polyLine = [];

    _polyLine.add(Polyline(endCap: Cap.roundCap,
      polylineId: PolylineId("route1"),
      color: Colors.black,
      patterns: [
        PatternItem.dash(20.0),
        PatternItem.gap(10)
      ],

      width: 3,
      points: [
        LatLng(54.985934,-2.7372116),
        LatLng(54.9841444,-2.7437832),
      ],
    ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            getToolbarWidget(context, "Get Direction", () {
              Get.back();
            }),
            getVerSpace(20),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
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
                        position: LatLng(54.9841444,-2.7437832),
                      ),
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              getSvgImageWithSize(
                                  context, "location.svg", 56, 56),
                              getHorSpace(24),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont("29 Street Club Town Garden",
                                        17, getFontColor(context), 1),
                                    getVerSpace(6),
                                    getCustomFont("20m Right To Parking Spot",
                                        15, getFontGreyColor(context), 1),
                                  ],
                                ),
                              )
                            ],
                          ),
                          getVerSpace(20),
                          getButtonFigma(
                              context,
                              getAccentColor(context),
                              true,
                              "Start",
                              getFontColor(context),
                              () {
                                Get.to(()=>MapScreen());
                              },
                              EdgeInsets.zero,
                              buttonheight: 40,
                              buttonRedius: 20,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
