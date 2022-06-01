import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'
    as googlemapflutter;
import 'package:wystle/constant/image_constant.dart';

import '../../constant/color_constant.dart';
import '../../testing/mapapi_testing.dart';
import "package:http/http.dart" as http;

import '../../utils/utils.dart';

class HomePage2 extends StatefulWidget {
  final String? screencolor1;
  const HomePage2({
    Key? key,
    this.screencolor1,
  }) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  String? getAddress = '';
  String location = '';
  bool isOnline = false;
  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
  final List<Marker> markers = List.empty(growable: true);
  googlemapflutter.LatLng startLocation =
      googlemapflutter.LatLng(26.7489716, 83.3588597);
//  var response;
  // List<Results>? results;

  Future<void> getCurrentAddress() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    // GetAddressFromLatLong(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
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
  void initState() {
    super.initState();
    getCurrentAddress();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: widget.screencolor1 != null
            ? Color(int?.tryParse("0xFF${widget.screencolor1}")!)
            : ColorConstant.THEME_COLOR_RED,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                color: const Color(0xFFf2f2f4),
                // color: Theme.of(context).colorScheme.primaryVariant,
              ),
              backgroundWidget(context),
              foregroundWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget backgroundWidget(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 35,
                child: ClipPath(
                    clipper: DialogonalClipper(),
                    child: Container(
                        color: widget.screencolor1 != null
                            ? Color(
                                int?.tryParse("0xFF${widget.screencolor1}")!)
                            : ColorConstant.THEME_COLOR_RED))),
            Expanded(
              flex: 65,
              child: Container(alignment: Alignment.center),
            ),
          ],
        ));
  }

  Widget foregroundWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu,
                      color: ColorConstant.COLOR_WHITE,
                    ),
                    const Spacer(),
                    Text(
                      "Good afternoon, Ryan",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          ImgConstants.CAR_ICON,
                          height: 30,
                          width: 30,
                        ),
                        Container(
                          height: 48,
                          width: 1,
                          color: ColorConstant.COLOR_WHITE,
                        ),
                        Image.asset(
                          ImgConstants.CAR_ICON,
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wystle Status",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Diamond",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Your next reward",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Your 2 ride away",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1, 1),
                              color: Colors.grey,
                              blurRadius: 2.0,
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pickup location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: ColorConstant
                                                  .COLOR_ORIGINAL_GREY,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        getAddress ?? 'Select Location',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Your 2 ride away",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_WHITE,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 40),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TomTomMapApiTesting(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.greenAccent[400],
                                          radius: 40,
                                          child: TomTomMapApiTesting(),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // const SizedBox(height: 10),
                          const Divider(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            thickness: 0.3,
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "CHANGE",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color: Colors.blue[700],
                                          //ColorConstant.THEME_COLOR_RED,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.3,
                                        ),
                                  ),
                                ),
                                Text(
                                  "12 drivers nearby",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "7m pickup",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Where to?",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "MANAGE",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                // Place List

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_BLACK,
                                    shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.home,
                                    color: ColorConstant.COLOR_WHITE,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "home",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.work,
                                    color: ColorConstant.COLOR_WHITE,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Work",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_BLACK,
                                    shape: BoxShape.circle),
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Icon(
                                    Icons.home,
                                    color: ColorConstant.COLOR_WHITE,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "airport",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Find route List

          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
            decoration: BoxDecoration(
              color: ColorConstant.COLOR_WHITE,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Find a route",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: ColorConstant.COLOR_BLACK,
                          fontWeight: FontWeight.w600,
                        )),
                Row(
                  children: [
                    Text("3:06pm dropoff",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.w600,
                            )),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getAddresses(value, lat, lon) async {
    final Map<String, String> queryParameters = {'key': '$apiKey'};
    queryParameters['lat'] = '$lat';
    queryParameters['lon'] = '$lon';

    // try {
    //   var response = await http.get(Uri.https(
    //       'api.tomtom.com', '/search/2/search/$value.json', queryParameters));
    // SearchModel jsonData =
    //     SearchModel.fromJson(convert.jsonDecode(response.body));
    // print('data $jsonData');
    //
    // if (mounted) {
    //   setState(() {
    //     results = jsonData.results;
    //   });
    // }
    // log("printing $results");
    // if (results != null && results!.isNotEmpty) {
    //   for (var element in results!) {
    //     var position = element.position;
    //     var marker = Marker(
    //       point: LatLng(position!.lat!, position.lon!),
    //       width: 50.0,
    //       height: 50.0,
    //       builder: (BuildContext context) =>
    //           const Icon(Icons.location_on, size: 40.0, color: Colors.blue),
    //     );
    //     markers.add(marker);
    //   }
    // }

    //   final initialMarker = Marker(
    //     width: 50.0,
    //     height: 50.0,
    //     point: startLocation,
    //     builder: (BuildContext context) =>
    //         const Icon(Icons.location_on, size: 60.0, color: Colors.red),
    //   );
    //   markers.add(initialMarker);
    // } catch (e) {
    //   print(e);
    // }
  }

  // Future<void> GetAddressFromLatLong(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   getAddress =
  //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(() {});
  // }

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

  // Internet Check

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
      log("Internet is connected");
    } else {
      InternetUtils.networkErrorDialog(context);
      log("Internet is not connected");
    }
  }

  // Get Current Location
}

class DialogonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 17 / 19);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 17 / 19);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}



// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
//     as datepicker;
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:wystle/constant/color_constant.dart';
// import 'package:wystle/constant/image_constant.dart';
// import 'package:wystle/menu/menu_profile.dart';
// import 'package:wystle/module/homepage/map.dart';
// import 'package:wystle/module/sharedpreference/shared_preference.dart';
// import 'package:wystle/service/api_constants.dart';
// import 'package:wystle/testing/mapapi_testing.dart';
// import 'package:wystle/utils/utils.dart';

// import '../../widget/reusubility_button.dart';
// import 'drawer.dart';
// import 'homepage_map.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   DateTime? currentTime;
//   bool isOnline = false;
//   var location = Location();
//   bool enabled = false;
//   var now;
//   String? formattedDate;
//   String? formattedTime;
//   var addtime;

//   final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     date();
//     checkInternet();
//     enableLocation();
//   }

//   date() {
//     now = DateTime.now();
//     var formatter = DateFormat('yyyy-MM-dd');
//     formattedDate = formatter.format(now);
//     log(formattedDate.toString());

//     formattedTime = DateFormat("hh:mm a").format(DateTime.now());
//     // var inputFormat = DateFormat('HH:mm');
//     // var inputDate = inputFormat.parse('11:59');
//     // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
//     // var outputDate = outputFormat.format(inputDate);
//     // print(outputDate);

