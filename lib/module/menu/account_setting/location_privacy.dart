import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wystle/module/homepage/homepage.dart';

import '../../../constant/color_constant.dart';
import '../../../widget/reusubility_button.dart';
import '../help.dart';
import 'helps_policy.dart';

class LocationPrivacy extends StatefulWidget {
  const LocationPrivacy({Key? key}) : super(key: key);

  @override
  State<LocationPrivacy> createState() => _LocationPrivacyState();
}

class _LocationPrivacyState extends State<LocationPrivacy> {
  bool isSwitched = false;
  var textValue = 'OFF';
  var location = Location();
  bool enabled = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'ON';
      });
      log('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'OFF';
      });
      log('Switch Button is OFF');
    }
  }

  @override
  void initState() {
    super.initState();
    // enableLocation();
    // Future.delayed(Duration.zero, () => refreshUi());
  }

  void refreshUi() async {
    enabled = await location.serviceEnabled();

    if (!enabled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage2()),
        //const OnBoarding()),
      );
    } else {
      log("sssssssffff");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorConstant.COLOR_BLACK,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            color: ColorConstant.COLOR_WHITE),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Edit Account',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Device Setting',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            )),
                    const SizedBox(height: 10),
                    InkWell(
                      splashColor: ColorConstant.COLOR_LIGHT_GREY,
                      onTap: () {
                        bottomSheetModalDown();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Location',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    )),
                            Row(
                              children: [
                                Text('On',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color:
                                              ColorConstant.COLOR_ORIGINAL_GREY,
                                          fontWeight: FontWeight.w500,
                                        )),
                                const SizedBox(width: 3),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 14, color: ColorConstant.COLOR_TEXT),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        "Wystle uses your device's location services for more reliable rides",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                              fontWeight: FontWeight.w500,
                            )),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HelpPolicy()),
                          //const OnBoarding()),
                        );
                      },
                      child: Text("Learn more",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstant.THEME_COLOR_RED,
                                    fontWeight: FontWeight.w500,
                                  )),
                    ),
                    const SizedBox(height: 15),
                    const Divider(
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                      thickness: 0.5,
                    ),
                    const SizedBox(height: 15),
                    Text("Sharing with Drivers",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Share Live Location (toggle)',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    )),
                        Transform.scale(
                            scale: 1,
                            child: Switch(
                                onChanged: toggleSwitch,
                                value: isSwitched,
                                activeColor: ColorConstant.COLOR_TEXT,
                                activeTrackColor: ColorConstant
                                    .COLOR_ORIGINAL_GREY
                                    .withOpacity(0.5),
                                inactiveThumbColor: ColorConstant.COLOR_TEXT,
                                inactiveTrackColor:
                                    ColorConstant.COLOR_LIGHT_GREY2)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                        "When this is on, drivers can see your live location to find you faster, from the time you request a ride to the start of your trip.",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                              fontWeight: FontWeight.w500,
                            )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Show BottomModal

  bottomSheetModalDown() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: const BoxDecoration(color: ColorConstant.COLOR_WHITE),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Turn off Location Sharing',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Go to your device settings for Wystlw and tap Permissions, then turn off location access.',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              AppSettings.openLocationSettings();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant.COLOR_BLACK),
                              ),
                              child: Text(
                                'OK',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const MaterialButton1(
                              height1: 46,
                              txt1: 'Cancel',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
