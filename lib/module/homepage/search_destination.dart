import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../constant/color_constant.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;

import '../../model/searchmap_place_model.dart';
import '../../testing/search_location_map.dart';

class SearchDestination extends StatefulWidget {
  const SearchDestination({Key? key}) : super(key: key);

  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {
  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
  final List<Marker> markers = List.empty(growable: true);
  LatLng startLocation = LatLng(26.7489716, 83.3588597);
//  var response;
  List<Results>? results;
  String location = '';
  String getAddress = '';

  @override
  void initState() {
    super.initState();
    getCurrentAddress();
  }

  Future<void> getCurrentAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    // GetAddressFromLatLong(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks.toString());
    Placemark place = placemarks[0];
    getAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
    log('street ${place.street}');
    log('subLocality ${place.subLocality}');
    log('locality ${place.locality}');
    log('postalCode ${place.postalCode}');
    log('country ${place.country}');

    log(location);

    // Future<void> GetAddressFromLatLong(Position position) async {
    //   List<Placemark> placemarks =
    //       await placemarkFromCoordinates(position.latitude, position.longitude);
    //   print(placemarks);
    //   Placemark place = placemarks[0];
    //   address =
    //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    //   setState(() {});
    //   log("address $address");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: const Icon(
          Icons.arrow_back,
          color: ColorConstant.COLOR_BLACK,
          size: 28,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Container(
                height: 46,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                decoration: const BoxDecoration(
                    color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                child: TextField(
                  onSubmitted: (value) {
                    // log('$value');
                    // getAddresses(
                    //     value, startLocation.latitude, startLocation.longitude);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: getAddress,
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.COLOR_BLACK,
                    ),
                  ),
                ),
              ),
              // Visibility(
              //     visible: response != null ? true : false,
              //     child: Text("${response.streetName}")),
              Container(
                height: 46,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                decoration: const BoxDecoration(
                    color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 0, bottom: 0),
                child: TextField(
                  onChanged: (value) {
                    log(value);
                    // getAddresses(
                    //     value, startLocation.latitude, startLocation.longitude);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Destination',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.COLOR_BLACK,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: ListView.builder(
          itemCount: results?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchLocationMap()),
                    );
                    log("click individual location");
                  },
                  child: ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(
                      results?[index].address?.streetName ?? "",
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    subtitle: Text(
                      results?[index].address?.municipality ?? "",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
            // title: Text("List item $index"));
          }),

      // body: Center(
      //     child: Stack(
      //   children: <Widget>[
      //     FlutterMap(
      //       options: MapOptions(center: startLocation, zoom: 13.0),
      //       layers: [
      //         TileLayerOptions(
      //           urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
      //               "{z}/{x}/{y}.png?key={apiKey}",
      //           additionalOptions: {"apiKey": apiKey},
      //         ),
      //         MarkerLayerOptions(
      //           markers: markers,
      //         ),
      //       ],
      //     ),
      //     // Container(
      //     //     padding: EdgeInsets.all(20),
      //     //     alignment: Alignment.bottomLeft,
      //     //     child: Image.asset("images/tt_logo.png")),
      //   ],
      // )),
    );
  }

  getAddresses(value, lat, lon) async {
    final Map<String, String> queryParameters = {'key': apiKey};
    queryParameters['lat'] = '$lat';
    queryParameters['lon'] = '$lon';

    try {
      var response = await http.get(Uri.https(
          'api.tomtom.com', '/search/2/search/$value.json', queryParameters));
      SearchModel jsonData =
          SearchModel.fromJson(convert.jsonDecode(response.body));
      log('data $jsonData');
      //
      if (mounted) {
        setState(() {
          results = jsonData.results;
        });
      }
      log("printing $results");
      if (results != null && results!.isNotEmpty) {
        for (var element in results!) {
          var position = element.position;
          var marker = Marker(
            point: LatLng(position!.lat!, position.lon!),
            width: 50.0,
            height: 50.0,
            builder: (BuildContext context) =>
                const Icon(Icons.location_on, size: 40.0, color: Colors.blue),
          );
          markers.add(marker);
        }
      }

      final initialMarker = Marker(
        width: 50.0,
        height: 50.0,
        point: startLocation,
        builder: (BuildContext context) =>
            const Icon(Icons.location_on, size: 60.0, color: Colors.red),
      );
      markers.add(initialMarker);
    } catch (e) {
      log(e.toString());
    }
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

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks.toString());
    Placemark place = placemarks[0];
    getAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }
}
