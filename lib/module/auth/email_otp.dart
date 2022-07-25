import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../model/concern_notification.dart';
import '../../model/email_otp_register_model.dart';
import '../../model/login_flash_model.dart';
import '../../model/login_model.dart';
import '../../model/verify_registry_model.dart';
import '../../service/api_constants.dart';
import '../../service/api_services.dart';
import '../../utils/utils.dart';
import '../../widget/toast_widget.dart';
import '../sharedpreference/shared_preference.dart';
import 'concern_notification.dart';
import 'login_flash_detail.dart';

class EmailOTPScreen extends StatefulWidget {
  final String? emailid;
  final String? verificationCode;
  final String? message;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final VerifyRegisterModel? verifyRegisterModel;

  const EmailOTPScreen({
    Key? key,
    this.emailid,
    this.verificationCode,
    this.message,
    this.firstName,
    this.lastName,
    this.verifyRegisterModel,
    this.mobile,
  }) : super(key: key);

  @override
  State<EmailOTPScreen> createState() => _EmailOTPScreenState();
}

class _EmailOTPScreenState extends State<EmailOTPScreen> {
  // Initial Selected Value
  bool isOnline = false;
  Location location = Location();
  bool isProgressRunning = false;
  LoginFlashModel? loginFlashModel;

  TextEditingController? textEditingController1 = TextEditingController();
  ConcernNotificationModel? concernNotificationModel;
  EmailOTPRegisterModel? emailOTPRegisterModel;

