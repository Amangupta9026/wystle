import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wystle/module/menu/trip_screen/receipt_screen.dart';
import 'package:wystle/module/menu/trip_screen/support_trip/support.dart';

import '../../../constant/color_constant.dart';
import '../../../constant/image_constant.dart';
import '../../../map/homescreen_map.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key}) : super(key: key);

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.COLOR_LIGHT_GREY.withOpacity(0.6),
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
          title: Text('Trip Details',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: ColorConstant.COLOR_WHITE,
                  fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: HomeScreenMap()),
              const SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 80.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('4/2/22. 10:00 AM',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  )),
                          Text('£45.02',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('CASH ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w400,
                                  )),
                          const SizedBox(width: 5),
                          Text('Driver Cancelled',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w300,
                                  ))
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 7,
                                          width: 7,
                                          decoration: const BoxDecoration(
                                              color: ColorConstant
                                                  .COLOR_LIGHT_BLACK,
                                              shape: BoxShape.circle),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                              'Railway Station Rd, London, United Kingdom',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                    color: ColorConstant
                                                        .COLOR_TEXT,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 7,
                                          width: 7,
                                          decoration: const BoxDecoration(
                                              color: ColorConstant
                                                  .COLOR_LIGHT_BLACK,
                                              shape: BoxShape.rectangle),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                              'Railway Station Rd, London, United Kingdom',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  ?.copyWith(
                                                    color: ColorConstant
                                                        .COLOR_TEXT,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Receipt()),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('Receipt',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                color: ColorConstant.COLOR_TEXT,
                                                fontWeight: FontWeight.w400,
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorConstant.COLOR_ORIGINAL_GREY
                                  .withOpacity(0.4)),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 13.0, 15.0, 13.0),
                          child: Row(
                            children: [
                              Neumorphic(
                                style: NeumorphicStyle(
                                  shadowLightColor: Colors.white,
                                  color: const Color(0xffebecf0),
                                  intensity: .6,
                                  surfaceIntensity: .4,
                                  depth: NeumorphicTheme.embossDepth(context),
                                  boxShape: const NeumorphicBoxShape.circle(),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          ImgConstants.PERSON_ICON,
                                          color:
                                              ColorConstant.COLOR_ORIGINAL_GREY,
                                        ))
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text('Your ride with Alok Mani',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImgConstants.HOME_PAGE_PROMO_ICON,
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Support()),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Find Lost item',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                color: ColorConstant.COLOR_TEXT,
                                                fontWeight: FontWeight.w500,
                                              )),
                                      const SizedBox(height: 5),
                                      Text(
                                          'We can help you get in touch with your driver',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                color: ColorConstant.COLOR_TEXT,
                                                fontWeight: FontWeight.w400,
                                              )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImgConstants.HOME_PAGE_PROMO_ICON,
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Report Safety Issue',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            )),
                                    const SizedBox(height: 5),
                                    Text(
                                        'Let us know if you have any safety related issue',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w400,
                                            )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImgConstants.HOME_PAGE_PROMO_ICON,
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Provide Driver Feedback',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            )),
                                    const SizedBox(height: 5),
                                    Text(
                                        "For issues that aren't safety related",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w400,
                                            )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    ImgConstants.HOME_PAGE_PROMO_ICON,
                                    height: 40,
                                    width: 40,
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Get Trip Help',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            )),
                                    const SizedBox(height: 5),
                                    Text(
                                        'Need help for something else? Find it here',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w400,
                                            )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        )));
  }
}
