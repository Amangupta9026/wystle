import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/widget/appbar_widget.dart';
import '../../testing/gpay_payment.dart';
import 'add_card.dart';
import 'wallet_transaction.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWidget(
                  title: 'Wallet',
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WalletTransaction()),
                    );
                    // log('fff');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_WHITE,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.COLOR_ORIGINAL_GREY
                              .withOpacity(0.3),
                          offset: const Offset(0, 0),
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.description,
                            size: 22,
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Wallet Transactions',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          const Icon(
                            Icons.more_vert,
                            size: 22,
                            color: ColorConstant.COLOR_BLACK,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Wystle Cash

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FlutterWavePaymentGateway()),
                    );
                    // log('fff');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_WHITE,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.COLOR_ORIGINAL_GREY
                              .withOpacity(0.3),
                          offset: const Offset(0, 0),
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                      child: Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: ColorConstant.COLOR_BLACK),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '0.00',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wystle Cash',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Text(
                                  '1 coin = 1GBP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.help,
                            size: 26,
                            color: ColorConstant.THEME_COLOR_RED,
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Payments",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddCard()),
                    );
                    // log('fff');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_WHITE,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.COLOR_ORIGINAL_GREY
                              .withOpacity(0.3),
                          offset: const Offset(0, 0),
                          blurRadius: 3.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.credit_card,
                            size: 26,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Credit or Debit Card',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          const Icon(
                            Icons.add_circle,
                            size: 26,
                            color: ColorConstant.THEME_COLOR_RED,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
