import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/testing/google_places.dart';

import '../../constant/color_constant.dart';
import '../../model/login_cookies_model.dart';
import '../../model/user_location_model.dart';
import '../../push_notification/firebase_messaging.dart';
import '../../service/api_constants.dart';
import '../../utils/utils.dart';
import '../menu/menu_profile.dart';
import '../sharedpreference/shared_preference.dart';
import '../sharedpreference/userdata.dart';
import '../../map/homescreen_map.dart';

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
  double? getlat;
  double? getlong;
  final String apiKey = "6ufmOlgvbUM74wskYZflYLAgZSaFXQGq";
  final List<Marker> markers = List.empty(growable: true);
  // final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();
  bool isProgressRunning = false;
  LoginCookiesModel? loginCookiesModel;
  var now = DateTime.now();
  var formatterDate = DateFormat('dd/MM/yy');
  var formatterTime = DateFormat('kk:mm');
  UserLocationModel? userLocationModel;
  var userdata = UserData.geUserData();

  // googlemapflutter.LatLng startLocation =
  //     const googlemapflutter.LatLng(26.7489716, 83.3588597);

  @override
  void initState() {
    super.initState();
    checkInternet();
    Messaging.showMessage();
    log(SharedPreference.getValue(PrefConstants.USER_DATA));
    log(SharedPreference.getValue(PrefConstants.USER_LOCATION_DATA));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: widget.screencolor1 != null
    //         ? Color(int.tryParse('0xFF${widget.screencolor1}')!)
    //         : ColorConstant.THEME_COLOR_RED));
    return Container(
      color: widget.screencolor1 != null
          ? Color(int.tryParse('0xFF${widget.screencolor1}')!)
          : ColorConstant.THEME_COLOR_RED,
      child: Scaffold(
        // key: _scaffoldStateKey,
        // drawer: const DrawerScreen(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
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
      ),
    );
  }

  Widget backgroundWidget(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
                // flex: 35,
                height: MediaQuery.of(context).size.height * 0.38,
                child: ClipPath(
                    clipper: DialogonalClipper(),
                    child: Container(
                        color: widget.screencolor1 != null
                            ? Color(
                                int?.tryParse("0xFF${widget.screencolor1}")!)
                            : const Color(0xFF737373)))),
          ],
        ));
  }

  Widget foregroundWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuProfile()),
                      );
                    },
                    child: const Icon(
                      Icons.menu,
                      color: ColorConstant.COLOR_WHITE,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Good afternoon, ${userdata.firstname}",
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
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Diamond",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Your next reward",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Your 2 ride away",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
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
                  padding: const EdgeInsets.fromLTRB(10, 35, 10, 0),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: ColorConstant.COLOR_WHITE,
                            // borderRadius: BorderRadius.circular(20),
                            boxShadow: [
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
                          padding: const EdgeInsets.fromLTRB(20.0, 20, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your location",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(
                                            color: ColorConstant
                                                .COLOR_ORIGINAL_GREY,
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    // const SizedBox(height: 10),
                                    // Text(
                                    //   getAddress ?? 'Select Location',
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .subtitle2
                                    //       ?.copyWith(
                                    //         color: ColorConstant.COLOR_BLACK,
                                    //         fontWeight: FontWeight.w600,
                                    //       ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 40),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Colors.greenAccent[400],
                                        radius: 40,
                                        child: HomeScreenMap(
                                          latLong: location,
                                        ),
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
                                        color: ColorConstant.THEME_COLOR_RED,
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
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                "7m pickup",
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
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => GoogleMapRouteNav()),
                        // );
                      },
                      child: Text(
                        "MANAGE",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.THEME_COLOR_RED,
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
                    Card(
                      elevation: 3,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: const BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                            // borderRadius: BorderRadius.circular(20),
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
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: const BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                            // borderRadius: BorderRadius.circular(20),
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
                                      color: const Color(0xFF292929),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                          decoration: const BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
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
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "12 minutes",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Find route List

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GoogleSearchPlace(
                        yourLocation: getAddress,
                      )),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                decoration: const BoxDecoration(
                  color: ColorConstant.COLOR_WHITE,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Find a route",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            )),
                    Row(
                      children: [
                        Text("3:06pm dropoff",
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
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
            ),
          ),
        ),
      ],
    );
  }

  // getAddresses(value, lat, lon) async {
  //   final Map<String, String> queryParameters = {'key': apiKey};
  //   queryParameters['lat'] = '$lat';
  //   queryParameters['lon'] = '$lon';

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
  // }

  // Future<void> getAddressFromLatLong(Position position) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   log(placemarks.toString());
  //   Placemark place = placemarks[0];
  //   getAddress =
  //       '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(() {});
  // }

  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     await Geolocator.openLocationSettings();
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }

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
