import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wystle/auth/onboarding.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/module/sharedpreference/shared_preference.dart';

import '../service/api_constants.dart';
import '../testing/location_custom.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isDevOpEnabled = false;
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

  // BuildContext? myContext;

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
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const HomePage2(),
              ),
              (route) => false,
            );
          }
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) => const OnBoarding(),
              ),
              (route) => false,
            );
          }
        });
      }
    
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
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

  @override
  void dispose() {
    super.dispose();
  }
}
