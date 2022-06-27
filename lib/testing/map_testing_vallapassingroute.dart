// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../constant/color_constant.dart';
// import '../constant/dio_client.dart';
// import '../model/route_map_navigation_vella_model.dart';

// class GoogleMapRouteNav extends StatefulWidget {
//   double? sourceLat;
//   double? sourceLong;
//   double? destinationLat;
//   double? destinationLong;
//   GoogleMapRouteNav(
//       {Key? key,
//       this.sourceLat,
//       this.sourceLong,
//       this.destinationLat,
//       this.destinationLong})
//       : super(key: key);

//   @override
//   _GoogleMapRouteNavState createState() => _GoogleMapRouteNavState();
// }

// class _GoogleMapRouteNavState extends State<GoogleMapRouteNav> {
//   GoogleMapController? mapController; //contrller for Google map
//   PolylinePoints polylinePoints = PolylinePoints();

//   String googleAPiKey = "AIzaSyAqBj9HwZpHsGIspT8FdfyI235ZgDIozIk";

//   Set<Marker> markers = {}; //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

//   bool isProgressRunning = false;
//   static var response;
//   Trip trip = Trip();
//   RouteNavigationModel? routenav;

//   LatLng? startLocation;
//   LatLng? endLocation;

//   _mapScreenState() {
//     startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
//     endLocation = LatLng(widget.destinationLat!, widget.destinationLong!);
//   }

//   Future<dynamic> getDataServices() async {
//     try {
//       response = await dio.get(
//         'http://map.k2ai.com:8002/route?json={"locations":[{"lat":51.5112422,"lon":-0.08354929999999999},{"lat":51.55602469999999,"lon":-0.2796177}],"costing":"auto","directions_options":{"units":"kilometer"}}',
//       );

//       if (response.statusCode == 200) {
//         log("${response.data}");
//         setState(() {
//           routenav = RouteNavigationModel.fromJson(response.data);
//         });
//         // return

//       } else {
//         log("Response data rather than 200");
//       }
//     } catch (e) {
//       log("$e");
//       // log("Api call exception");
//     }
//   }

//   @override
//   void initState() {
//     _mapScreenState();
//     getDataServices();
//     LatLng startLocation = LatLng(widget.sourceLat!, widget.sourceLong!);
//     LatLng endLocation =
//         LatLng(widget.destinationLat!, widget.destinationLong!);

//     markers.add(Marker(
//       //add start location marker
//       markerId: MarkerId(startLocation.toString()),
//       position: startLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Starting Point ',
//         snippet: 'Start Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(endLocation.toString()),
//       position: endLocation, //position of marker
//       infoWindow: const InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//     ));

//     getDirections(); //fetch direction polylines from Google API

//     super.initState();
//   }

//   getDirections() async {
//     List<LatLng> polylineCoordinates = [];

//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleAPiKey,
//       PointLatLng(startLocation!.latitude, startLocation!.longitude),
//       PointLatLng(endLocation!.latitude, endLocation!.longitude),
//       travelMode: TravelMode.driving,
//     );

//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       log(result.errorMessage.toString());
//     }
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = const PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               //Map widget from google_maps_flutter package
//               zoomGesturesEnabled: true, //enable Zoom in, out on map
//               initialCameraPosition: CameraPosition(
//                 //innital position in map
//                 target: startLocation!, //initial position
//                 zoom: 16.0, //initial zoom level
//               ),
//               markers: markers, //markers to show on map
//               polylines: Set<Polyline>.of(polylines.values), //polylines
//               mapType: MapType.normal, //map type
//               onMapCreated: (controller) {
//                 //method called when map is created
//                 setState(() {
//                   mapController = controller;
//                 });
//               },
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                       decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(30.0)),
//                         color: ColorConstant.COLOR_LIGHT_GREEN.withOpacity(0.8),
//                       ),
//                       width: MediaQuery.of(context).size.width * 0.9,
//                       height: MediaQuery.of(context).size.height * 0.15,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: const [
//                                 Icon(
//                                   Icons.arrow_upward_outlined,
//                                   size: 80,
//                                   color: ColorConstant.COLOR_WHITE,
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   routenav?.trip?.legs?[0].maneuvers?[0]
//                                           .instruction ??
//                                       'Location Fetching',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .subtitle1
//                                       ?.copyWith(
//                                         color: ColorConstant.COLOR_WHITE,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 10.0),
//                 child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(30.0)),
//                       color: ColorConstant.COLOR_LIGHT_GREEN.withOpacity(0.8),
//                     ),
//                     width: MediaQuery.of(context).size.width * 0.9,
//                     height: MediaQuery.of(context).size.height * 0.14,
//                     child: Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               if (routenav?.trip != null) ...{
//                                 Text(
//                                   'Time:  ${routenav?.trip?.summary?.time}',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .subtitle1
//                                       ?.copyWith(
//                                         color: ColorConstant.COLOR_WHITE,
//                                         fontWeight: FontWeight.w900,
//                                       ),
//                                 ),

