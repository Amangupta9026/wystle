// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../constant/color_constant.dart';
import '../constant/map_api_key.dart';
import '../model/price_estimation_model.dart';
import '../model/routing_map_model.dart';
import '../payment_options/payment_options.dart';

// ignore: must_be_immutable
class TomTomMapRiding extends StatefulWidget {
  double? sourceLat, sourceLong;
  double? destinationLat, destinationLong;
  PriceEstimationModel? priceEstimateModel;
  final dynamic image1;
  RoutingMapModel? routenav;
  final String? sourceAddress, destinationAddress;

  TomTomMapRiding(
      {Key? key,
      this.sourceLat,
      this.sourceLong,
      this.destinationLat,
      this.destinationLong,
      this.priceEstimateModel,
      this.image1,
      this.routenav,
      this.sourceAddress,
      this.destinationAddress})
      : super(key: key);

  @override
  State<TomTomMapRiding> createState() => _TomTomMapRidingState();
}

class _TomTomMapRidingState extends State<TomTomMapRiding> {
  LocationData? _currentPosition;

  final String apiKey = tomTomMapKey;
  // RoutingMapModel? routenav;
  MapController? controller = MapController();

  late LatLng startLocation;
  late LatLng endLocation;

  bool isProgressRunning = false;
  Location location = Location();
  bool selected = false;
  // Timer? timer;

  _mapScreenState() {
    startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
    endLocation = LatLng(widget.destinationLat!, widget.destinationLong!);
  }

  @override
  void initState() {
    super.initState();
    // getDataServices();
    _mapScreenState();
    // getLocation();
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   updateMap(currentLocation);
    //   //  timer = Timer.periodic(
    //   //      const Duration(minutes: 1), (Timer t) => _apigetUserLocation());
    // });
  }

  void updateMap(LocationData currentlocation) async {
    if (mounted) {
      setState(() {
        startLocation =
            LatLng(currentlocation.latitude!, currentlocation.longitude!);
      });
      // getDataServices(
      //     sourceLatitude: currentlocation.latitude,
      //     sourceLongtitude: currentlocation.longitude);
    }
  }

  void getLocation() async {
    await location.getLocation();
  }

  // Future<dynamic> getDataServices(
  //     {double? sourceLatitude, double? sourceLongtitude}) async {
  //   try {
  //     setState(() {
  //       isProgressRunning = true;
  //     });
  //     var response = await dio.get(
  //       'https://api.tomtom.com/routing/1/calculateRoute/${sourceLatitude ?? widget.sourceLat},${sourceLongtitude ?? widget.sourceLong}:${widget.destinationLat},${widget.destinationLong}/json?key=$apiKey',
  //     );

  //     if (response.statusCode == 200) {
  //       log("${response.data}");
  //       setState(() {
  //         routenav = RoutingMapModel.fromJson(response.data);
  //       });
  //     } else {
  //       log("Response data rather than 200");
  //     }
  //   } catch (e) {
  //     log("$e");
  //     // log("Api call exception");

