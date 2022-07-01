import 'package:flutter/material.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/menu/help.dart';
import 'package:wystle/menu/message.dart';
import 'package:wystle/menu/refer_earn.dart';
import 'package:wystle/menu/rewards.dart';
import 'package:wystle/menu/wallet.dart';

import '../../constant/color_constant.dart';
import '../../menu/coupon_screen.dart';
import '../../menu/menu_profile.dart';
import '../../menu/notifications.dart';
import '../../menu/profile.dart';
import '../sharedpreference/userdata.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var userdata = UserData.geUserData();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // height: MediaQuery.of(context).padding.top,
            color: ColorConstant.COLOR_WHITE,
          ),
          const Divider(thickness: 0.5),
          Expanded(
            child: Container(
              color: ColorConstant.COLOR_WHITE,
              //Theme.of(context).appBarTheme.color.withOpacity(0.7),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 15, top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
                            );
                          },
                          child: Row(
                            children: [
                              Column(children: [
                                Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: ColorConstant
                                                .COLOR_ORIGINAL_GREY)
                                        // color: ColorConstant.COLOR_ORIGINAL_GREY,
                                        ),
                                    child: const Icon(
                                      Icons.person,
                                      color: ColorConstant.COLOR_BLACK,
                                    )),
                              ]),
                              const SizedBox(
                                width: 13,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userdata.firstname! +
                                        ' ' +
                                        userdata.lastname!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLACK,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    userdata.mobileno!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLACK,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: ColorConstant.COLOR_ORIGINAL_GREY,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customRow(
                        "Profile",

                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,

                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // customRow(
                      //   "Your Rides",
                      //   Image.asset(ImgConstants.CONTRACT_ICON,
                      //       width: 28.0, height: 28.0),
                      //   // FontAwesomeIcons.moon,
                      //   () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const MenuProfile(),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      customRow(
                        "Wallet",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Wallet(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow2(
                        "Offers",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        "3 offers available",
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Messages(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Notifications",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Notifications(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Refer & Earn",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReferEarn(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Support",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuProfile(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "About",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuProfile(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Help",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Coupon",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CouponScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      customRow(
                        "Rewards",
                        Image.asset(ImgConstants.CONTRACT_ICON,
                            width: 28.0, height: 28.0),
                        // FontAwesomeIcons.moon,
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Rewards(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customRow(String txt, Image icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            //   Icon(icon, color: Theme.of(context).textTheme.headline6.color),
            const SizedBox(
              width: 20,
            ),
            Text(
              txt,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorConstant.COLOR_BLACK,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow2(String txt, Image icon, String txt2, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            //   Icon(icon, color: Theme.of(context).textTheme.headline6.color),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                txt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.COLOR_BLACK,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorConstant.COLOR_LIGHT_GREEN,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 3, bottom: 3, left: 5.0, right: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.discount,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      txt2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.COLOR_BLACK,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