//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 10, bottom: 10),
//                                   child: Text(
//                                     'Cost:  ${routenav?.trip?.summary?.cost}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .subtitle1
//                                         ?.copyWith(
//                                           color: ColorConstant.COLOR_WHITE,
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                   ),
//                                 ),

//                                 Text(
//                                   'Length:  ${routenav?.trip?.summary?.length}',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .subtitle1
//                                       ?.copyWith(
//                                         color: ColorConstant.COLOR_WHITE,
//                                         fontWeight: FontWeight.w900,
//                                       ),
//                                 ),

//                                 // Text(routenav?.trip?.locations?[0].sideOfStreet ??
//                                 //     'GetData'),
//                               },
//                             ],
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // // ignore_for_file: unused_field

// // import 'dart:developer';

// // import 'package:dio/dio.dart';
// // import "package:flutter/material.dart";
// // import "package:flutter_map/flutter_map.dart";
// // import 'package:latlong2/latlong.dart';
// // import 'package:location/location.dart';

// // import '../constant/dio_client.dart';
// // import '../model/route_map_navigation_vella_model.dart';
// // import '../module/homepage/map.dart';
// // import '../service/api_services.dart';

// // RouteNavigationModel? getNavigationRouteData;

// // // ignore: must_be_immutable
// // class MapRouteNavigation extends StatefulWidget {
// //   const MapRouteNavigation({Key? key}) : super(key: key);

// //   @override
// //   State<MapRouteNavigation> createState() => _MapRouteNavigationState();
// // }

// // class _MapRouteNavigationState extends State<MapRouteNavigation> {
// //   LocationData? _currentPosition;
// //   bool isProgressRunning = false;
//   // static var response;
//   // Trip trip = Trip();
//   // RouteNavigationModel? routenav;

// //   final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";

// //   // Future<void> getData() async {
// //   //   try {
// //   //     setState(() {
// //   //       isProgressRunning = true;
// //   //     });
// //   //     routenav = await APIServices.getDataServices();
// //   //     log("show data");
// //   //     // setState(() {
// //   //     //   trip = routenav?.trip;
// //   //     // });
// //   //   } catch (e) {
// //   //     log(e.toString());
// //   //   } finally {
// //   //     setState(() {
// //   //       isProgressRunning = false;
// //   //     });
// //   //   }
// //   // }
//   // Future<dynamic> getDataServices() async {
//   //   try {
//   //     response = await dio.get(
//   //       'http://3.110.223.163:8002/route?json={"locations":[{"lat":51.513159,"lon":-0.089380},{"lat":51.518407,"lon":-0.126330}],"costing":"auto","directions_options":{"units":"miles"}}',
//   //     );

//   //     if (response.statusCode == 200) {
//   //       log("${response.data}");
//   //       setState(() {
//   //         routenav = RouteNavigationModel.fromJson(response.data);
//   //       });
//   //       // return

//   //     } else {
//   //       log("Response data rather than 200");
//   //     }
//   //   } catch (e) {
//   //     log("$e");
//   //     // log("Api call exception");
//   //   }
//   // }

// //   @override
// //   void initState() {
// //     super.initState();
// //     getDataServices();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // LatLng startLocation = LatLng(26.7489716, 83.3588597);
// //     // LatLng endLocation = LatLng(27.6688312, 85.3077329);

// //     LatLng startLocation = LatLng(26.7489716, 83.3588597);
// //     LatLng endLocation = LatLng(27.6688312, 85.3077329);

// //     return Scaffold(
// //         body: isProgressRunning
// //             ? Column(
// //                 children: const [
// //                   CircularProgressIndicator(),
// //                 ],
// //               )
// //             : SafeArea(
// //                 child: Column(
// //                   children: [
//                     // if (routenav?.trip != null) ...{
//                     //   Text(routenav?.trip?.locations?[0].sideOfStreet ?? 'Get'),
//                     //   // Text(routenav?.trip?.locations?[0].sideOfStreet ??
//                     //   //     'GetData'),
//                     // },
// //                     SizedBox(
// //                       height: MediaQuery.of(context).size.height * 0.4,
// //                       child: Stack(
// //                         children: <Widget>[
// //                           const SizedBox(
// //                             height: 150,
// //                           ),
// //                           FlutterMap(
// //                             options: MapOptions(
// //                                 onMapCreated: _handle(),
// //                                 onTap: _nav(),
// //                                 debugMultiFingerGestureWinner: true,
// //                                 enableMultiFingerGestureRace: true,
// //                                 allowPanningOnScrollingParent: false,
// //                                 allowPanning: false,
// //                                 enableScrollWheel: false,
// //                                 center: startLocation,
// //                                 zoom: 14.0),

