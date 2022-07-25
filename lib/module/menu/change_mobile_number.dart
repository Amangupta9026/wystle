import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/color_constant.dart';
import '../../service/api_constants.dart';
import '../../widget/reusubility_button.dart';
import '../sharedpreference/shared_preference.dart';

class ChangeMobileNumber extends StatefulWidget {
  const ChangeMobileNumber({Key? key}) : super(key: key);

  @override
  State<ChangeMobileNumber> createState() => _ChangeMobileNumberState();
}

class _ChangeMobileNumberState extends State<ChangeMobileNumber> {
  String? countryName, countryCode;
  String? getAddress = '', location = '';
  TextEditingController? mobileController = TextEditingController();

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
    if (mounted) {
      setState(() {});
    }
    SharedPreference.setValue(PrefConstants.USER_CURRENT_STREET, place.street);
    SharedPreference.setValue(
        PrefConstants.USER_CURRENT_SUBLOCALITY, place.subLocality);
    SharedPreference.setValue(PrefConstants.USER_CITY, place.locality);
    SharedPreference.setValue(PrefConstants.USER_COUNTRY, place.country);

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

  @override
  void initState() {
    super.initState();
    getCurrentAddress();
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
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Phone',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 20),
              if (mobileController!.text.isEmpty) ...{
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                      ),
                      // );
                      // }
                    ),
                  ),
                ),
              } else ...{
                TextFieldWithOnlyPlaceHolder(
                  text1: '',
                  controller1: mobileController,
                ),
              },
              const SizedBox(height: 30),
              const MaterialButton1(
                txt1: 'Save',
                height1: 50,
                width1: double.infinity,
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
