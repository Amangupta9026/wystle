// ignore_for_file: unused_field

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as getlocation1;

import '../constant/map_api_key.dart';

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

  final String apiKey = tomTomMapKey;

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
  }

  Future<void> getCurrentAddress() async {
    position = await _getGeoLocationPosition();
    location = '${position?.latitude}:${position?.longitude}';
    getlat = position?.latitude;
    getlng = position?.longitude;
    startLocation = LatLng(position!.latitude, position!.longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);

    Placemark place = placemarks[0];
    getAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    if (mounted) {
      setState(() {});
    }
    // log('street ${place.street}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
                // onMapCreated: _handle(),
                // onTap: _nav(),
                debugMultiFingerGestureWinner: false,
                enableMultiFingerGestureRace: false,
                allowPanningOnScrollingParent: false,
                allowPanning: false,
                enableScrollWheel: false,
                center:
                    startLocation ?? LatLng(51.5112422, 0.08354929999999999),
                zoom: 14.0),
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                    // attributionBuilder: (_) {
                    //   return InkWell(
                    //     onTap: () {},
                    //   );
                    // },
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

  // _handle() {
  //   log("initial value oncreatedmap print");
  // }

  // _nav() {
  //   // log("click");
  // }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
