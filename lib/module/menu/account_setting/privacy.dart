import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wystle/constant/image_constant.dart';

import '../../../constant/color_constant.dart';
import '../../../model/logout_model.dart';
import '../../../service/api_services.dart';
import '../../auth/onboarding.dart';
import '../../sharedpreference/shared_preference.dart';
import '../../sharedpreference/userdata.dart';
import 'location_privacy.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  final userdata = UserData.geUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorConstant.COLOR_BLACK,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15, 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            color: ColorConstant.COLOR_WHITE),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Edit Account',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(ImgConstants.PRIVACY_CENTER,
                                width:
                                    MediaQuery.of(context).size.width * 0.15),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Privacy Center',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Take control of your privacy and learn how we protect it.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      splashColor: ColorConstant.COLOR_LIGHT_GREY,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LocationPrivacy(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Location',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Update your location sharing preferences',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      splashColor: ColorConstant.COLOR_LIGHT_GREY,
                      onTap: () {
                        AppSettings.openNotificationSettings();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Notifications',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Control how you receive notifications',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Emergency Data Sharing',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Control how you receive notifications',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                        onTap: () async {
                          EasyLoading.show(status: 'loading...');
                          LogoutModel logoutModel =
                              await APIServices.getLogoutAPI(
                            userdata.userid!,
                          );
                          if (logoutModel.status == 'true') {
                            EasyLoading.dismiss();
                            SharedPreference.clearPrefs();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OnBoarding(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: Text(
                          'Sign out',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500),
                        ))
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
