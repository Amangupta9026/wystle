import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../constant/color_constant.dart';
import '../constant/image_constant.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
          ),
        ),
        title: Text(
          "Share & Earn",
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_BLACK,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: ColorConstant.THEME_COLOR_RED,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    ImgConstants.REFER_EARN,
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, bottom: 20, left: 25, right: 25),
                    child: Text(
                      "Refer to your friend and Get 1 Ride Free.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Text(
                      "Invite your friends with referral code wys21512.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, bottom: 15),
              child: Text(
                "Referral Code:",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstant.COLOR_BLACK,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, // background
                  onPrimary: ColorConstant.COLOR_TEXT, // foreground
                ),
                onPressed: () async {
                  Clipboard.setData(const ClipboardData(text: "wys21512"))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Copied to your clipboard !')));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      Center(
                        child: Text(
                          "wys21512",
                          //  "${SharedPreference.getValue(PrefConstants.USER_REFERAL)}",
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.copy,
                        color: ColorConstant.COLOR_WHITE,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                    child: Text(
                      "How does it work?",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),

                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(ImgConstants.REFER_EARN2),
                    ),
                    title: Text(
                      "Invite Your Friends",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "Just Share your referral code",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage(ImgConstants.CAR_ICON),
                    ),
                    title: Text(
                      "1 Ride Free",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "Refer your friends and get 1 ride free",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  //Earn

                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage(ImgConstants.HOME_PAGE_PROMO_ICON),
                    ),
                    title: Text(
                      "Bonus",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "Bonus for referral",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  InkWell(
                    onTap: () async {
                      await Share.share(
                          "Register on Wystle application with referral code wys21512 and get 1 Ride Free upto \$1. \n Click on https://play.google.com/store/apps/details?id=com.wystle.wystleapp",
                          subject: "Refer and Earn on Wystle");
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      width: double.infinity,
                      color: ColorConstant.COLOR_LIGHT_GREEN,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          "REFER FRIENDS",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
