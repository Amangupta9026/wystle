import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../model/concern_notification.dart';
import '../model/email_otp_register_model.dart';
import '../model/login_flash_model.dart';
import '../module/sharedpreference/shared_preference.dart';
import '../module/sharedpreference/userdata.dart';
import '../service/api_constants.dart';
import '../service/api_services.dart';
import '../utils/utils.dart';
import 'concern_notification.dart';
import 'login_flash_detail.dart';

class EmailOTPScreen extends StatefulWidget {
  final String? emailid;
  final String? verificationCode;
  final String? message;
  final String? firstName;
  final String? lastName;

  const EmailOTPScreen({
    Key? key,
    this.emailid,
    this.verificationCode,
    this.message,
    this.firstName,
    this.lastName,
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

  // Flash Login Api

  Future<void> _apiLoginFlashDetail() async {
    try {
      setState(() {
        isProgressRunning = true;
      });

      var userdata = UserData.geUserData();
      Map _body = {
        "userid": userdata.userid,
        "country": "United Kingdom",
        "state": "England",
        "city": "City of London"
      };
      loginFlashModel = await APIServices.getLoginFlashAPI(_body);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  // Concern Api

  Future<void> _apiConcernNotificationDetail() async {
    try {
      setState(() {
        isProgressRunning = true;
      });

      var userdata = UserData.geUserData();

      Map _body = {
        "userid": userdata.userid,
        "country": "United Kingdom",
        "state": "England",
        "city": "City of London"
      };

      concernNotificationModel =
          await APIServices.getConcernNotificationAPI(_body);
      // fetchAWS3Image(
      //     concernNotificationModel?.concernNotifDetail?[0].conNotifPdf ?? '');
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
      log("Internet is connected");
    } else {
      InternetUtils.networkErrorDialog(context);
      log("Internet is not connected");
    }
  }

  // Register API

  // Future<void> _apiEmailOTPRegistration(String emailId, firstName, lastName,
  //     mobileNumber, deviceId, emailverifytag) async {
  //   try {
  //     setState(() {
  //       isProgressRunning = true;
  //     });
  // Map _body = {
  //   "email": emailId,
  //   "firstname": firstName,
  //   "lastname": lastName,
  //   "mobileno": mobileNumber,
  //   "deviceid": deviceId,
  //   "emailverifytag": emailverifytag,
  // };
  //     emailOTPRegisterModel =
  //         await APIServices.getVerifyEmailOTPRegisterAPI(_body);
  //     if (emailOTPRegisterModel?.status == "true") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage2()),
  //       );
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   } finally {
  //     setState(() {
  //       isProgressRunning = false;
  //     });
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
    textEditingController1?.dispose();
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
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.COLOR_BLACK)),
                              child: TextFormField(
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                controller: textEditingController1,
                                cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 10),
                                  hintText: 'Enter your OTP',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ColorConstant.COLOR_LIGHT_BLACK,
                                        width: 0.3),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
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

                            //

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 0.0, right: 0),
                              child: Column(
                                children: [
                                  textEditingController1!.text.length >= 6
                                      ? InkWell(
                                          onTap: () async {
                                            if (widget.verificationCode ==
                                                textEditingController1!.text) {
                                              EmailOTPRegisterModel
                                                  emailOTPRegisterModel =
                                                  await APIServices.getVerifyEmailOTPRegisterAPI(
                                                      widget.emailid ?? '',
                                                      widget.firstName ?? '',
                                                      widget.lastName ?? '',
                                                      SharedPreference.getValue(
                                                              PrefConstants
                                                                  .MOBILE_NUMBER) ??
                                                          '',
                                                      SharedPreference.getValue(
                                                              PrefConstants
                                                                  .DEVICE_ID) ??
                                                          '',
                                                      'done');

                                              if (emailOTPRegisterModel
                                                      .status ==
                                                  'true') {
                                                await _apiConcernNotificationDetail();
                                                await _apiLoginFlashDetail();

                                                SharedPreference.setValue(
                                                    PrefConstants.IS_LOGIN,
                                                    true);

                                                if (concernNotificationModel
                                                        ?.status ==
                                                    'true') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const ConcernNotification()),
                                                  );
                                                } else if (loginFlashModel
                                                        ?.status ==
                                                    'true') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LoginFlashScreen()),
                                                  );
                                                } else if (loginFlashModel
                                                            ?.status ==
                                                        'false' &&
                                                    concernNotificationModel
                                                            ?.status ==
                                                        'false') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomePage2()),
                                                  );
                                                }
                                              } else if (emailOTPRegisterModel
                                                      .status ==
                                                  'false') {
                                                showAlertDialog(
                                                    context,
                                                    emailOTPRegisterModel
                                                        .message!);
                                              }
                                            } else {
                                              showAlertDialog(context,
                                                  'Please Enter Correct Otp');
                                            }
                                          },
                                          child: const MaterialButton1(
                                            txt1: "Enter",
                                            height1: 56,
                                            width1: double.infinity,
                                          ),
                                        )
                                      : const MaterialButton1(
                                          txt1: "Enter",
                                          height1: 56,
                                          width1: double.infinity,
                                          color1:
                                              ColorConstant.COLOR_LIGHT_GREY,
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        EmailOTPRegisterModel
                                            emailOTPRegisterModel =
                                            await APIServices
                                                .getVerifyEmailOTPRegisterAPI(
                                                    widget.emailid ?? '',
                                                    widget.firstName ?? '',
                                                    widget.lastName ?? '',
                                                    SharedPreference.getValue(
                                                            PrefConstants
                                                                .MOBILE_NUMBER) ??
                                                        '',
                                                    SharedPreference.getValue(
                                                            PrefConstants
                                                                .DEVICE_ID) ??
                                                        '',
                                                    'pending');

                                        if (emailOTPRegisterModel.status ==
                                            'true') {
                                          await _apiConcernNotificationDetail();
                                          await _apiLoginFlashDetail();

                                          SharedPreference.setValue(
                                              PrefConstants.IS_LOGIN, true);

                                          if (concernNotificationModel
                                                  ?.status ==
                                              'true') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ConcernNotification()),
                                            );
                                          } else if (loginFlashModel?.status ==
                                              'true') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginFlashScreen()),
                                            );
                                          } else if (loginFlashModel?.status ==
                                                  'false' &&
                                              concernNotificationModel
                                                      ?.status ==
                                                  'false') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage2()),
                                            );
                                          }
                                        } else if (emailOTPRegisterModel
                                                .status ==
                                            'false') {
                                          showAlertDialog(context,
                                              emailOTPRegisterModel.message!);
                                        }
                                      },
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
                                          color: ColorConstant.COLOR_BLACK,
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

