// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/image_constant.dart';

import '../constant/dio_client.dart';
import '../model/routing_map_model.dart';
import '../module/homepage/map.dart';

// ignore: must_be_immutable
class TomTomMapApiTesting extends StatefulWidget {
  double? sourceLat;
  double? sourceLong;
  double? destinationLat;
  double? destinationLong;

  TomTomMapApiTesting(
      {Key? key,
      this.sourceLat,
      this.sourceLong,
      this.destinationLat,
      this.destinationLong})
      : super(key: key);

  @override
  State<TomTomMapApiTesting> createState() => _TomTomMapApiTestingState();
}

class _TomTomMapApiTestingState extends State<TomTomMapApiTesting> {
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
        // return

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

    // LatLng startLocation = LatLng(26.7489716, 83.3588597);
    // LatLng endLocation = LatLng(27.6688312, 85.3077329);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                getDataServices();
              },
              child: const Text("press")),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Map1()),
              );
              log("click map");
            },
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
                  allowPanningOnScrollingParent: false,
                  allowPanning: false,
                  enableScrollWheel: false,
                  center: startLocation,
                  zoom: 14.0),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                      attributionBuilder: (_) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const Map1()),
                            // );
                          },
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

          // FlutterMap(
          //   options: MapOptions(center: startLocation, zoom: 13.0),
          //   layers: [
          //     TileLayerOptions(

          // urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
          //     "{z}/{x}/{y}.png?key={apiKey}",
          // additionalOptions: {"apiKey": apiKey},
          //     ),
          // MarkerLayerOptions(
          //   markers: [
          //     Marker(
          //       width: 80.0,
          //       height: 80.0,
          //       point: startLocation,
          //       builder: (BuildContext context) => const Icon(
          //           Icons.location_on,
          //           size: 60.0,
          //           color: Colors.black),
          //     ),
          //     Marker(
          //       width: 80.0,
          //       height: 80.0,
          //       point: endLocation,
          //       builder: (BuildContext context) => const Icon(
          //           Icons.location_on,
          //           size: 60.0,
          //           color: Colors.black),
          //     ),
          //   ],
          // ),
          //   ],
          // )
        ],
      ),
    );
  }

  _handle() {
    log("initial value oncreatedmap print");
  }

  _nav() {
    log("click");
  }
}
