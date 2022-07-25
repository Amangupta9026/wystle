import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:wystle/module/menu/personalization/personalization.dart';
import 'package:wystle/module/menu/profile.dart';
import 'package:wystle/module/menu/wallet.dart';
import '../../constant/color_constant.dart';
import '../../constant/image_constant.dart';
import '../sharedpreference/userdata.dart';
import 'account_setting/account_setting.dart';
import 'message.dart';

class MenuProfile extends StatelessWidget {
  final userdata = UserData.geUserData();
  MenuProfile({Key? key}) : super(key: key);

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
                const SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userdata.firstname ?? ''}"
                              " "
                              "${userdata.lastname ?? ''}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.merge(const TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ),
                            const SizedBox(height: 5),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      const Icon(
                                        Icons.star,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 5),
                                      Text("5.0",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              ?.copyWith(
                                                  color:
                                                      ColorConstant.COLOR_TEXT,
                                                  fontWeight: FontWeight.w600)),
                                    ])))
                          ]),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Profile(),
                                ));
                          },
                          child: Neumorphic(
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
                                    ))
                              ],
                            ),
                          ))
                    ]),
                const SizedBox(height: 20),
                Row(children: [
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorConstant.COLOR_LIGHT_DARK_GREY),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(children: [
                              const Icon(Icons.help_sharp),
                              const SizedBox(height: 7),
                              Text("Help",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w600)),
                            ]),
                          ))),
                  const SizedBox(width: 10),
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
                                    children: [
                                      const Icon(Icons.account_balance_wallet),
                                      const SizedBox(height: 7),
                                      Text("Wallet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(
                                                  color:
                                                      ColorConstant.COLOR_TEXT,
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ))))),
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
                            child: Column(children: [
                              const Icon(Icons.wallet_travel,
                                  color: ColorConstant.COLOR_BLACK),
                              const SizedBox(height: 7),
                              Text("Trips",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w600)),
                            ]),
                          )))
                ]),
                const SizedBox(height: 30),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Messages()));
                    },
                    child: Row(children: [
                      const Icon(Icons.message),
                      const SizedBox(width: 15),
                      Text("Message",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600))
                    ])),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(Icons.wallet_giftcard),
                    const SizedBox(width: 15),
                    Text("Send a gift",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 25),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountSetting(),
                          ));
                    },
                    child: Row(children: [
                      const Icon(Icons.settings),
                      const SizedBox(width: 15),
                      Text("Setting",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600))
                    ])),
                const SizedBox(height: 25),
                Row(
                  children: [
                    const Icon(Icons.privacy_tip_outlined),
                    const SizedBox(width: 15),
                    Text("Legal",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Personalization(),
                        ));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.settings_accessibility),
                      const SizedBox(width: 15),
                      Text("Personalization",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
