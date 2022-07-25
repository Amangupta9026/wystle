import 'dart:developer';
import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/color_constant.dart';
import '../../constant/image_constant.dart';
import '../../model/verify_registry_model.dart';
import '../../service/api_constants.dart';
import '../../widget/reusubility_button.dart';
import '../sharedpreference/shared_preference.dart';
import '../sharedpreference/userdata.dart';
import 'change_mobile_number.dart';
import 'email_verify_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userdata = UserData.geUserData();
  VerifyRegisterModel? verifyRegisterModel;
  TextEditingController verificationCodeController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? image1;

  @override
  void dispose() {
    try {
      verificationCodeController.dispose();
    } catch (e) {
      log(e.toString(), name: 'Profile');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
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
                            child: const Icon(
                              Icons.arrow_back,
                              color: ColorConstant.COLOR_WHITE,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Edit Account',
                            style:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            bottomSheetModalDown();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      vertical: 20, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          color:
                                              ColorConstant.COLOR_ORIGINAL_GREY,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          thickness: 0.7,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            bottomSheetModalDown();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  userdata.firstname ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            bottomSheetModalDown();
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  userdata.lastname ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangeMobileNumber()),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  userdata.mobileno ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EmailVerifyScreen()),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Email',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color:
                                              ColorConstant.COLOR_ORIGINAL_GREY,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  if (SharedPreference.getValue(PrefConstants
                                          .USER_EMAIL_VERIFY_TAG) ==
                                      'done') ...{
                                    Row(
                                      children: [
                                        Text('Verified',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(
                                                  color:
                                                      ColorConstant.COLOR_BLUE,
                                                  fontWeight: FontWeight.w900,
                                                )),
                                        const SizedBox(width: 5),
                                        const Icon(Icons.check_circle,
                                            color: ColorConstant.COLOR_BLUE,
                                            size: 20)
                                      ],
                                    ),
                                  } else ...{
                                    Text('Unverfied',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                              color:
                                                  ColorConstant.THEME_COLOR_RED,
                                              fontWeight: FontWeight.w900,
                                            )),
                                  }
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                userdata.email ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show BottomModal

  bottomSheetModalDown() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(color: ColorConstant.COLOR_WHITE),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Contact support to edit this field',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Contact us if you want to update the photo',
                    style: Theme.of(context).textTheme.subtitle2?.copyWith(
                          color: ColorConstant.COLOR_ORIGINAL_GREY,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  const SizedBox(height: 20),
                  const MaterialButton1(
                    height1: 46,
                    txt1: 'contact us',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.COLOR_BLACK),
                    ),
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
