import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:wystle/auth/onboarding.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/sharedpreference/shared_preference.dart';

import '../service/api_constants.dart';
import '../testing/location_custom.dart';
import '../utils/utils.dart';

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
    log("apk data fetch");
    myContext = context;
    _loadNextScreen();
    enableLocation();

    super.initState();
  }

  Future<void> enableLocation() async {
    location = Location();
    enabled = await location.serviceEnabled();
  }

  BuildContext? myContext;

  _loadNextScreen() async {
    if (!mounted) return;

    // if (await InternetUtils.internetCheck()) {
    
    if (!isDevOpEnabled) {

      // if (SharedPreference.getValue(PrefConstants.IS_LOGIN,
      //     defaultValue: false)) {
      //   Timer(Duration(seconds: 1), () async {
      //     var objCheckVersion = await APIServices.checkVersionUpdate(
      //       package_buildnumber,
      //     );
      // if (int.parse(_packageInfo.buildNumber) <
      //     int.parse(objCheckVersion.data.versionCode)) {

      // if (buildnumber < int.parse(objCheckVersion.data.versionCode)) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => APKDownloadPage(
      //         releasenote: objCheckVersion.data.releaseNotes,
      //         apkfile: objCheckVersion.data.apkFile,
      //         releasetitle: objCheckVersion.data.releaseTitle,
      //       ),
      //     ),
      //   );
      // } else {

      // Navigator.pushAndRemoveUntil<dynamic>(
      //   context,
      //   MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) => HomeScreen(),
      //   ),
      //   (route) => false,
      // );
      // }
      // }
      //  );
      var location = Location();
      bool enabled = await location.serviceEnabled();
      if (!enabled) {
        Timer(const Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const LocationCustom(),
            ),
            (route) => false,
          );
        });
      } else if (enabled) {
        log(" enable");
        // log(
        //   "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
        // );

        Timer(const Duration(seconds: 1), () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const OnBoarding(),
            ),
            (route) => false,
          );
        });
      }
    } else {
      // Timer(Duration(seconds: 3), () {
      //   Navigator.pushAndRemoveUntil<dynamic>(
      //     context,
      //     MaterialPageRoute<dynamic>(
      //       builder: (BuildContext context) => OnBoarding(),
      //     ),
      //     (route) => false,
      //   );
      // });
    }
    // }
    // else {
    //   InternetUtils.networkErrorDialog(context);
    // }
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