//     //  var settime = DateFormat("hh:mm a").format(DateTime.now());
//     // addtime = settime.add(const Duration(minutes: 10));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldStateKey,
//       backgroundColor: ColorConstant.COLOR_WHITE,
//       drawer: DrawerScreen(),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: ColorConstant.COLOR_WHITE,
//         actions: [
//           IconButton(
//             onPressed: () {
//               _scaffoldStateKey.currentState?.openDrawer();
//             },
//             icon: const Icon(
//               Icons.menu,
//               color: ColorConstant.COLOR_BLACK,
//             ),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       Container(
//                         height: 90,
//                         decoration: BoxDecoration(
//                           color: ColorConstant.COLOR_LIGHT_GREY2,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
//                           child: Row(
//                             children: [
//                               Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: const [
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Text(
//                                         "On",
//                                         maxLines: 2,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: ColorConstant.COLOR_BLACK,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Text(
//                                         "Demand",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: ColorConstant.COLOR_BLACK,
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                               // const Spacer(),
//                               Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Image.asset(
//                                       ImgConstants.HOME_PAGE_CAR1,
//                                       height: 70,
//                                       width: 60,
//                                     )
//                                   ]),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Container(
//                         height: 90,
//                         decoration: BoxDecoration(
//                           color: ColorConstant.COLOR_LIGHT_GREY2,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
//                           child: Row(
//                             children: [
//                               Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: const [
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Text(
//                                         "Rental",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                               // const Spacer(),
//                               Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Image.asset(
//                                       ImgConstants.HOME_PAGE_CAR1,
//                                       height: 70,
//                                       width: 60,
//                                     )
//                                   ]),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Container(
//                         height: 90,
//                         decoration: BoxDecoration(
//                           color: ColorConstant.COLOR_LIGHT_GREY2,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
//                           child: Row(
//                             children: [
//                               Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: const [
//                                     Align(
//                                       alignment: Alignment.bottomLeft,
//                                       child: Text(
//                                         "OutStation",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                               //     const Spacer(),
//                               Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Image.asset(
//                                       ImgConstants.HOME_PAGE_CAR1,
//                                       height: 70,
//                                       width: 60,
//                                     )
//                                   ]),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: ColorConstant.COLOR_LIGHT_GREY,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   height: 60,
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: Row(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const Map1(),
//                             ),
//                           );
//                         },
//                         child: const Text(
//                           "Where to?",
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       const Spacer(),
//                       InkWell(
//                         onTap: () {
//                           _scheduleRideBottomSheet(context);
//                           log("click");
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Row(
//                               children: const [
//                                 Icon(
//                                   Icons.alarm,
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Text(
//                                   "Now?",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Icon(
//                                   Icons.arrow_drop_down,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             height: 45,
//                             width: 45,
//                             decoration: const BoxDecoration(
//                                 color: ColorConstant.COLOR_LIGHT_GREY2,
//                                 shape: BoxShape.circle),
//                             child: const Center(
//                               child: Icon(
//                                 Icons.location_on,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         width: 20,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "Shri Gorakhnath Mandir",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             "Pickup in 7 minute",
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Spacer(),
//                       const Icon(
//                         Icons.arrow_forward_ios,
//                         size: 25,
//                       )
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 const Divider(
//                   thickness: 2.5,
//                 ),
//                 const SizedBox(
//                   height: 15,
//                 ),

//                 // Destination for Rider

//                 // Container(
//                 //   child: Row(
//                 //     children: [
//                 //       Column(
//                 //         children: [
//                 //           Container(
//                 //             height: 45,
//                 //             width: 45,
//                 //             decoration: const BoxDecoration(
//                 //                 color: ColorConstant.COLOR_LIGHT_GREY2,
//                 //                 shape: BoxShape.circle),
//                 //             child: const Center(
//                 //               child: Icon(
//                 //                 Icons.location_on,
//                 //                 color: Colors.black,
//                 //               ),
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       const SizedBox(
//                 //         width: 20,
//                 //       ),
//                 //       Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: const [
//                 //           Text(
//                 //             "Gorakhpur Cantt",
//                 //             style: TextStyle(
//                 //               fontSize: 18,
//                 //               fontWeight: FontWeight.w600,
//                 //               color: Colors.black,
//                 //             ),
//                 //           ),
//                 //           SizedBox(
//                 //             height: 5,
//                 //           ),
//                 //           Text(
//                 //             "Pickup in 7 minute",
//                 //             style: TextStyle(
//                 //               fontSize: 15,
//                 //               fontWeight: FontWeight.w600,
//                 //               color: Colors.grey,
//                 //             ),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //       const Spacer(),
//                 //       const Icon(
//                 //         Icons.arrow_forward_ios,
//                 //         size: 25,
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 //
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),
//                 // const Divider(
//                 //   thickness: 2.5,
//                 // ),
//                 // const SizedBox(
//                 //   height: 15,
//                 // ),

//                 // const SizedBox(
//                 //   height: 5,
//                 // ),

//                 //Text(SharedPreference.getValue(PrefConstants.LATITUDE.toString())),

//                 Text(
//                   "Around you",
//                   style: Theme.of(context).textTheme.bodyText1?.merge(
//                         TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             height: 1.4),
//                       ),
//                   // style: Theme.of(context).textTheme.subtitle2?.copyWith(
//                   //       fontWeight: FontWeight.bold,
//                   //       color: Theme.of(context).textTheme.headline6?.color,
//                   //       fontSize: 20,
//                   //     ),
//                 ),

//                 const SizedBox(
//                   height: 25,
//                 ),

//                 InkWell(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Map1()),
//                     );
//                     log("click map");
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.4,
//                       width: double.infinity,
//                       child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Map1()),
//                             );
//                             log("click map");
//                           },
//                           child: const MapHomePage()),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _scheduleRideBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: false,
//         backgroundColor: Colors.transparent,
//         builder: (ctx) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25),
//                   ),
//                 ),
//                 // height: MediaQuery.of(context).size.height * 0.5,
//                 padding: const EdgeInsets.all(14.0),

//                 child: Column(
//                   children: [
//                     const SizedBox(height: 10),
//                     Text(
//                       "Schedule a Ride",
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.subtitle2?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).textTheme.headline6?.color,
//                             fontSize: 22,
//                           ),
//                     ),
//                     const SizedBox(height: 15),

//                     const Divider(
//                       thickness: 2,
//                     ),

//                     const SizedBox(height: 15),

//                     InkWell(
//                       onTap: () {
//                         // final
//                         datepicker.DatePicker.showDatePicker(context,
//                             showTitleActions: true,
//                             minTime: DateTime(2000, 3, 5),
//                             maxTime: DateTime(2022, 6, 7),
//                             theme: const datepicker.DatePickerTheme(
//                                 headerColor: Colors.green,
//                                 backgroundColor: Colors.white,
//                                 itemStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 18),
//                                 doneStyle: TextStyle(
//                                     color: Colors.black,
//                                     fontSize: 16)), onChanged: (date) {
//                           log('change $date in time zone ' +
//                               date.timeZoneOffset.inHours.toString());
//                         }, onConfirm: (date) {
//                           datepicker.DatePicker.showTimePicker(context,
//                               showTitleActions: true, onChanged: (date) {
//                             log('change $date in time zone ' +
//                                 date.timeZoneOffset.inHours.toString());
//                           }, onConfirm: (date) {
//                             log('confirm $date');
//                           }, currentTime: DateTime.now());
//                           log('confirm $date');
//                         },
//                             currentTime: DateTime.now(),
//                             locale: datepicker.LocaleType.en);

//                         // final
//                         // child: const Text(
//                         //   'show date picker(custom theme &date time range)',
//                         //   style: TextStyle(color: Colors.blue),
//                         // )

//                         // );
//                         log("date click");
//                       },
//                       child: Text(
//                         "$formattedDate",
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 15),

//                     const Divider(
//                       thickness: 2,
//                     ),

//                     const SizedBox(height: 15),

//                     Text(
//                       // "$addtime",
//                       "$formattedTime",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey,
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     const Divider(
//                       thickness: 2,
//                     ),

//                     const SizedBox(height: 20),

//                     const MaterialButton1(
//                       txt1: "Set PickUp Time",
//                       color1: ColorConstant.COLOR_BLACK,
//                       textColor1: ColorConstant.COLOR_WHITE,
//                       width1: double.infinity,
//                       height1: 50,
//                     ),

//                     const SizedBox(height: 15),

//                     // DatePicker1(),
//                     // TimePicker(),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//   }

//   Future<void> checkInternet() async {
//     isOnline = await InternetUtils.internetCheck();
//     if (isOnline) {
//       log("Internet is connected");
//     } else {
//       InternetUtils.networkErrorDialog(context);
//       log("Internet is not connected");
//     }
//   }

//   // enable location
//   Future<void> enableLocation() async {
//     location = Location();
//     enabled = await location.serviceEnabled();
//   }
// }
