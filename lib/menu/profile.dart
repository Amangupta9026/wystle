import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/service/api_services.dart';

import '../auth/onboarding.dart';
import '../constant/color_constant.dart';
import '../model/email_verify_success_model.dart';
import '../model/logout_model.dart';
import '../model/verify_registry_model.dart';
import '../module/sharedpreference/shared_preference.dart';
import '../module/sharedpreference/userdata.dart';
import '../service/api_constants.dart';
import '../widget/flush_bar.dart';
import '../widget/reusubility_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userdata = UserData.geUserData();
  VerifyRegisterModel? verifyRegisterModel;
  TextEditingController verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
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
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_BLACK,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: ColorConstant.COLOR_BLACK,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
            TextFieldWithOnlyPlaceHolder(
              enabledTextField: false,
              controller1: TextEditingController(
                text: userdata.firstname! + ' ' + userdata.lastname!,
              ),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ElevatedButton(
                //     onPressed: () {
                //       log(SharedPreference.getValue(
                //           PrefConstants.USER_EMAIL_VERIFY_TAG));
                //       // log(userdata.emailverifytag!);
                //       // log(userdata.userid.toString());
                //       // log(userdata.authToken.toString());
                //     },
                //     child: Text("press")),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Visibility(
                  visible: SharedPreference.getValue(
                          PrefConstants.USER_EMAIL_VERIFY_TAG) ==
                      'pending',
                  child: InkWell(
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
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: ColorConstant.COLOR_BLUE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFieldWithOnlyPlaceHolder(
              enabledTextField: false,
              controller1: TextEditingController(text: userdata.email),
            ),
            const SizedBox(height: 25),
            Text(
              'Mobile Number',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: ColorConstant.COLOR_BLACK,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
            TextFieldWithOnlyPlaceHolder(
              enabledTextField: false,
              controller1: TextEditingController(text: userdata.mobileno),
            ),
            const SizedBox(height: 45),

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
                width1: MediaQuery.of(context).size.width * 0.3,
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
}
