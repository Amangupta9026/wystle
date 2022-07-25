import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wystle/module/menu/account_setting/safety_setting.dart';
import '../../../constant/color_constant.dart';
import '../../../constant/image_constant.dart';
import '../../sharedpreference/userdata.dart';
import 'privacy.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final userdata = UserData.geUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: ColorConstant.COLOR_WHITE,
            size: 25,
          ),
        ),
        title: Text('Account Setting',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5, 15, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
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
                                vertical: 15, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    ImgConstants.PERSON_ICON,
                                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
                            "${userdata.firstname ?? ''}"
                            " "
                            "${userdata.lastname ?? ''}",
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            userdata.mobileno ?? '',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          Text(
                            userdata.email ?? '',
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
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
                height: 10,
              ),
              const Divider(
                color: ColorConstant.COLOR_TEXT,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Faviorites Place",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 15),
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
                        const SizedBox(width: 10),
                        Text("Add Home",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w300))
                      ],
                    ),
                    const SizedBox(height: 15),
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
                          width: 10,
                        ),
                        Text("Add Work",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w300,
                                    ))
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text("Add New Address",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstant.THEME_COLOR_RED,
                                    fontWeight: FontWeight.w500,
                                  )),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              const Divider(color: ColorConstant.COLOR_TEXT, thickness: 0.3),

              const SizedBox(height: 15),

              // Trusted Contact

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trusted Contacts",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
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
                        const SizedBox(width: 10),
                        Text("Manage Trusted Contacts",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Share your Trip status to your friends",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Divider(color: ColorConstant.COLOR_BLACK, thickness: 0.3),

              const SizedBox(height: 10),

              // Safety

              InkWell(
                splashColor: ColorConstant.COLOR_LIGHT_GREY,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SafetySetting(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Safety",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Control your safety setting, including your Ride Check Notifications",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              // Privacy

              const SizedBox(
                height: 10,
              ),

              const Divider(
                color: ColorConstant.COLOR_BLACK,
                thickness: 0.3,
              ),

              const SizedBox(
                height: 10,
              ),

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Privacy(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Manage the data you share with us",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
