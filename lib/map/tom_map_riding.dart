// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/image_constant.dart';

import '../constant/color_constant.dart';
import '../constant/dio_client.dart';
import '../model/routing_map_model.dart';

// ignore: must_be_immutable
class TomTomMapRiding extends StatefulWidget {
  double? sourceLat, sourceLong;
  double? destinationLat, destinationLong;

  TomTomMapRiding(
      {Key? key,
      this.sourceLat,
      this.sourceLong,
      this.destinationLat,
      this.destinationLong})
      : super(key: key);

  @override
  State<TomTomMapRiding> createState() => _TomTomMapRidingState();
}

class _TomTomMapRidingState extends State<TomTomMapRiding> {
  LocationData? _currentPosition;

  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
  RoutingMapModel? routenav;

  LatLng? startLocation;
  LatLng? endLocation;
  // //  Marker markers = [];
  // LatLng startLocation = LatLng(26.7489716, 83.3588597);
  // LatLng endLocation = LatLng(27.6688312, 85.3077329);
  bool isProgressRunning = false;

  _mapScreenState() {
    LatLng startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
    LatLng endLocation =
        LatLng(widget.destinationLat!, widget.destinationLong!);
  }

  @override
  void initState() {
    super.initState();
    getDataServices();
    _mapScreenState();
    LatLng startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
    LatLng endLocation =
        LatLng(widget.destinationLat!, widget.destinationLong!);
  }

  Future<dynamic> getDataServices(
      {LatLng? sourceLatitude, LatLng? sourceLongtitude}) async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      var response = await dio.get(
        'https://api.tomtom.com/routing/1/calculateRoute/${sourceLatitude ?? widget.sourceLat},${sourceLongtitude ?? widget.sourceLong}:${widget.destinationLat},${widget.destinationLong}/json?key=$apiKey',
      );

      if (response.statusCode == 200) {
        log("${response.data}");
        setState(() {
          routenav = RoutingMapModel.fromJson(response.data);
        });
      } else {
        log("Response data rather than 200");
      }
    } catch (e) {
      log("$e");
      // log("Api call exception");

    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
    LatLng endLocation =
        LatLng(widget.destinationLat!, widget.destinationLong!);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: FlutterMap(
              // layers: [
              //   TappablePolylineLayerOptions(
              //       // Will only render visible polylines, increasing performance
              //       polylineCulling: true,
              //       polylines: [
              //         TaggedPolyline(
              //             tag: "My Polyline",
              //             points: routenav?.routes?[0].legs?[0].points
              //                 ?.map((e) => LatLng(e.latitude!, e.longitude!))
              //                 .toList()

              //             //getPoints(0), // An optional tag to distinguish polylines in callback
              //             // ...all other Polyline options
              //             ),
              //       ],
              //       onTap: (polylines, tapPosition) => print('Tapped: ' +
              //           polylines.map((polyline) => polyline.tag).join(',') +
              //           ' at ' +
              //           tapPosition.globalPosition.toString()),
              //       onMiss: (tapPosition) {
              //         print('No polyline was tapped at position ' +
              //             tapPosition.globalPosition.toString());
              //       })
              // ],
              options: MapOptions(
                  onMapCreated: _handle(),
                  onTap: _nav(),
                  debugMultiFingerGestureWinner: true,
                  enableMultiFingerGestureRace: true,
                  allowPanningOnScrollingParent: true,
                  allowPanning: false,
                  enableScrollWheel: true,
                  center: startLocation,
                  zoom: 14.0),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                      attributionBuilder: (_) {
                        return InkWell(
                          onTap: () {},
                        );
                      },
                      urlTemplate:
                          "https://api.tomtom.com/map/1/tile/basic/main/"
                          "{z}/{x}/{y}.png?key={apiKey}",
                      additionalOptions: {"apiKey": apiKey}),
                  // urlTemplate:
                  //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  //  subdomains: ['a', 'b', 'c']),
                  //  tileProvider: const CachedTileProvider()),
                ),
                MarkerLayerWidget(
                  options: MarkerLayerOptions(rotate: false, markers: [
                    Marker(
                      height: MediaQuery.of(context).size.height * 0.2,
                      point: startLocation,
                      builder: (ctx) => Image.asset(
                        ImgConstants.MARKER_MAP,
                      ),
                    ),
                    Marker(
                      height: MediaQuery.of(context).size.height * 0.2,
                      point: endLocation,
                      builder: (ctx) => Image.asset(
                        ImgConstants.MARKER_MAP_DESTINATION2,
                      ),
                    ),
                  ]),
                ),
                isProgressRunning
                    ? const SizedBox()
                    : PolylineLayerWidget(
                        options: PolylineLayerOptions(
                          polylines: List.generate(
                            10,
                            (index) => Polyline(
                              isDotted: false,

                              points: routenav!.routes![0].legs![0].points!
                                  .map((e) => LatLng(e.latitude!, e.longitude!))
                                  .toList(),

                              // startLocation,
                              // endLocation
                              // LatLng(27.6683619, 85.3101895),
                              // LatLng(28.6688312, 86.3077329)
                              // ],
                              strokeWidth: 4.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          bottomDetailsSheet(),
        ],
      ),
    );
  }

  // BottomSheet For Car Available

  Widget bottomDetailsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: .5,
      minChildSize: .5,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: ColorConstant.COLOR_WHITE,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 2,
                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 25),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(ImgConstants.CAR_ICON,
                                        width: 50, height: 50),
                                  ],
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "My Audi",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: ColorConstant.COLOR_TEXT,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "5:08 pm",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            color: ColorConstant
                                                .COLOR_ORIGINAL_GREY,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.discount,
                                          size: 15,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Rs. 89.50",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                color:
                                                    ColorConstant.COLOR_TEXT,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Rs. 99.50",
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.copyWith(
                                            color: ColorConstant
                                                .COLOR_ORIGINAL_GREY,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  _handle() {
    log("initial value oncreatedmap");
  }

  _nav() {
    log("click");
  }
}
