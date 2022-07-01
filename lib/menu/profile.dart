import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/service/api_services.dart';

import '../auth/onboarding.dart';
import '../constant/color_constant.dart';
import '../constant/image_constant.dart';
import '../model/email_verify_success_model.dart';
import '../model/logout_model.dart';
import '../model/verify_registry_model.dart';
import '../module/sharedpreference/shared_preference.dart';
import '../module/sharedpreference/userdata.dart';
import '../service/api_constants.dart';
import '../widget/appbar_widget.dart';
import '../widget/flush_bar.dart';
import '../widget/reusubility_button.dart';
import '../widget/toast_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 60, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarWidget(
              text1: 'Edit profile',
            ),
            const SizedBox(
              height: 10,
            ),

            Text(
              'Edit your information',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: ColorConstant.COLOR_BLACK,
                    fontWeight: FontWeight.w400,
                  ),
            ),

            const SizedBox(
              height: 30,
            ),

            Center(
                child: Stack(alignment: Alignment.bottomLeft, children: [
              InkWell(
                onTap: () async {
                  // Navigator.of(context).pop();
                  await _imgFromGallery();
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.COLOR_LIGHT_GREY2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image1 != null
                          ? Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: FileImage(image1!)
                                    // : userData.data?.profileImage != null &&
                                    //         userData.data?.profileImage != ''
                                    //     ? Image.network(
                                    //         userData?.data?.profileImage,
                                    //         errorBuilder: (BuildContext context,
                                    //             Object exception,
                                    //             StackTrace stackTrace) {
                                    //           return Image.asset(
                                    //               ImgConstants.DEFAULT_PLAYER);
                                    //         },
                                    //       ).image

                                    ),
                              ),
                            )
                          : Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // color: ColorConstant.COLOR_WHITE,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage(ImgConstants.PERSON_ICON)),
                              ),
                            )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 50,
                right: 0,
                top: 75,
                bottom: 0,
                child: InkWell(
                  onTap: () async {
                    await _imgFromGallery();
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.COLOR_WHITE,
                        border: Border.all(
                            color: ColorConstant.COLOR_ORIGINAL_GREY)),
                    child: const Icon(
                      Icons.edit,
                      color: ColorConstant.COLOR_BLACK,
                      size: 12.0,
                    ),
                  ),
                ),
              )
            ])),

            const SizedBox(
              height: 20,
            ),

            // Neumorphic(
            //   // margin:
            //   //     const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 4),
            //   style: NeumorphicStyle(
            //     shadowLightColor: Colors.grey,
            //     color: const Color(0xffebecf0),
            //     intensity: 10,
            //     surfaceIntensity: 10,
            //     depth: NeumorphicTheme.embossDepth(context),
            //     boxShape:
            //         NeumorphicBoxShape.roundRect(BorderRadius.circular(0)),
            //   ),
            //   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
            //   child: TextField(
            //       controller: TextEditingController(
            //         text: userdata.firstname!,
            //       ),
            //       onChanged: (value) {},
            //       cursorColor: ColorConstant.THEME_COLOR_RED,
            //       decoration: const InputDecoration.collapsed(
            //           hintText: "First Name",
            //           hintStyle: TextStyle(color: Color(0xffbbbdbc)))),
            // ),

            TextFieldWithOnlyPlaceHolder(
              enabledTextField: true,
              controller1: TextEditingController(
                text: userdata.firstname!,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextFieldWithOnlyPlaceHolder(
              enabledTextField: true,
              controller1: TextEditingController(
                text: userdata.lastname!,
              ),
            ),

            const SizedBox(height: 15),
            TextFieldWithOnlyPlaceHolder(
              enabledTextField: true,
              controller1: TextEditingController(text: userdata.email),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: SharedPreference.getValue(
                          PrefConstants.USER_EMAIL_VERIFY_TAG) ==
                      'pending',
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: () async {
                          verifyRegisterModel =
                              await APIServices.getVerifyEmailRiderAPI(
                                  userdata.userid!);
                          if (verifyRegisterModel?.status == 'true') {
                            showAlertDialog(
                                context,
                                verifyRegisterModel?.message ??
                                    'Verification code sent to your email');
                          }
                        },
                        child: Text(
                          'Verify',
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ColorConstant.COLOR_BLUE,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            TextFieldWithOnlyPlaceHolder(
              enabledTextField: true,
              controller1: TextEditingController(text: userdata.mobileno),
            ),
            const SizedBox(height: 45),

            // Save Button

            InkWell(
              onTap: () {
                showDefaultSnackbar(context, 'Save');
              },
              child: const MaterialButton1(
                height1: 48,
                txt1: 'SAVE',
                color1: ColorConstant.THEME_COLOR_RED,
              ),
            ),

            const SizedBox(height: 25),

            // LogOut Button

            InkWell(
              onTap: () async {
                LogoutModel logoutModel = await APIServices.getLogoutAPI(
                  userdata.userid!,
                );
                if (logoutModel.status == 'true') {
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
              child: MaterialButton1(
                height1: MediaQuery.of(context).size.width * 0.12,
                width1: MediaQuery.of(context).size.width,
                txt1: 'Logout',
              ),
            )
          ],
        ),
      )),
    );
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
        child: Text(
          "OK",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: ColorConstant.COLOR_BLACK,
                fontWeight: FontWeight.w600,
              ),
        ),
        onPressed: () async {
          if (verificationCodeController.text ==
              verifyRegisterModel?.verificationCode) {
            EmailVerifiedSuccessModel emailVerifiedSuccessModel =
                await APIServices.getVerifiedEmailSuccessAPI(userdata.userid!);
            if (emailVerifiedSuccessModel.status == 'true') {
              SharedPreference.setValue(
                  PrefConstants.USER_EMAIL_VERIFY_TAG, 'done');

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage2()),
              );
            }
          } else if (verificationCodeController.text.isEmpty) {
            UtilsFlushBar.showDefaultSnackbar(
                context, "Please enter verification code");
          }
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(
        children: [
          Text(message),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstant.COLOR_BLACK)),
            child: TextFormField(
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: ColorConstant.COLOR_BLACK,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
              controller: verificationCodeController,
              cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
                hintText: 'Enter your OTP',
                hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                      fontWeight: FontWeight.w500,
                    ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorConstant.COLOR_LIGHT_BLACK, width: 0.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.3, color: ColorConstant.COLOR_LIGHT_BLACK),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 0.3, color: ColorConstant.COLOR_LIGHT_BLACK),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
              ),
              onChanged: (value) {
                // this.phoneNo=value;
                log(value);
                setState(() {
                  log(value);
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Image Select
  Future<void> _imgFromGallery() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

      setState(() {
        image1 = File(image!.path);
      });
    } else {
      var permissionResult = await Permission.storage.request();
      if (permissionResult.isDenied || permissionResult.isPermanentlyDenied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Storage Permission'),
                  content: const Text(
                      'This app needs storage access to take pictures for upload user profile photo'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: const Text('Deny'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: const Text('Settings'),
                      onPressed: () => openAppSettings(),
                    ),
                  ],
                ));
      }
    }
  }
}
