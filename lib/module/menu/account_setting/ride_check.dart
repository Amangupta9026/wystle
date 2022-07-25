import 'package:flutter/material.dart';

import '../../../constant/color_constant.dart';

class RideCheck extends StatefulWidget {
  const RideCheck({Key? key}) : super(key: key);

  @override
  State<RideCheck> createState() => _RideCheckState();
}

class _RideCheckState extends State<RideCheck> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_WHITE,
            size: 25,
          ),
        ),
        title: Text('RideCheck',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Whats's a RideCheck?",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                Text(
                    "In the case of an unexpected event, Wystle will initiate a RideCheck to ensure that you are safe. You can also request a RideCheck at any time.",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 10),
                Container(
                  color: ColorConstant.COLOR_WHITE,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('RideCheck Notifications',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500)),
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
                ),
                const SizedBox(height: 15),
                Text(
                    'When turned on, Wystle will send you a notification when a RideCheck notification if a trip doesnot progress as planned.',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
