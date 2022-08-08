import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/module/sharedpreference/shared_preference.dart';

import '../service/api_constants.dart';
import '../widget/location_custom.dart';
import 'auth/onboarding.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var location = Location();
  bool enabled = false;

  @override
  void initState() {
    _loadNextScreen();
    enableLocation();

    super.initState();
  }

  Future<void> enableLocation() async {
    location = Location();
    enabled = await location.serviceEnabled();
  }

  _loadNextScreen() async {
    if (!mounted) return;

    if (SharedPreference.getValue(PrefConstants.IS_LOGIN,
        defaultValue: false)) {
      Timer(const Duration(seconds: 1), () async {
        var location = Location();
        bool enabled = await location.serviceEnabled();
        if (!enabled) {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const LocationCustom(),
            ),
            (route) => false,
          );
        } else {
          if(mounted){
             Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const HomePage2(),
              ),
              (route) => false,
            );
          }
         
        }
      });
    } else {

      Timer(const Duration(seconds: 3), () async {
        var location = Location();
        bool enabled = await location.serviceEnabled();
        if (!enabled) {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const LocationCustom(),
            ),
            (route) => false,
          );
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const OnBoarding(),
              ),
              (route) => false,
            );
          }
        }
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: ColorConstant.COLOR_BLACK,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Image.asset(
                ImgConstants.SPLASH_ICON2,
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                color: ColorConstant.THEME_COLOR_RED,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
