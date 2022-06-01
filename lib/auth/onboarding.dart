// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wystle/auth/mobile_loginscreen.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/sharedpreference/shared_preference.dart';
import 'package:wystle/service/api_constants.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../constant/color_constant.dart';
import '../model/boarding_model.dart';
import '../service/api_services.dart';
import '../service/aws_service.dart';
import '../utils/utils.dart';
import '../widget/shimmer_effect_line.dart';
import '../widget/shimmer_progress_widget.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  // ignore: prefer_typing_uninitialized_variables
  var _base64;
  bool isProgressRunning = false;
  BoardingModel? boardingModel;
  var location = Location();
  LocationData? _currentPosition;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  String? _address, _dateTime;
  double? latitude1;
  double? longitude1;
  bool isOnline = false;
  bool enabled = false;

  Future<void> _apiBoarding() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      Map _body = {
        "country": "United Kingdom",
        "state": "England",
        "city": "City of London"
      };
      boardingModel = await APIServices.getBoardingAPI(_body);
      fetchAWS3Image(boardingModel?.obPosterDetail?[0].posterImage ?? '');
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<Uint8List?> fetchAWS3Image(String posterImage) async {
    const region = awsRegion;
    const bucketId = awsBucketId;
    final AwsS3Client s3client = awsS3client;
    // AwsS3Client(
    //     region: region,
    //     host: "s3.eu-west-2.amazonaws.com",
    //     bucketId: bucketId,
    //     accessKey: "AKIAQ4UXMACGEPN4A7EK",
    //     secretKey: "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");
    final listBucketResult = await s3client.listObjects(
        prefix: "Wystle/Admin/rider-app/on-boarding/login-flash",
        delimiter: "/");
    final response = await s3client.getObject(posterImage);
    setState(() {
      _base64 = response.bodyBytes;
      networkImage = MemoryImage(_base64);
    });
    return _base64;
  }

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
      log("Internet is connected");
    } else {
      InternetUtils.networkErrorDialog(context);
      log("Internet is not connected");
    }
  }

  ImageProvider? networkImage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    networkImage != null ? precacheImage(networkImage!, context) : null;
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
    enableLocation();
    // getLoc();
    _apiBoarding();
  }

  Future<void> enableLocation() async {
    location = Location();
    enabled = await location.serviceEnabled();

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
        _currentPosition!.longitude!.toDouble());
    location.onLocationChanged.listen((LocationData currentLocation) {
      log("${currentLocation.latitude} : ${currentLocation.longitude}");
      if(mounted)
      {

      setState(() {
        //
        latitude1 = currentLocation.latitude;
        longitude1 = currentLocation.longitude;
        SharedPreference.setValue(PrefConstants.LATITUDE, latitude1.toString());
        SharedPreference.setValue(PrefConstants.LATITUDE, latitude1.toString());
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
            _currentPosition!.longitude!.toDouble());

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstant.COLOR_WHITE,
      backgroundColor: boardingModel?.status == "true"
          ? boardingModel?.obPosterDetail![0].poster_bg_color != null
              ? Color(int?.tryParse(
                  "0xFF${boardingModel?.obPosterDetail?[0].poster_bg_color?.substring(1, boardingModel?.obPosterDetail?[0].poster_bg_color?.length)}")!)
              : const Color(0xFFF5F5F5)
          : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: boardingUI(context),
      ),
    );
  }

  Widget boardingUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 65, 15, 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            if (boardingModel?.status == "true" || isProgressRunning) ...{
              if (networkImage != null)
                //boardingModel?.obPosterDetail?[0].posterLabel != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    boardingModel?.obPosterDetail?[0].posterLabel ??
                        "On Ride App",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF424242),
                    ),
                  ),
                )
              else ...{
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  enabled: boardingModel?.status == "true",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.59,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              },
              const SizedBox(
                height: 80.0,
              ),
              if (networkImage != null) ...[
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: networkImage != null
                        ? DecorationImage(
                            image: networkImage!,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                // Image.memory(
                //   _base64,
                // height: 200,
                // width: 200,
                // ),
                // SvgPicture.memory(
                //   _base64,
                //   height: MediaQuery.of(context).size.height * 0.4,
                //   width: MediaQuery.of(context).size.width * 0.2,
                // ),
              ] else ...{
                Column(
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        // enabled: isProgressRunning,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          height: MediaQuery.of(context).size.height * 0.20,
                          // padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xffe9e7f1),
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: const Color(0xffe9e7f1),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffe9e7f1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              },

              // Label Show

              const SizedBox(
                height: 65,
              ),

              if (networkImage != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Text(
                    boardingModel?.obPosterDetail?[0].posterContent ??
                        "Secure your ride",
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 17,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),
                )
              else ...{
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const ShimmerEffectLineByLine(
                      width1: double.infinity,
                      height1: 17.0,
                    ),
                    const SizedBox(height: 10),
                    const ShimmerEffectLineByLine(
                      width1: double.infinity,
                      height1: 17.0,
                    ),
                    const SizedBox(height: 10),
                    const ShimmerEffectLineByLine(
                        width1: double.infinity, height1: 17.0),
                    const SizedBox(height: 10),
                    const ShimmerEffectLineByLine(
                      width1: double.infinity,
                      height1: 17.0,
                    ),
                    const SizedBox(height: 10),
                    const ShimmerEffectLineByLine(
                      width1: double.infinity,
                      height1: 17.0,
                    ),
                    const SizedBox(height: 10),
                    ShimmerEffectLineByLine(
                      width1: MediaQuery.of(context).size.width * 0.3,
                      height1: 17.0,
                    ),
                  ],
                )
              },

              if (networkImage != null) ...{
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MobileLoginScreen(
                                latitude1: latitude1,
                                longitude1: longitude1,
                              )),
                    );

                    // log("Latitude print $latitude1");
                    // log("longitude print ${longitude1.toString()}");
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 60, left: 12.0, right: 12),
                    child: MaterialButton1(
                      txt1: "Get Started",
                      height1: 56,
                      width1: double.infinity,
                    ),
                  ),
                ),
              } else ...{
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 12.0, right: 12),
                  child: ShimmerEffectLineByLine(
                  width1: MediaQuery.of(context).size.width,
                  height1: 56.0,
                ),
                ),
                
              }
            }

            //
            // else for Static UI
            //

            else ...{
              const Text(
                "On Ride",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF424242),
                ),
              ),

              const SizedBox(
                height: 60.0,
              ),

              SvgPicture.asset(
                ImgConstants.ONBOARDING1,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.2,
              ),

              // Label Show

              const SizedBox(
                height: 20,
              ),

              const Text(
                "Safety Riding",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Sofia",
                  fontSize: 16,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),

              // const Spacer(),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MobileLoginScreen(
                              latitude1: latitude1,
                              longitude1: longitude1,
                            )),
                  );
                  //    getLoc();
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 60, left: 12.0, right: 12),
                  child: MaterialButton1(
                    txt1: "Get Started",
                    height1: 56,
                    width1: double.infinity,
                  ),
                ),
              ),
            }
          ],
        ),
      ),
    );
  }

  getLoc() async {
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;

    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }

    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    _currentPosition = await location.getLocation();
    _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
        _currentPosition!.longitude!.toDouble());
    location.onLocationChanged.listen((LocationData currentLocation) {
      log("${currentLocation.latitude} : ${currentLocation.longitude}");

      setState(() {
        latitude1 = currentLocation.latitude;
        longitude1 = currentLocation.longitude;
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition!.latitude!.toDouble(),
            _currentPosition!.longitude!.toDouble());

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        // _getAddress(_currentPosition!.latitude!, _currentPosition!.longitude!)
        //     .then((value) {
        //   setState(() {
        //     _address = "${value.first.addressLine}";
        //   });
        // });
      });
    });
  }

  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = Coordinates(lat, lang);
  //   List<Address> add =
  //       await geocoding.Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return add;
  // }
}
