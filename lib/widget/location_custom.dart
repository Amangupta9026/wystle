import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../module/auth/onboarding.dart';

class LocationCustom extends StatefulWidget {
  final Widget? screenname;
  const LocationCustom({Key? key, this.screenname}) : super(key: key);

  @override
  State<LocationCustom> createState() => _LocationCustomState();
}

class _LocationCustomState extends State<LocationCustom> {
  var location = Location();

  @override
  void initState() {
    super.initState();
    refreshUi();
  }

  void refreshUi() async {
    bool enabled = await location.serviceEnabled();

    if (enabled) {
      // widget.screenname ?? const OnBoarding();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.screenname ?? const OnBoarding()),
        //const OnBoarding()),
      );
    } else {
      refreshUi();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => showAlertDialog(context));
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: const [],
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Go to Setting"),
      onPressed: () async {
        var location = Location();
        bool enabled = await location.serviceEnabled();

        if (!enabled) {
          AppSettings.openLocationSettings();
          // Navigator.pop(context);
        }
        //  else
        if (enabled) {
          log(" enable");
          // log(
          //   "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
          // );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnBoarding()),
          );
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: const Text(
          'Allow "Wystle" to access your location even when you are not using app?'),
      actions: [
        cancelButton,
        continueButton,
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
}
