// // ignore_for_file: unused_field

// import 'dart:developer';

// import "package:flutter/material.dart";
// import "package:flutter_map/flutter_map.dart";
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';

// import 'map.dart';

// // ignore: must_be_immutable
// class MapHomePage extends StatefulWidget {
//   const MapHomePage({Key? key}) : super(key: key);

//   @override
//   State<MapHomePage> createState() => _MapHomePageState();
// }

// class _MapHomePageState extends State<MapHomePage> {
//   final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
//   var location = Location();
//   LocationData? _currentPosition;
//   LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
//   String? _address, _dateTime;
//   double? latitude1;
//   double? longitude1;
//   bool isOnline = false;
//   bool enabled = false;

//   @override
//   void initState() {
//     super.initState();
//     enableLocation();
//   }

//   Future<void> enableLocation() async {
//     location = Location();
//     enabled = await location.serviceEnabled();

//     _currentPosition = await location.getLocation();
//     _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
//         _currentPosition!.longitude!.toDouble());
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       log("${currentLocation.latitude} : ${currentLocation.longitude}");
// if(mounted) {
//  return setState(() {
//         //
//         latitude1 = currentLocation.latitude;
//         longitude1 = currentLocation.longitude;
//         _currentPosition = currentLocation;
//         _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
//             _currentPosition!.longitude!.toDouble());

//         DateTime now = DateTime.now();
//         _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//       });
// }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final starttomtomHQ = LatLng(26.7489993, 83.3588346);
//     // final starttomtomHQ = LatLng(26.7489993, 83.3588346);
//     LatLng startLocation =
//         //LatLng(
//         // SharedPreference.getValue(PrefConstants.LATITUDE.toString()),
//         // SharedPreference.getValue(PrefConstants.LONGITUDE.toString()));
//         LatLng(26.7489716, 83.3588597);
//     // LatLng endLocation = LatLng(
//     //     SharedPreference.getValue(PrefConstants.LATITUDE),
//     //     SharedPreference.getValue(PrefConstants.LONGITUDE));
//     //LatLng(27.6688312, 85.3077329);
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           FlutterMap(
//             options: MapOptions(
//                 debugMultiFingerGestureWinner: true,
//                 enableMultiFingerGestureRace: true,
//                 allowPanningOnScrollingParent: false,
//                 allowPanning: false,
//                 enableScrollWheel: false,
//                 center: startLocation,
//                 zoom: 14.0),

//             // options: MapOptions(
//             //   center: LatLng(0, 0),
//             //   zoom: 18.0,
//             // ),
//             children: [
//               TileLayerWidget(
//                 options: TileLayerOptions(
//                     attributionBuilder: (_) {
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Map1()),
//                           );
//                         },
//                       );
//                     },
//                     urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
//                         "{z}/{x}/{y}.png?key={apiKey}",
//                     additionalOptions: {"apiKey": apiKey}),
//                 // urlTemplate:
//                 //     "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 //  subdomains: ['a', 'b', 'c']),
//                 //  tileProvider: const CachedTileProvider()),
//               ),
//               MarkerLayerWidget(
//                 options: MarkerLayerOptions(
//                   rotate: false,
//                   markers: [
//                     Marker(
//                       width: 80.0,
//                       height: 80.0,
//                       point: startLocation,
//                       builder: (ctx) => const Icon(Icons.location_on,
//                           size: 40.0, color: Colors.blue),
//                     ),
//                     // Marker(
//                     //   width: 80.0,
//                     //   height: 80.0,
//                     //   point: endLocation,
//                     //   builder: (ctx) => Container(
//                     //     child: Icon(Icons.location_on),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               // PolylineLayerWidget(
//               //   options: PolylineLayerOptions(
//               //     polylines: List.generate(
//               //       10,
//               //       (index) => Polyline(
//               //         isDotted: true,
//               //         points: [
//               //           LatLng(27.6683619, 85.3101895),
//               //           LatLng(28.6688312, 86.3077329)
//               //         ],
//               //         strokeWidth: 10.0,
//               //         color: Colors.blue,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),

//           // FlutterMap(
//           //   options: MapOptions(center: startLocation, zoom: 13.0),
//           //   layers: [
//           //     TileLayerOptions(

//           // urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
//           //     "{z}/{x}/{y}.png?key={apiKey}",
//           // additionalOptions: {"apiKey": apiKey},
//           //     ),
//           // MarkerLayerOptions(
//           //   markers: [
//           //     Marker(
//           //       width: 80.0,
//           //       height: 80.0,
//           //       point: startLocation,
//           //       builder: (BuildContext context) => const Icon(
//           //           Icons.location_on,
//           //           size: 60.0,
//           //           color: Colors.black),
//           //     ),
//           //     Marker(
//           //       width: 80.0,
//           //       height: 80.0,
//           //       point: endLocation,
//           //       builder: (BuildContext context) => const Icon(
//           //           Icons.location_on,
//           //           size: 60.0,
//           //           color: Colors.black),
//           //     ),
//           //   ],
//           // ),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }
// }
