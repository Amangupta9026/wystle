import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../../constant/color_constant.dart';
import 'feedback.dart';

class HelpPolicy extends StatefulWidget {
  const HelpPolicy({Key? key}) : super(key: key);

  @override
  State<HelpPolicy> createState() => _HelpPolicyState();
}

class _HelpPolicyState extends State<HelpPolicy> {
  bool visible = false;
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
              Icons.close,
              color: ColorConstant.COLOR_WHITE,
              size: 25,
            ),
          ),
          title: Text('Help',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorConstant.COLOR_WHITE,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 80),
                  child: Column(
                    children: [
                      Text(
                          'How Wystle uses rider location information (Android)',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(height: 30),
                      Text(
                          "You'll see a request prompted by your device for permission to access your location information when you sign up for Wystle, when includes location data collected via bluetooth and nearby Wi-Fi signnals.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      Text('Sharing with cities and governments',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      Text(
                          "In some instances, we're required to share information about the trips taken on our service with cities, governments and local transportation authorities. This information is used to help us improve our service and to ensure that our riders are safe and secure. \n \nTo meet these requirements, we collect geolocation data from your device when you use Wystle. We use this data to determine the location of your device and to help us determine the location of your trip. We also use this data to determine the location of your trip when you use the Wystle app. \n \nWe do not share this data with any other party. \n \nThis data provides cities with information on where each trip starts, stops and the route taken on the trip. None of the trip data we provide to cities is collected from your personal mobile device or directly identifies you. \n\nWe treat your location information in accordance with our Privacy Policy.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500)),
                      const SizedBox(height: 20),
                      Text('Can we help with anything else?',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: !visible,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const MaterialButton1(
                                  txt1: 'Yes',
                                  textColor1: ColorConstant.COLOR_TEXT,
                                  height1: 46,
                                  width1: double.infinity,
                                  color1: ColorConstant.COLOR_LIGHT_GREY),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  visible = true;
                                });
                              },
                              child: const MaterialButton1(
                                  txt1: 'No',
                                  textColor1: ColorConstant.COLOR_TEXT,
                                  height1: 46,
                                  width1: double.infinity,
                                  color1: ColorConstant.COLOR_LIGHT_GREY),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Visibility(
                        visible: visible,
                        child: Column(
                          children: [
                            Text(
                              "How satisified are you with the support you received?",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const FeedBack()),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.mood_bad,
                                    size: 50,
                                  ),
                                ),
                                const Icon(
                                  Icons.sentiment_dissatisfied_outlined,
                                  size: 50,
                                ),
                                const Icon(
                                  Icons.sentiment_dissatisfied,
                                  size: 50,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.sentiment_satisfied,
                                    size: 50,
                                  ),
                                ),
                                const Icon(
                                  Icons.sentiment_very_satisfied,
                                  size: 50,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
