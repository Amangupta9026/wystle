import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import '../module/sharedpreference/userdata.dart';

// ignore: must_be_immutable
class Rewards extends StatelessWidget {
  Rewards({Key? key}) : super(key: key);
  var userdata = UserData.geUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.COLOR_WHITE,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 20, 0, 20),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: ColorConstant.COLOR_BLACK,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 25, 20),
                    child: CircleAvatar(
                      backgroundColor: ColorConstant.COLOR_LIGHT_GREY2,
                      radius: 40,
                      child: Icon(
                        Icons.person,
                        size: 44,
                        color: ColorConstant.COLOR_ORIGINAL_GREY,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Text(
                userdata.firstname! +
                    ' ' +
                    userdata.lastname! +
                    ', You have earned',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorConstant.COLOR_BLACK,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '0 Wystle miles',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorConstant.COLOR_BLACK,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                height: 200,
              ),
              Container(
                width: double.infinity,
                height: 150,
                color: ColorConstant.THEME_COLOR_RED2,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                    child: Column(
                      children: [
                        Text(
                          'HOW TO EARN MORE WYSTLE MILES',
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.THEME_COLOR_RED,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'For every mile you with Wystle, you earn a Wystle Mile. Once you reach a set milestone by accumulating Wystle Miles, you will be rewarded with a coupon. This allows you to be eligible to ride with us in a luxurious category at a greater concession.',
                          textAlign: TextAlign.justify,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    color: ColorConstant.COLOR_BLACK,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.THEME_COLOR_RED),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Wystle will upgrade you to the next Car Category',
                              textAlign: TextAlign.justify,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_BLACK,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.THEME_COLOR_RED),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'The incentive will run for a period of 6-months starting from your first ride or reset once you have achieved the 250 Wystle milestone.',
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstant.THEME_COLOR_RED),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'For further information, please visit ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color: ColorConstant.COLOR_BLACK,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'http://wystle.co.uk/rider',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                              color:
                                                  ColorConstant.THEME_COLOR_RED,
                                              fontWeight: FontWeight.w400,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
