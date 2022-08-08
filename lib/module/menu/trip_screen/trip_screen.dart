import 'package:flutter/material.dart';
import 'package:wystle/module/menu/trip_screen/trip_details.dart';

import '../../../constant/color_constant.dart';
import '../../../map/homescreen_map.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
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
          title: Text('Choose a Trip',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorConstant.COLOR_WHITE,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 40.0),
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    InkWell(
                      splashColor: ColorConstant.COLOR_LIGHT_GREY,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TripDetails()),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('4/2/22, 10:00 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w400,
                                        )),
                                Row(
                                  children: [
                                    Text('£45.02',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w400,
                                            )),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.arrow_forward_ios,
                                        size: 14),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('CASH ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color:
                                              ColorConstant.COLOR_ORIGINAL_GREY,
                                          fontWeight: FontWeight.w400,
                                        )),
                                const SizedBox(width: 5),
                                Text('Driver Cancelled',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w400,
                                        ))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                              child: HomeScreenMap()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              }),
        )));
  }
}
