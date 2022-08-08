import 'dart:developer';
import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../model/otpverify_model.dart';
import '../../service/api_constants.dart';
import '../../service/api_services.dart';
import '../../utils/utils.dart';
import '../../widget/toast_widget.dart';
import '../sharedpreference/shared_preference.dart';
import 'otp_screen.dart';

class MobileLoginScreen extends StatefulWidget {
  final double? latitude1;
  final double? longitude1;
  const MobileLoginScreen({Key? key, this.latitude1, this.longitude1})
      : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  TextEditingController? mobileController = TextEditingController();
  bool isOnline = false;

  bool isProgressRunning = false;
  OTPVerifyModel? otpVerifyModel;

  String deviceName = '',
      deviceVersion = '',
      identifier = '',
      brand = '',
      deviceManufacturing = '';
  String? getAddress = '', location = '';
  String? countryName, countryCode;

  @override
  void initState() {
    super.initState();
    checkInternet();
    _deviceDetails();
    getCurrentAddress();
    mobileController = TextEditingController();
  }

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
    } else {
      InternetUtils.networkErrorDialog(context);
    }
  }

  // Device Details

  Future<void> _deviceDetails() async {
    final ipv4 = await Ipify.ipv4();
    SharedPreference.setValue(PrefConstants.IP_ADDRESS, ipv4);

    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        if (mounted) {
          setState(() {
            deviceName = build.model ?? '';
            deviceVersion = build.version.release.toString();
            identifier = build.androidId ?? '';
            brand = build.brand ?? '';
            deviceManufacturing = build.manufacturer ?? '';
          });
        }
        SharedPreference.setValue(PrefConstants.DEVICE_NAME, deviceName);
        SharedPreference.setValue(PrefConstants.DEVICE_VERSION, deviceVersion);
        SharedPreference.setValue(PrefConstants.DEVICE_ID, identifier);
        SharedPreference.setValue(PrefConstants.DEVICE_BRAND, brand);

        SharedPreference.setValue(
            PrefConstants.DEVICE_MANUFACTURING, deviceManufacturing);

        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        if (mounted) {
          setState(() {
            deviceName = data.name ?? '';
            deviceVersion = data.systemVersion ?? '';
            identifier = data.identifierForVendor ?? '';
          }); //UUID for iOS
        }
        SharedPreference.setValue(PrefConstants.DEVICE_NAME, deviceName);
        SharedPreference.setValue(PrefConstants.DEVICE_VERSION, deviceVersion);
        SharedPreference.setValue(PrefConstants.DEVICE_ID, identifier);
        SharedPreference.setValue(PrefConstants.DEVICE_BRAND, brand);
      }
    } on PlatformException {
      log('Failed to get platform version');
    }
  }

  Future<void> getCurrentAddress() async {
    Position position = await _getGeoLocationPosition();
    location = '${position.latitude}:${position.longitude}';
    // GetAddressFromLatLong(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    getAddress =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
    SharedPreference.setValue(PrefConstants.USER_CURRENT_STREET, place.street);
    SharedPreference.setValue(
        PrefConstants.USER_CURRENT_SUBLOCALITY, place.subLocality);
    SharedPreference.setValue(PrefConstants.USER_CITY, place.locality);
    SharedPreference.setValue(PrefConstants.USER_COUNTRY, place.country);
    // log('street ${place.street}');

    countryName = place.country;
    getcountryWiseCode();

    // log(location);
  }

  void getcountryWiseCode() {
    if (countryName == 'United Kingdom') {
      countryCode = '+44';
    } else if (countryName == 'United States') {
      countryCode = '+1';
    } else if (countryName == 'India') {
      countryCode = '+91';
    } else if (countryName == 'New Zealand') {
      countryCode = '+64';
    } else if (countryName == 'Iraq') {
      countryCode = '+964';
    }

    mobileController!.text = countryCode! + mobileController!.text;
  }

  // Dispose
  @override
  void dispose() {
    try {
      mobileController!.dispose();
    } catch (e) {
      log(e.toString(), name: 'mobileController');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.BACKGROUND_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.9, 20.0),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.9, 20.0),
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        ImgConstants.BACKGROUNG_IMAGE,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 250, 25, 60), //200
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.COLOR_WHITE,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: Text(
                                "Enter your mobile number",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Text(
                              "We will send you confirmation code",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),

                            const SizedBox(height: 20),

                            TextFieldWithOnlyPlaceHolder(
                              text1: '',
                              controller1: mobileController,
                            ),

                            // Button for Next Screen Navigation
                            InkWell(
                              onTap: () async {
                                if (mobileController!.text.length <= 12) {
                                  toastshowDefaultSnackbar(context,
                                      'Please enter valid mobile number');
                                } else {
                                  EasyLoading.show(status: 'loading...');
                                  OTPVerifyModel sendOTPVerifyModel =
                                      await APIServices.getOTPVerifyAPI(
                                          mobileController!.text);
                                  if (sendOTPVerifyModel.status == 'true') {
                                    EasyLoading.dismiss();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OTPScreen(
                                                  sendOTPVerifyModel:
                                                      sendOTPVerifyModel,
                                                  mobileNumber:
                                                      mobileController!.text,
                                                )));
                                  } else {
                                    EasyLoading.dismiss();
                                    toastshowDefaultSnackbar(
                                        context, 'Please try again');
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    top: 40, left: 0.0, right: 0),
                                child: MaterialButton1(
                                  txt1: "NEXT",
                                  height1: 56,
                                  width1: double.infinity,
                                  // color1: ColorConstant.COLOR_LIGHT_BLACK,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By creating passcode you agree with our ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Condition',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLUE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLUE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      // content: const Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
