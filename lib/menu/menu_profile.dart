import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/menu/account_setting.dart';
import 'package:wystle/menu/message.dart';
import 'package:wystle/menu/wallet.dart';

class MenuProfile extends StatelessWidget {
  const MenuProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Aman Gupta",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.COLOR_BLACK,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "5.0",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstant.COLOR_BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.person,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: const [
                              Icon(Icons.help_sharp),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Help",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Wallet(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: const [
                                Icon(Icons.account_balance_wallet),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "Wallet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: const [
                              Icon(Icons.wallet_travel,
                                  color: ColorConstant.COLOR_BLACK),
                              SizedBox(
                                height: 7,
                              ),
                              Text(
                                "Trips",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Messages()),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.message),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Message",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Icon(Icons.wallet_giftcard),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Send a gift",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountSetting(),
                      ),
                    );
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.settings),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Setting",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Icon(Icons.person),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Drive or Deliver with wystle",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Icon(Icons.privacy_tip_outlined),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Legal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
