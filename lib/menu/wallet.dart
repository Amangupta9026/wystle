import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
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
            size: 24,
          ),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorConstant.COLOR_BLACK),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Uber Cash",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.COLOR_BLACK),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Rs. 0.00",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.COLOR_BLACK),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,

                          //   width: 100,
                          decoration: BoxDecoration(
                              color: ColorConstant.COLOR_BLACK,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10, bottom: 10),
                            child: Row(children: const [
                              Icon(Icons.add, color: ColorConstant.COLOR_WHITE),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Gift Card",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.COLOR_WHITE)),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Send a gift",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.COLOR_BLACK),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "You can send a gift to your friends",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.COLOR_BLACK),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.28,

                          //   width: 100,
                          decoration: BoxDecoration(
                              color: ColorConstant.COLOR_BLACK,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12.0, right: 12, top: 12, bottom: 12),
                            child: Text("Send a gift",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.COLOR_WHITE)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ride Profile",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.COLOR_BLACK),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                          shape: BoxShape.circle),
                      child: Icon(Icons.person),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("Personal",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.COLOR_BLACK)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                          shape: BoxShape.circle),
                      child: Icon(Icons.work),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: const [
                        Text("Start using Wystle for business",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.COLOR_BLACK)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Turn on business travel features",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.COLOR_ORIGINAL_GREY)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Vouchers",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.COLOR_BLACK),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                          shape: BoxShape.circle),
                      child: Icon(Icons.redeem),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("Vouchers",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.COLOR_BLACK)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Promotions",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.COLOR_BLACK),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                          shape: BoxShape.circle),
                      child: Icon(Icons.new_label_rounded),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text("Promotions",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.COLOR_BLACK)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