// //                             // options: MapOptions(
// //                             //   center: LatLng(0, 0),
// //                             //   zoom: 18.0,
// //                             // ),
// //                             children: [
// //                               TileLayerWidget(
// //                                 options: TileLayerOptions(
// //                                     attributionBuilder: (_) {
// //                                       return InkWell(
// //                                         onTap: () {
// //                                           // Navigator.push(
// //                                           //   context,
// //                                           //   MaterialPageRoute(
// //                                           //       builder: (context) => const Map1()),
// //                                           // );
// //                                         },
// //                                       );
// //                                     },
// //                                     urlTemplate:
// //                                         "https://api.tomtom.com/map/1/tile/basic/main/"
// //                                         "{z}/{x}/{y}.png?key={apiKey}",
// //                                     additionalOptions: {"apiKey": apiKey}),
// //                                 // urlTemplate:
// //                                 //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
// //                                 //  subdomains: ['a', 'b', 'c']),
// //                                 //  tileProvider: const CachedTileProvider()),
// //                               ),
// //                               // MarkerLayerWidget(
// //                               //   options: MarkerLayerOptions(
// //                               //     rotate: false,
// //                               //     markers: [
// //                               //       Marker(
// //                               //         width: 40.0,
// //                               //         height: 40.0,
// //                               //         point: LatLng(
// //                               //             getNavigationRouteData!
// //                               //                 .trip!.locations![0].lat!
// //                               //                 .toDouble(),
// //                               //             getNavigationRouteData!
// //                               //                 .trip!.locations![0].lon!
// //                               //                 .toDouble()),
// //                               //         // startLocation,
// //                               //         builder: (ctx) => const Icon(Icons.location_on,
// //                               //             size: 25.0, color: Colors.red),
// //                               //       ),
// //                               //       // Marker(
// //                               //       //   width: 80.0,
// //                               //       //   height: 80.0,
// //                               //       //   point: endLocation,
// //                               //       //   builder: (ctx) => Container(
// //                               //       //     child: Icon(Icons.location_on),
// //                               //       //   ),
// //                               //       // ),
// //                               //     ],
// //                               //   ),
// //                               // ),
// //                               // PolylineLayerWidget(
// //                               //   options: PolylineLayerOptions(
// //                               //     polylines: List.generate(
// //                               //       10,
// //                               //       (index) => Polyline(
// //                               //         isDotted: true,
// //                               //         points: [
// //                               //           LatLng(27.6683619, 85.3101895),
// //                               //           LatLng(28.6688312, 86.3077329)
// //                               //         ],
// //                               //         strokeWidth: 10.0,
// //                               //         color: Colors.blue,
// //                               //       ),
// //                               //     ),
// //                               //   ),
// //                               // ),
// //                             ],
// //                           ),
// //                           FlutterMap(
// //                             options:
// //                                 MapOptions(center: startLocation, zoom: 13.0),
// //                             layers: [
// //                               TileLayerOptions(
// //                                 urlTemplate:
// //                                     "https://api.tomtom.com/map/1/tile/basic/main/"
// //                                     "{z}/{x}/{y}.png?key={apiKey}",
// //                                 additionalOptions: {"apiKey": apiKey},
// //                               ),
// //                               MarkerLayerOptions(
// //                                 markers: [
// //                                   Marker(
// //                                     width: 80.0,
// //                                     height: 80.0,
// //                                     point: startLocation,
// //                                     builder: (BuildContext context) =>
// //                                         const Icon(Icons.location_on,
// //                                             size: 60.0, color: Colors.black),
// //                                   ),
// //                                   Marker(
// //                                     width: 80.0,
// //                                     height: 80.0,
// //                                     point: endLocation,
// //                                     builder: (BuildContext context) =>
// //                                         const Icon(Icons.location_on,
// //                                             size: 60.0, color: Colors.black),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ],
// //                           )
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ));
// //   }

// //   _handle() {
// //     log("initial value oncreatedmap print");
// //   }

// //   _nav() {
// //     log("click");
// //   }
// // }