// import 'dart:ui';

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';

// import '../constant/color_constant.dart';

// // Screen 3.0
// class EmailSent extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         _navigateToNextScreen(context);
//         debugPrint("Click");
//       };

//     return Scaffold(
//         backgroundColor: Colors.cyan,
//         //Color(0xFF3176c1),
//         body: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                 child: Row(
//                   children: [
//                     IconButton(
//                         icon: const Icon(Icons.close),
//                         color: ColorConstant.COLOR_BLACK,
//                         iconSize: 30,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         }),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Theme.of(context).colorScheme.primary,
//                               width: 4),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(10),
//                           child: Icon(
//                             Icons.check_rounded,
//                             size: 80,
//                             color: Colors.greenAccent,
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       'Email Sent',
//                       style: Theme.of(context).textTheme.headline3?.copyWith(
//                             color: ColorConstant.COLOR_BLACK,
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                     const Align(alignment: Alignment.center),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           left: 30.0, right: 30.0, top: 10, bottom: 10),
//                       child: Text(
//                         'Please verify your email id, Instructions were sent to your email.',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.subtitle1?.copyWith(
//                               color: ColorConstant.COLOR_BLACK,
//                               fontWeight: FontWeight.w400,
//                             ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                           text: "Didn't get an email ? ",
//                           style:
//                               Theme.of(context).textTheme.subtitle1?.copyWith(
//                                     color: ColorConstant.COLOR_BLACK,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                           children: [
//                             TextSpan(
//                                 text: 'Resend',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle1
//                                     ?.copyWith(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                 recognizer: _gestureRecognizer),
//                           ]),
//                     ),
//                     const SizedBox(
//                       height: 60,
//                     ),
//                     TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "SKIP",
//                           style:
//                               Theme.of(context).textTheme.subtitle1?.copyWith(
//                                     color: ColorConstant.COLOR_BLACK,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                         ))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   void _navigateToNextScreen(BuildContext context) {
//     circleIconAlert(
//       context,
//     );
//   }

//   circleIconAlert(BuildContext context) {
//     // Create AlertDialog
//     AlertDialog alert = AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Row(mainAxisAlignment: MainAxisAlignment.center,
//               //crossAxisAlignment: CrossAxisAlignment.baseline,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Theme.of(context).colorScheme.secondary,
//                             width: 4),
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Icon(
//                           Icons.check_rounded,
//                           size: 80,
//                           color: Colors.greenAccent,
//                         ),
//                       )),
//                 )
//               ]),
//           const Padding(
//             padding: EdgeInsets.fromLTRB(25, 25, 25, 35),
//             child: Text(
//               "Email Sent",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           )
//         ],
//       ),
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