  @override
  void initState() {
    super.initState();

    checkInternet();
  }

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
    } else {
      InternetUtils.networkErrorDialog(context);
    }
  }

  

  @override
  void dispose() {
    try {
      textEditingController1?.dispose();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.BACKGROUND_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.9, 20.0),
                      bottomRight: Radius.elliptical(
                          MediaQuery.of(context).size.width * 0.9, 20.0),
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        ImgConstants.BACKGROUNG_IMAGE,
                      ),
                    ),
                  ),
                  // child: Image.asset(
                  //   ImgConstants.BACKGROUNG_IMAGE,
                  //   height: MediaQuery.of(context).size.height * 0.6,
                  //   width: double.infinity,
                  //   fit: BoxFit.fitWidth,
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 250, 25, 60),
                  child: Container(
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //   topRight: Radius.circular(15),
                      //   topLeft: Radius.circular(15),
                      // ),
                      color: ColorConstant.COLOR_WHITE,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 25, 30, 0),
                      child: StatefulBuilder(builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: Text(
                                widget.message ?? '',
                                // "An OTP sent to your ${widget.emailid}",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            
                            TextFieldWithOnlyPlaceHolder(
                              text1: 'Please Enter OTP',
                              controller1: textEditingController1,
                            ),

                            //

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 0.0, right: 0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (textEditingController1!
                                          .text.isEmpty) {
                                        toastshowDefaultSnackbar(
                                            context, 'Please enter otp');
                                      } else if (textEditingController1!
                                          .text.isNotEmpty) {
                                        if (widget.verifyRegisterModel
                                                ?.verificationCode ==
                                            textEditingController1!.text) {
                                          EasyLoading.show(
                                              status: 'loading...');
                                          EmailOTPRegisterModel
                                              registerDriverModel =
                                              await APIServices
                                                  .getVerifyEmailOTPRegisterAPI(
                                                      widget.emailid ?? '',
                                                      widget.firstName ?? '',
                                                      widget.lastName ?? '',
                                                      widget.mobile ?? '0',
                                                      SharedPreference.getValue(
                                                              PrefConstants
                                                                  .DEVICE_ID) ??
                                                          '',
                                                      'done');
                                          if (registerDriverModel.status ==
                                              'true') {
                                            EasyLoading.show(
                                                status: 'loading...');
                                            LoginModel loginDriverModel =
                                                await APIServices
                                                    .getLoginDriverAPI(
                                              widget.mobile ?? '',
                                              SharedPreference.getValue(
                                                      PrefConstants
                                                          .DEVICE_ID) ??
                                                  '',
                                            );
                                            if (loginDriverModel.status ==
                                                'true') {
                                              EasyLoading.dismiss();

                                              ConcernNotificationModel?
                                                  concernNotificationModel =
                                                  await APIServices
                                                      .getConcernNotificationAPI();

                                              if (concernNotificationModel
                                                      .status ==
                                                  'true') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ConcernNotification(
                                                            concernNotificationModel:
                                                                concernNotificationModel,
                                                          )),
                                                );
                                              } else {
                                                LoginFlashModel?
                                                    loginFlashModel =
                                                    await APIServices
                                                        .getLoginFlashAPI();

                                                if (loginFlashModel.status ==
                                                    'true') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginFlashScreen(
                                                              loginFlashModel:
                                                                  loginFlashModel,
                                                            )),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomePage2()),
                                                  );
                                                }
                                              }

                                              SharedPreference.setValue(
                                                  PrefConstants.IS_LOGIN, true);
                                            } else {
                                              EasyLoading.dismiss();
                                              toastshowDefaultSnackbar(context,
                                                  registerDriverModel.message);
                                            }
                                          } else {
                                            EasyLoading.dismiss();
                                            toastshowDefaultSnackbar(context,
                                                registerDriverModel.message);
                                          }
                                        } else {
                                          EasyLoading.dismiss();
                                          toastshowDefaultSnackbar(context,
                                              'Please enter valid otp');
                                        }
                                      }
                                    },
                                    // onTap: () async {
                                    //   if (widget.verificationCode ==
                                    //       textEditingController1!.text) {
                                    //     EmailOTPRegisterModel
                                    //         emailOTPRegisterModel =
                                    //         await APIServices.getVerifyEmailOTPRegisterAPI(
                                    // widget.emailid ?? '',
                                    // widget.firstName ?? '',
                                    // widget.lastName ?? '',
                                    // SharedPreference.getValue(
                                    //         PrefConstants
                                    //             .MOBILE_NUMBER) ??
                                    //     '',
                                    // SharedPreference.getValue(
                                    //         PrefConstants
                                    //             .DEVICE_ID) ??
                                    //     '',
                                    // 'done');

                                    //     if (emailOTPRegisterModel
                                    //             .status ==
                                    //         'true') {
                                    //       LoginModel? loginModel =
                                    //           await APIServices
                                    //               .getLoginAPI(_body);

                                    //       if (loginModel?.status ==
                                    //           'true') {
                                    //         await _apiConcernNotificationDetail();
                                    //         await _apiLoginFlashDetail();

                                    //         log(SharedPreference.getValue(
                                    //             PrefConstants.USER_DATA));
                                    //         SharedPreference.setValue(
                                    //             PrefConstants.IS_LOGIN,
                                    //             true);

                                    //         if (concernNotificationModel
                                    //                 ?.status ==
                                    //             'true') {
                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     const ConcernNotification()),
                                    //           );
                                    //         } else if (loginFlashModel
                                    //                 ?.status ==
                                    //             'true') {
                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     const LoginFlashScreen()),
                                    //           );
                                    //         } else if (loginFlashModel
                                    //                     ?.status ==
                                    //                 'false' &&
                                    //             concernNotificationModel
                                    //                     ?.status ==
                                    //                 'false') {
                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     const HomePage2()),
                                    //           );
                                    //         }
                                    //       }
                                    //     } else if (emailOTPRegisterModel
                                    //             .status ==
                                    //         'false') {
                                    //       showAlertDialog(
                                    //           context,
                                    //           emailOTPRegisterModel
                                    //               .message!);
                                    //     }
                                    //   } else {
                                    //     showAlertDialog(context,
                                    //         'Please Enter Correct Otp');
                                    //   }
                                    // },
                                    child: const MaterialButton1(
                                      txt1: "Enter",
                                      height1: 56,
                                      width1: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        if (textEditingController1!
                                            .text.isEmpty) {
                                          toastshowDefaultSnackbar(
                                              context, 'Please enter otp');
                                        } else if (textEditingController1!
                                            .text.isNotEmpty) {
                                          if (widget.verifyRegisterModel
                                                  ?.verificationCode ==
                                              textEditingController1!.text) {
                                            EasyLoading.show(
                                                status: 'loading...');
                                            EmailOTPRegisterModel
                                                registerDriverModel =
                                                await APIServices
                                                    .getVerifyEmailOTPRegisterAPI(
                                                        widget.emailid ?? '',
                                                        widget.firstName ?? '',
                                                        widget.lastName ?? '',
                                                        widget.mobile ?? '0',
                                                        SharedPreference.getValue(
                                                                PrefConstants
                                                                    .DEVICE_ID) ??
                                                            '',
                                                        'pending');
                                            if (registerDriverModel.status ==
                                                'true') {
                                              EasyLoading.show(
                                                  status: 'loading...');
                                              LoginModel loginDriverModel =
                                                  await APIServices
                                                      .getLoginDriverAPI(
                                                widget.mobile ?? '',
                                                SharedPreference.getValue(
                                                        PrefConstants
                                                            .DEVICE_ID) ??
                                                    '',
                                              );
                                              if (loginDriverModel.status ==
                                                  'true') {
                                                EasyLoading.dismiss();

                                                ConcernNotificationModel?
                                                    concernNotificationModel =
                                                    await APIServices
                                                        .getConcernNotificationAPI();

                                                if (concernNotificationModel
                                                        .status ==
                                                    'true') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ConcernNotification(
                                                              concernNotificationModel:
                                                                  concernNotificationModel,
                                                            )),
                                                  );
                                                } else {
                                                  LoginFlashModel?
                                                      loginFlashModel =
                                                      await APIServices
                                                          .getLoginFlashAPI();

                                                  if (loginFlashModel.status ==
                                                      'true') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginFlashScreen(
                                                                loginFlashModel:
                                                                    loginFlashModel,
                                                              )),
                                                    );
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomePage2()),
                                                    );
                                                  }
                                                }

                                                SharedPreference.setValue(
                                                    PrefConstants.IS_LOGIN,
                                                    true);
                                              } else {
                                                EasyLoading.dismiss();
                                                toastshowDefaultSnackbar(
                                                    context,
                                                    registerDriverModel
                                                        .message);
                                              }
                                            } else {
                                              EasyLoading.dismiss();
                                              toastshowDefaultSnackbar(context,
                                                  registerDriverModel.message);
                                            }
                                          } else {
                                            EasyLoading.dismiss();
                                            toastshowDefaultSnackbar(context,
                                                'Please enter valid otp');
                                          }
                                        }
                                      },
                                      // onPressed: () async {
                                      //   EmailOTPRegisterModel
                                      //       emailOTPRegisterModel =
                                      //       await APIServices
                                      //           .getVerifyEmailOTPRegisterAPI(
                                      //               widget.emailid ?? '',
                                      //               widget.firstName ?? '',
                                      //               widget.lastName ?? '',
                                      //               SharedPreference.getValue(
                                      //                       PrefConstants
                                      //                           .MOBILE_NUMBER) ??
                                      //                   '',
                                      //               SharedPreference.getValue(
                                      //                       PrefConstants
                                      //                           .DEVICE_ID) ??
                                      //                   '',
                                      //               'pending');

                                      //   if (emailOTPRegisterModel.status ==
                                      //       'true') {
                                      //     LoginModel? loginModel =
                                      //         await APIServices.getLoginAPI(
                                      //             _body);

                                      //     if (loginModel?.status == 'true') {
                                      //       await _apiConcernNotificationDetail();
                                      //       await _apiLoginFlashDetail();

                                      //       log(SharedPreference.getValue(
                                      //           PrefConstants.USER_DATA));
                                      //       SharedPreference.setValue(
                                      //           PrefConstants.IS_LOGIN, true);

                                      //       if (concernNotificationModel
                                      //               ?.status ==
                                      //           'true') {
                                      //         Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   const ConcernNotification()),
                                      //         );
                                      //       } else if (loginFlashModel
                                      //               ?.status ==
                                      //           'true') {
                                      //         Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   const LoginFlashScreen()),
                                      //         );
                                      //       } else if (loginFlashModel
                                      //                   ?.status ==
                                      //               'false' &&
                                      //           concernNotificationModel
                                      //                   ?.status ==
                                      //               'false') {
                                      //         Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   const HomePage2()),
                                      //         );
                                      //       }
                                      //     } else if (emailOTPRegisterModel
                                      //             .status ==
                                      //         'false') {
                                      //       showAlertDialog(context,
                                      //           emailOTPRegisterModel.message!);
                                      //     }
                                      //   }
                                      // },
                                      child: Text(
                                        "SKIP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                              color: ColorConstant.COLOR_BLUE,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ))
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),

                            RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By creating passcode you agree with our ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms & Condition',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLUE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        ?.copyWith(
                                          color: ColorConstant.COLOR_BLUE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
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

