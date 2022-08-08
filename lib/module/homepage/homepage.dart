import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/testing/gpay_testing.dart';

import '../../constant/color_constant.dart';
import '../../constant/map_api_key.dart';
import '../../service/api_constants.dart';
import '../../testing/freshchat.dart';
import '../../testing/google_places.dart';
import '../../utils/utils.dart';
import '../../map/homescreen_map.dart';
import '../../widget/reusubility_button.dart';
import '../menu/menu_profile.dart';
import '../sharedpreference/shared_preference.dart';
import '../sharedpreference/userdata.dart';

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

  final String apiKey = tomTomMapKey;
  // final List<Marker> markers = List.empty(growable: true);
  // final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();
  bool isProgressRunning = false;

  var userdata = UserData.geUserData();
  TextEditingController dateinput = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
  TimeOfDay selectedTime = TimeOfDay.now();
  var add10MinuteTime;
  // add10MinuteTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    checkInternet();
    // Messaging.showMessage();
    log(SharedPreference.getValue(PrefConstants.USER_DATA));
    log(SharedPreference.getValue(PrefConstants.USER_LOCATION_DATA));
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: widget.screencolor1 != null
    //         ? Color(int.tryParse('0xFF${widget.screencolor1}')!)
    //         : ColorConstant.THEME_COLOR_RED));
    return Scaffold(
      // backgroundColor:,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack(
            children: [
              Container(
                color: const Color(0xFFf2f2f4),
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
                    decoration: const BoxDecoration(
                        color: ColorConstant.COLOR_WHITE,
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
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {},
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
                              Expanded(
                                child: Text(
                                  "12 drivers nearby",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FreshChatDemo()),
                        );
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

              // Find route List

              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 5, 15, 20),
                child: Card(
                  elevation: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          splashColor: ColorConstant.COLOR_LIGHT_GREY,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoogleSearchPlace(
                                        yourLocation: getAddress,
                                      )),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(15, 16, 0, 16),
                            decoration: BoxDecoration(
                              color: ColorConstant.COLOR_WHITE.withOpacity(0.2),
                            ),
                            child: Row(children: [
                              const Icon(Icons.search),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('Find route?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      )),
                            ]),
                          ),
                        ),
                      ),
                      //
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          splashColor: ColorConstant.COLOR_LIGHT_GREY,
                          onTap: () {
                            getScheduleRideBottomSheet();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(5, 12, 5, 12),
                            decoration: const BoxDecoration(
                              color: ColorConstant.COLOR_WHITE,
                            ),
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 5, 6, 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.COLOR_TEXT),
                                  color: ColorConstant.COLOR_WHITE,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.schedule),
                                    const SizedBox(width: 5),
                                    Text('Now',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            )),
                                    const SizedBox(width: 3),
                                    const Icon(Icons.expand_more),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Place List

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Gpay()),
                        );
                      },
                      child: Card(
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
                                      color: ColorConstant.COLOR_LIGHT_BLACK,
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
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            )),
                      ),
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
                                    color: ColorConstant.COLOR_LIGHT_BLACK,
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
                          ),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: ColorConstant.COLOR_LIGHT_BLACK,
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
      ],
    );
  }

  void getScheduleRideBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: ColorConstant.COLOR_WHITE,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 12),
                  child: Text(
                    'Schedule a Ride',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const Divider(
                  color: ColorConstant.COLOR_ORIGINAL_GREY,
                  thickness: 0.3,
                ),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        dateinput.text = formattedDate;
                      });
                      setState(() {});
                    } else {
                      log("Date is not selected");
                    }
                  },
                  child: Column(
                    children: [
                      dateinput.text != null
                          ? Text(dateinput.text)
                          : Text(
                              'Select Date',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: ColorConstant.COLOR_ORIGINAL_GREY,
                  thickness: 0.3,
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Text(
                        "${selectedTime.hour}:${selectedTime.minute} - ${selectedTime.hour}:${selectedTime.minute + 10}")),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  color: ColorConstant.COLOR_ORIGINAL_GREY,
                  thickness: 0.3,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GoogleSearchPlace(
                                yourLocation: getAddress,
                                time: selectedTime.hour.toString() +
                                    ":" +
                                    selectedTime.minute.toString(),
                              )),
                    );
                  },
                  child: MaterialButton1(
                    width1: MediaQuery.of(context).size.width * 0.75,
                    txt1: 'Set pickup time',
                    height1: 50,
                  ),
                )
              ]));
        });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      confirmText: "CONFIRM",
      cancelText: "NOT NOW",
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      // if(selectedTime.minute >= 60) {
      //     selectedTime = TimeOfDay(
      //         hour: timeOfDay.hour,
      //         minute: timeOfDay.minute + 10);
      //       setState(() {
      //         add10MinuteTime = timeOfDay.hour.toString() + ":" + (timeOfDay.minute + 10).toString();
      //       });
      // }
      setState(() {
        selectedTime = timeOfDay;
        add10MinuteTime = DateTime.now();
        DateTime(selectedTime.hour, selectedTime.minute);

        add10MinuteTime.add(const Duration(hours: 1));
      });
    }

    setState(() {});
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
    } else {
      InternetUtils.networkErrorDialog(context);
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
