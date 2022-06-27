import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: ColorConstant.COLOR_BLACK,
          ),
        ),
        title: Text(
          "Account Setting",
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_BLACK,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                                color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                                shape: BoxShape.circle),
                            child: const Icon(Icons.person),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Aman Gupta",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "+919026888006",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "aman@k2ai",
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Faviorites Place",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.home),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Home",
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.work),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Add Work",
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Add New Address",
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ColorConstant.THEME_COLOR_RED,
                                    fontWeight: FontWeight.w600,
                                  )),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 15,
              ),

              // Trusted Contact

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trusted Contacts",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                              shape: BoxShape.circle),
                          child: const Icon(Icons.new_label_rounded),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Manage Trusted Contacts",
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Share your Trip status to your friends",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 15,
              ),

              // Safety

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Safety",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Control your safety setting, including your Ride Check Notifications",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),

              // Privacy

              const SizedBox(
                height: 15,
              ),

              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Privacy",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Manage the data you share with us",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),

              // Security

              const SizedBox(
                height: 15,
              ),

              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 15,
              ),

              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15, bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Security",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLACK,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Control your security setting with 2 step verification.",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_ORIGINAL_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
