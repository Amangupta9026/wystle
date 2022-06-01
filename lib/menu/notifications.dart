import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import '../widget/reusubility_button.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
                      "Notifications",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorConstant.COLOR_WHITE,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.COLOR_BLACK.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 10),
                child: Row(
                  children: [
                    Column(children: [
                      Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFfeb283),

                            // color: ColorConstant.COLOR_ORIGINAL_GREY,
                          ),
                          child: const Icon(
                            Icons.notifications,
                            color: ColorConstant.COLOR_WHITE,
                          )),
                    ]),
                    const SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Refer your freinds',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Dear user, you can refer your friends to earn more money',
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
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