  //   } finally {
  //     setState(() {
  //       isProgressRunning = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 10.0),
          child: Column(
            children: [
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentOptions(),
                    ),
                  );
                },
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  minLeadingWidth: 0,
                  horizontalTitleGap: 5,
                  leading: const Icon(Icons.currency_rupee),
                  title: Text('Cash',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                          )),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              ),
              const SizedBox(height: 5),
              const MaterialButton1(txt1: "Confirm Booking", height1: 44)
            ],
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: FlutterMap(
              mapController: controller,
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
                  controller: controller,
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
                      builder: (ctx) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              left: 40,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_WHITE),
                                child: Text(
                                  widget.sourceAddress.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          Image.asset(
                            ImgConstants.MARKER_MAP,
                          ),
                        ],
                      ),
                    ),
                    Marker(
                      height: MediaQuery.of(context).size.height * 0.2,
                      point: endLocation,
                      builder: (ctx) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              left: 40,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_WHITE),
                                child: Text(
                                  widget.destinationAddress.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          Image.asset(ImgConstants.MARKER_MAP_DESTINATION2),
                        ],
                      ),
                    ),
                  ]),
                ),
                isProgressRunning
                    ? const SizedBox()
                    : PolylineLayerWidget(
                        options: PolylineLayerOptions(
                          polylineCulling: true,
                          saveLayers: true,
                          polylines: [
                            Polyline(
                              // An optional tag to distinguish polylines in callback
                              points: widget
                                  .routenav!.routes![0].legs![0].points!
                                  .map((e) => LatLng(e.latitude!, e.longitude!))
                                  .toList(),
                              color: Colors.blue,
                              strokeWidth: 4.0,
                            ),
                          ],
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
        return SafeArea(
          child: Container(
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Text('Choose a trip or swipe up for more',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    )),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: widget.priceEstimateModel
                                      ?.estimationDetail?.length ??
                                  0,
                              physics: const ClampingScrollPhysics(),
                              controller: scrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    if (widget.priceEstimateModel!
                                        .estimationDetail![index].isSelected) {
                                      cabSelectedRideDetail();
                                      return;
                                    }
                                    setState(() {
                                      widget
                                          .priceEstimateModel
                                          ?.estimationDetail?[index]
                                          .isSelected = true;
                                      // String carname = widget
                                      //         .priceEstimateModel
                                      //         ?.estimationDetail?[index]
                                      //         .vehicleCategoryName ??
                                      //     '';
                                    });
                                    for (int i = 0;
                                        i <
                                            widget.priceEstimateModel!
                                                .estimationDetail!.length;
                                        i++) {
                                      if (i != index) {
                                        widget
                                            .priceEstimateModel!
                                            .estimationDetail![i]
                                            .isSelected = false;
                                      }
                                    }

                                    log(widget
                                            .priceEstimateModel
                                            ?.estimationDetail?[index]
                                            .vehicleCategoryName ??
                                        '');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    color: widget.priceEstimateModel!
                                            .estimationDetail![index].isSelected
                                        ? ColorConstant.COLOR_ORIGINAL_GREY
                                            .withOpacity(0.2)
                                        : ColorConstant.COLOR_WHITE,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13,
                                          left: 15.0,
                                          right: 10,
                                          bottom: 13),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  widget.image1 != null
                                                      ? Image.memory(
                                                          widget.image1,
                                                          height: 50,
                                                          width: 50)
                                                      : Image.asset(
                                                          ImgConstants.CAR_ICON,
                                                          width: 50,
                                                          height: 50),
                                                ],
                                              ),
                                              const SizedBox(width: 15),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget
                                                            .priceEstimateModel
                                                            ?.estimationDetail?[
                                                                index]
                                                            .vehicleCategoryName ??
                                                        '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.copyWith(
                                                          color: ColorConstant
                                                              .COLOR_TEXT,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '5:19pm 2 min away',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                          color: ColorConstant
                                                              .COLOR_TEXT,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      // const Icon(Icons.discount,
                                                      //     size: 15),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        '£${widget.priceEstimateModel?.estimationDetail?[index].estimatedPrice.toString() ?? 0.0.toString()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            ?.copyWith(
                                                              color: ColorConstant
                                                                  .COLOR_TEXT,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // Text(
                                                  //   "Rs. 99.50",
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .caption
                                                  //       ?.copyWith(
                                                  //         color: ColorConstant
                                                  //             .COLOR_ORIGINAL_GREY,
                                                  //         fontWeight:
                                                  //             FontWeight.w600,
                                                  //         decoration:
                                                  //             TextDecoration
                                                  //                 .lineThrough,
                                                  //       ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  // Cab Ride Detail BottomSheet on Selected cab

  Future<void> cabSelectedRideDetail() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.image1 != null
                      ? Center(
                          child: Image.memory(widget.image1,
                              width: MediaQuery.of(context).size.width * 0.15,
                              fit: BoxFit.fill),
                        )
                      : Center(
                          child: Image.asset(ImgConstants.CAR_ICON,
                              width: MediaQuery.of(context).size.width * 0.15,
                              fit: BoxFit.fill),
                        ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.priceEstimateModel?.estimationDetail?[0]
                                .vehicleCategoryName ??
                            '',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '£${widget.priceEstimateModel?.estimationDetail?[0].estimatedPrice.toString() ?? 0.0.toString()}',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '10:24am 2 min away',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Affordable compact rides',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    splashColor: ColorConstant.COLOR_LIGHT_GREY,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentOptions(),
                        ),
                      );
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      minLeadingWidth: 0,
                      horizontalTitleGap: 5,
                      leading: const Icon(Icons.currency_rupee),
                      title: Text('Cash',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  )),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const MaterialButton1(txt1: "Confirm Booking", height1: 44)
                ],
              ),
            ));
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
