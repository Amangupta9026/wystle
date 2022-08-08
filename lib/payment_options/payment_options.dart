import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../constant/color_constant.dart';
import 'add_voucher_code.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({Key? key}) : super(key: key);

  @override
  State<PaymentOptions> createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  bool isSwitched = false;
  bool isSelectedCard = false;
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      if (mounted) {
        setState(() {
          isSwitched = true;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          isSwitched = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_LIGHT_BLACK,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Payment Options',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(
                      child: MaterialButton1(
                        icon1: Icon(Icons.person),
                        txt1: 'Personal',
                        height1: 44,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: MaterialButton1(
                        height1: 44,
                        icon1: Icon(Icons.person),
                        txt1: 'Business',
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Wystle Cash',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_LIGHT_BLACK,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text('Wystle',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wystle Cash',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400)),
                        Text('Rs 0.00',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
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
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text('Payment Method',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 10),
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  // if (mounted) {
                  //   setState(() {
                  //     isSelectedCard = true;
                  //   });
                  // }
                },
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_BLACK,
                    ),
                    padding: const EdgeInsets.fromLTRB(11, 5, 11, 5),
                    child: Text('VISA',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('**** 5654',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400)),
                  ),
                  Visibility(
                      child: const Icon(
                        Icons.check,
                        size: 15,
                      ),
                      visible: isSelectedCard),
                ]),
              ),
              const SizedBox(height: 20),
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  // if (mounted) {
                  //   setState(() {
                  //     isSelectedCard = false;
                  //   });
                  // }
                },
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_BLACK,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Text('Rupay',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('**** 7154',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400)),
                  ),
                  Visibility(
                      child: const Icon(
                        Icons.check,
                        size: 15,
                      ),
                      visible: isSelectedCard),
                ]),
              ),
              const SizedBox(height: 20),
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  // if (mounted) {
                  //   setState(() {
                  //     isSelectedCard = false;
                  //   });
                  // }
                },
                child: Row(children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_BLACK,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Text('Paytm',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('**** 3254',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400)),
                  ),
                  Visibility(
                      child: const Icon(
                        Icons.check,
                        size: 15,
                      ),
                      visible: isSelectedCard),
                ]),
              ),
              const SizedBox(height: 20),
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  // if (mounted) {
                  //   setState(() {
                  //     isSelectedCard = false;
                  //   });
                  // }
                },
                child: Row(children: [
                  const Icon(
                    Icons.payments_rounded,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Cash',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                      child: const Icon(
                        Icons.check,
                        size: 15,
                      ),
                      visible: isSelectedCard),
                ]),
              ),
              const SizedBox(height: 30),
              Text('Add Payment Method',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstant.THEME_COLOR_RED,
                      fontWeight: FontWeight.w300)),
              const SizedBox(height: 20),
              Text('Vouchers',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 10),
              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddVoucherCode(),
                    ),
                  );
                },
                child: Text('Add voucher code',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstant.THEME_COLOR_RED,
                        fontWeight: FontWeight.w300)),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
