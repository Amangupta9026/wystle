import 'package:flutter/material.dart';
import '../module/auth/mobile_loginscreen.dart';
import '../module/auth/onboarding.dart';
import '../module/splash_screen.dart';

Route generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutePath.initRoutePath:
      return MaterialPageRoute(builder: (context) => const SplashPage());
  

    case RoutePath.onBoardingRoutePath:
      return MaterialPageRoute(builder: (context) => const OnBoarding());
      

    case RoutePath.loginRoutePath:
      return MaterialPageRoute(builder: (context) => const MobileLoginScreen());

    default:
      return MaterialPageRoute(builder: (context) => const OnBoarding());
    //My11ChoiceSplashPage());
  }
}

class RoutePath {
  static const String initRoutePath = "/";
  static const String onBoardingRoutePath = "onBoarding";
  static const String loginRoutePath = "login";
}
