import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class InternetUtils {
  static Future<bool> internetCheck() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static networkErrorDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(
            "Oops!",
            style: TextStyle(
                color: ColorConstant.THEME_COLOR_RED,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
          content: const Text(
            "Please check your internet connection",
            style: TextStyle(
                color: ColorConstant.THEME_COLOR_RED,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            InkWell(
              child: const Text(
                "OK",
                style: TextStyle(
                    color: ColorConstant.THEME_COLOR_RED,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}