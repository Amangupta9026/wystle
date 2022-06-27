// ignore_for_file: unused_field

import 'dart:developer';

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as getlocation1;

// ignore: must_be_immutable
class HomeScreenMap extends StatefulWidget {
  double? sourceLat;
  double? sourceLong;
  final String? latLong;

  HomeScreenMap({
    Key? key,
    this.sourceLat,
    this.sourceLong,
    this.latLong,
  }) : super(key: key);

  @override
  State<HomeScreenMap> createState() => _HomeScreenMapState();
}

class _HomeScreenMapState extends State<HomeScreenMap> {
  getlocation1.LocationData? _currentPosition;

  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";

  LatLng? startLocation;
  bool isProgressRunning = false;
  String? getAddress = '';
  String location = '';
  Position? position;
  double? getlat;
  double? getlng;

  @override
  void initState() {
    super.initState();
    getCurrentAddress();
    startLocation = LatLng(
        position?.latitude ?? 26.7489214, position?.longitude ?? 83.3588654);
    //  LatLng startLocation = LatLng(position!.latitude, position!.longitude);
  }

  Future<void> getCurrentAddress() async {
    position = await _getGeoLocationPosition();
    location = '${position?.latitude}:${position?.longitude}';
    getlat = position?.latitude;
    getlng = position?.longitude;
    startLocation = LatLng(position!.latitude, position!.longitude);
    // GetAddressFromLatLong(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    getAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    if (mounted) {
      setState(() {});
    }
    log('street ${place.street}');
    log('subLocality ${place.subLocality}');
    log('locality ${place.locality}');
    log('postalCode ${place.postalCode}');
    log('country ${place.country}');

    log(location);
  }

  @override
  Widget build(BuildContext context) {
    // LatLng startLocation = LatLng(26.7489716, 83.3588597);
    // LatLng endLocation = LatLng(27.6688312, 85.3077329);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
                onMapCreated: _handle(),
                onTap: _nav(),
                debugMultiFingerGestureWinner: true,
                enableMultiFingerGestureRace: true,
                allowPanningOnScrollingParent: false,
                allowPanning: false,
                enableScrollWheel: false,
                center:
                    startLocation ?? LatLng(51.5112422, 0.08354929999999999),
                zoom: 14.0),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                    attributionBuilder: (_) {
                      return InkWell(
                        onTap: () {},
                      );
                    },
                    urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                        "{z}/{x}/{y}.png?key={apiKey}",
                    additionalOptions: {"apiKey": apiKey}),
              ),
              MarkerLayerWidget(
                options: MarkerLayerOptions(rotate: false, markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: startLocation ??
                        LatLng(51.5112422, 0.08354929999999999),
                    builder: (ctx) => const Icon(Icons.location_on,
                        size: 25.0, color: Colors.red),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _handle() {
    log("initial value oncreatedmap print");
  }

  _nav() {
    // log("click");
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
