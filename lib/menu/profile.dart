import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import 'edit_email.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFf9d915),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
            size: 28,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                const Icon(
                  Icons.help,
                  color: ColorConstant.COLOR_BLACK,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Support",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              bottom: 20,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Aman Gupta",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "+919026888006",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorConstant.COLOR_BLACK,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditEmail()),
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
                          color: Colors.blue,

                          // color: ColorConstant.COLOR_ORIGINAL_GREY,
                        ),
                        child: const Icon(
                          Icons.email,
                          size: 18,
                          color: ColorConstant.COLOR_WHITE,
                        )),
                  ]),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'aman@k2ai.com',
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 20,
                        color: ColorConstant.COLOR_WHITE,
                      )),
                ]),
                const SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gender',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Male',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Column(children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.THEME_COLOR_RED2,
                      ),
                      child: const Icon(
                        Icons.lock_clock_outlined,
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
                      'Logout',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
