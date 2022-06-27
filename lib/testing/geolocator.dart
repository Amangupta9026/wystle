// // ignore_for_file: unused_field

// import 'dart:developer';

// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:wystle/auth/onboarding.dart';

// class MyLocation extends StatefulWidget {
//   const MyLocation({Key? key}) : super(key: key);

//   @override
//   _MyLocationState createState() => _MyLocationState();
// }

// class _MyLocationState extends State<MyLocation> {
//   LocationData? _currentPosition;
//   String? _address, _dateTime;
//   // GoogleMapController? mapController;
//   // Marker? marker;
//   Location location = Location();

//   // GoogleMapController? _controller;
//   // ignore: prefer_const_constructors
//   // LatLng  _initialcameraposition = LatLng(0.5937, 0.9629);

//   @override
//   void initState() {
//     super.initState();
//      getLoc();
//     initPlatformState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("Please allow the location"),
//                 ElevatedButton(
//                     onPressed: () {
//                       getLoc();
                      
//                       if (_currentPosition != null) {
//                         //  await getLoc();
//                         log(
//                           "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
//                         );
//                       } else {
//                         log("please enable");
//                       }
//                     },
//                     child: const Text("print")),
//                 ElevatedButton(
//                   onPressed: () async {
//                     var location = Location();
//                     bool enabled = await location.serviceEnabled();

//                     if (!enabled) {
//                       AppSettings.openLocationSettings();
//                     }
//                     //  else
//                     if (enabled) {
//                       log(" enable");
//                       log(
//                         "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const OnBoarding()),
//                       );
//                     }
//                   },
//                   child: const Text("open location settings"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   getLoc() async {
//     // bool _serviceEnabled;
//     // PermissionStatus _permissionGranted;

//     // _serviceEnabled = await location.serviceEnabled();
//     // if (!_serviceEnabled) {
//     //   _serviceEnabled = await location.requestService();
//     //   if (!_serviceEnabled) {
//     //     return;
//     //   }
//     // }

//     // _permissionGranted = await location.hasPermission();
//     // if (_permissionGranted == PermissionStatus.denied) {
//     //   _permissionGranted = await location.requestPermission();
//     //   if (_permissionGranted != PermissionStatus.granted) {
//     //     return;
//     //   }
//     // }

//     _currentPosition = await location.getLocation();
//     _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
//         _currentPosition!.longitude!.toDouble());
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       log("${currentLocation.longitude} : ${currentLocation.longitude}");
//       setState(() {
//         _currentPosition = currentLocation;
//         _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
//             _currentPosition!.longitude!.toDouble());

//         DateTime now = DateTime.now();
//         _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//       });
//     });
//   }

//   /// Initialize platform state.
//   Future<void> initPlatformState() async {
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//   }
// }
