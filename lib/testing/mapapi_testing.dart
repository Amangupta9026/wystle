// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../module/homepage/map.dart';

// ignore: must_be_immutable
class TomTomMapApiTesting extends StatelessWidget {
  LocationData? _currentPosition;
  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
  //"PQ5tTEag90xOPau3hA1KGp8NN6ArkBDA";

  TomTomMapApiTesting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final starttomtomHQ = LatLng(26.7489993, 83.3588346);
    // final starttomtomHQ = LatLng(26.7489993, 83.3588346);
    LatLng startLocation = LatLng(26.7489716, 83.3588597);
    LatLng endLocation = LatLng(27.6688312, 85.3077329);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Map1()),
              );
              log("click map");
            },
            child: FlutterMap(
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

              // options: MapOptions(
              //   center: LatLng(0, 0),
              //   zoom: 18.0,
              // ),
              children: [
                TileLayerWidget(
                  options: TileLayerOptions(
                      attributionBuilder: (_) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Map1()),
                            );
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
                  options: MarkerLayerOptions(
                    rotate: false,
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: startLocation,
                        builder: (ctx) => Container(
                          child: const Icon(Icons.location_on,
                              size: 25.0, color: Colors.red),
                        ),
                      ),
                      // Marker(
                      //   width: 80.0,
                      //   height: 80.0,
                      //   point: endLocation,
                      //   builder: (ctx) => Container(
                      //     child: Icon(Icons.location_on),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // PolylineLayerWidget(
                //   options: PolylineLayerOptions(
                //     polylines: List.generate(
                //       10,
                //       (index) => Polyline(
                //         isDotted: true,
                //         points: [
                //           LatLng(27.6683619, 85.3101895),
                //           LatLng(28.6688312, 86.3077329)
                //         ],
                //         strokeWidth: 10.0,
                //         color: Colors.blue,
                //       ),
                //     ),
                //   ),
                // ),
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
