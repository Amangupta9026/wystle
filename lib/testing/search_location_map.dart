// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';

import '../module/homepage/map.dart';

// ignore: must_be_immutable
class SearchLocationMap extends StatefulWidget {
  SearchLocationMap({Key? key}) : super(key: key);

  @override
  State<SearchLocationMap> createState() => _SearchLocationMapState();
}

class _SearchLocationMapState extends State<SearchLocationMap> {
  LocationData? _currentPosition;

  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";

  //"PQ5tTEag90xOPau3hA1KGp8NN6ArkBDA";
  LatLng startLocation = LatLng(26.748933, 83.3588367);

  LatLng endLocation = LatLng(26.999933, 84.2077329);

  //
  List<String> animalNames = ['Elephant', 'Tiger', 'Kangaroo'];

  List<String> animalFamily = ['Elephantidae', 'Panthera', 'Macropodidae'];

  List<String> animalLifeSpan = ['60-70', '8-10', '15-20'];

  List<String> animalWeight = ['2700-6000', '90-310', '47-66'];

  int selectedTile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: FlutterMap(
              options: MapOptions(
                  // onMapCreated: _handle(),
                  // onTap: _nav(),
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
                  options: MarkerLayerOptions(
                    rotate: false,
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: startLocation,
                        builder: (ctx) => Container(
                          child: const Icon(Icons.location_on,
                              size: 40.0, color: Colors.blue),
                        ),
                      ),
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: endLocation,
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_on),
                        ),
                      ),
                    ],
                  ),
                ),
                PolylineLayerWidget(
                  options: PolylineLayerOptions(
                    //  polylineCulling: true,
                    polylines: List.generate(
                      10,
                      (index) => Polyline(
                        //   isDotted: true,
                        points: [
                          startLocation,
                          endLocation
                          // LatLng(26.7489332, 83.3588367),
                          // LatLng(26.999933, 84.2077329)
                        ],
                        strokeWidth: 10.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //
          // animalsList(),
          bottomDetailsSheet(),
        ],
      ),
    );
  }

  Widget bottomDetailsSheet() {
    return DraggableScrollableSheet(
      initialChildSize: .5,
      minChildSize: .5,
      maxChildSize: 1,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: ColorConstant.COLOR_WHITE,
          child: ListView.builder(
              itemCount: 10,
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, bottom: 25),
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
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
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
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
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
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLACK,
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
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough,
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
        );
      },
    );
  }

  Widget animalsList() {
    return ListView(
      children: [
        animalListTile(0, animalNames[0]),
        animalListTile(1, animalNames[1]),
        animalListTile(2, animalNames[2]),
      ],
    );
  }

  Widget animalListTile(int index, String animalName) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedTile = index;
          });
        },
        title: Text(
          animalName,
          style: TextStyle(
            color: Colors.brown,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        tileColor: Colors.lightGreen[300],
        selected: index == selectedTile,
        selectedTileColor: Colors.lightGreen[600],
      ),
    );
  }
}
