import 'dart:async';
import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wystle/auth/registration_form.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../model/concern_notification.dart';
import '../model/login_flash_model.dart';
import '../model/login_model.dart';
import '../model/otpverify_model.dart';
import '../module/sharedpreference/shared_preference.dart';
import '../module/sharedpreference/userdata.dart';
import '../service/api_constants.dart';
import '../service/api_services.dart';
import '../utils/utils.dart';
import 'concern_notification.dart';
import 'login_flash_detail.dart';

class OTPScreen extends StatefulWidget {
  final double? latitude1;
  final double? longitude1;
  final String? mobileNumber;
  final int? otp;
  final String? message;
  final String? registerFlag;
  const OTPScreen(
      {Key? key,
      this.latitude1,
      this.longitude1,
      this.mobileNumber,
      this.otp,
      this.message,
      this.registerFlag})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  bool isOnline = false;
  late Timer _timer;
  int _start = 60;
  LoginModel? loginModel;

  // LocationData? _currentPosition;
  Location location = Location();
  // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  // String? _address, _dateTime;
  bool isProgressRunning = false;
  LoginFlashModel? loginFlashModel;

  TextEditingController? textEditingController1 = TextEditingController();
  OTPVerifyModel? otpVerifyModel;
  OTPVerifyModel? otpVerify;

  String _comingSms = 'Unknown';
  ConcernNotificationModel? concernNotificationModel;

  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (mounted) return;
    setState(() {
      _comingSms = comingSms!;
      log("====>Message: $_comingSms");
      log(_comingSms[32]);
      textEditingController1?.text = _comingSms[32] +
          _comingSms[33] +
          _comingSms[34] +
          _comingSms[35] +
          _comingSms[36] +
          _comingSms[
              37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
    });
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

  
  
  @override
  void initState() {
    super.initState();
    initSmsListener();
    checkInternet();
    textEditingController1 = TextEditingController();
  
    startTimer();
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

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    AltSmsAutofill().unregisterListener();
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
                 
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 250, 25, 60),
                  child: Container(
                    decoration: const BoxDecoration(
                     
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
                                widget.message != null
                                    ? widget.message.toString()
                                    : 'OTP Sent to your mobile number',
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
                              height: 8,
                            ),
                            

                            PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 4,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  borderRadius: BorderRadius.circular(10),
                                  fieldHeight: 40,
                                  fieldWidth: 40,
                                  inactiveFillColor: Colors.white,
                                  inactiveColor: Colors.grey,
                                  selectedColor: Colors.green.shade600,
                                  selectedFillColor: Colors.white,
                                  activeFillColor: Colors.white,
                                  activeColor: ColorConstant.COLOR_BLACK),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              enablePinAutofill: true,
                              controller: textEditingController1,
                              keyboardType: TextInputType.number,
                              boxShadows: const [],
                              onCompleted: (v) {
                                //do something or move to next screen when code complete
                              },
                              onChanged: (value) {
                                log(value);
                                setState(() {
                                  log(value);
                                });
                              },
                            ),

                            //

                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 0.0, right: 0),
                              child: Column(
                                children: [
                                  _start != 0
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Resend code in",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    color: ColorConstant
                                                        .COLOR_ORIGINAL_GREY,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              _start.toString(),
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                    color: ColorConstant
                                                        .COLOR_ORIGINAL_GREY,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () {
                                            setState(() async {
                                              _start = 60;

                                              otpVerify = await APIServices
                                                  .getOTPVerifyAPI(widget
                                                      .mobileNumber
                                                      .toString());
                                              showAlertDialog(
                                                  context, widget.message!);
                                              log('otp $otpVerify');
                                            });
                                          },
                                          child: Text(
                                            'Resend OTP',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                ?.copyWith(
                                                  color:
                                                      ColorConstant.COLOR_BLUE,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textEditingController1!.text.length == 4
                                      ? InkWell(
                                          onTap: () async {
                                            if (textEditingController1!.text
                                                        .toString() ==
                                                    widget.otp.toString() &&
                                                widget.registerFlag ==
                                                    'false') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegistrationForm()),
                                              );
                                              SharedPreference.setValue(
                                                  PrefConstants.MOBILE_NUMBER,
                                                  widget.mobileNumber);
                                            } else if (otpVerify?.otpNumber
                                                        .toString() ==
                                                    textEditingController1!
                                                        .text &&
                                                widget.registerFlag ==
                                                    'false') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const RegistrationForm()),
                                              );
                                              SharedPreference.setValue(
                                                  PrefConstants.MOBILE_NUMBER,
                                                  widget.mobileNumber);
                                            } else if (otpVerify?.otpNumber
                                                        .toString() ==
                                                    textEditingController1!
                                                        .text &&
                                                widget.registerFlag == 'true') {
                                              SharedPreference.setValue(
                                                  PrefConstants.IS_LOGIN, true);
                                              SharedPreference.setValue(
                                                  PrefConstants.MOBILE_NUMBER,
                                                  widget.mobileNumber);

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomePage2()),
                                              );
                                            } else if (textEditingController1!
                                                        .text
                                                        .toString() ==
                                                    widget.otp.toString() &&
                                                widget.registerFlag == 'true') {
                                              Map _body = {
                                                "mobileno": widget.mobileNumber,
                                                "deviceid":
                                                    SharedPreference.getValue(
                                                            PrefConstants
                                                                .DEVICE_ID) ??
                                                        '',
                                              };

                                              LoginModel? loginModel =
                                                  await APIServices.getLoginAPI(
                                                      _body);
                                              if (loginModel?.status ==
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
                                              } else {
                                                showAlertDialog(
                                                    context, 'Invalid otp');
                                              }
                                            } else {
                                              showAlertDialog(
                                                  context, 'Invalid otp');
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
        startTimer();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      // content: const Text("This is my message."),
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

// // ignore_for_file: unused_field

// import 'dart:developer';

// import 'package:alt_sms_autofill/alt_sms_autofill.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:wystle/model/login_flash_model.dart';
// import 'package:wystle/widget/reusubility_button.dart';

// import '../model/concern_notification.dart';
// import '../module/homepage/homepage.dart';
// import '../service/api_services.dart';
// import 'concern_notification.dart';
// import 'login_flash_detail.dart' as login_flash_detail;

// class OTPScreen extends StatefulWidget {
//   final double? latitude1;
//   final double? longitude1;
//   final String? phonenumber;
//   const OTPScreen({Key? key, this.phonenumber, this.latitude1, this.longitude1})
//       : super(key: key);

//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }

// class _OTPScreenState extends State<OTPScreen> {
// LocationData? _currentPosition;
// Location location = Location();
// LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
// String? _address, _dateTime;
// bool isProgressRunning = false;
// LoginFlashModel? loginFlashModel;

// TextEditingController? textEditingController1 = TextEditingController();

// String _comingSms = 'Unknown';
// ConcernNotificationModel? concernNotificationModel;

// Future<void> initSmsListener() async {
//   String? comingSms;
//   try {
//     comingSms = await AltSmsAutofill().listenForSms;
//   } on PlatformException {
//     comingSms = 'Failed to get Sms.';
//   }
//   if (mounted) return;
//   setState(() {
//     _comingSms = comingSms!;
//     log("====>Message: $_comingSms");
//     log(_comingSms[32]);
//     textEditingController1?.text = _comingSms[32] +
//         _comingSms[33] +
//         _comingSms[34] +
//         _comingSms[35] +
//         _comingSms[36] +
//         _comingSms[
//             37]; //used to set the code in the message to a string and setting it to a textcontroller. message length is 38. so my code is in string index 32-37.
//   });
// }

// // Flash Login Api

// Future<void> _apiLoginFlashDetail() async {
//   try {
//     setState(() {
//       isProgressRunning = true;
//     });

//     Map _body = {
//       "country": "United Kingdom",
//       "state": "England",
//       "city": "City of London"
//     };
//     loginFlashModel = await APIServices.getLoginFlashAPI(_body);
//   } catch (e) {
//     log(e.toString());
//   } finally {
//     setState(() {
//       isProgressRunning = false;
//     });
//   }
// }

// // Concern Api

// Future<void> _apiConcernNotificationDetail() async {
//   try {
//     setState(() {
//       isProgressRunning = true;
//     });

//     Map _body = {
//       "country": "United Kingdom",
//       "state": "England",
//       "city": "City of London"
//     };

//     concernNotificationModel =
//         await APIServices.getConcernNotificationAPI(_body);
//     // fetchAWS3Image(
//     //     concernNotificationModel?.concernNotifDetail?[0].conNotifPdf ?? '');
//   } catch (e) {
//     log(e.toString());
//   } finally {
//     setState(() {
//       isProgressRunning = false;
//     });
//   }
// }

//   @override
//   void initState() {
//     super.initState();
// textEditingController1 = TextEditingController();
// initSmsListener();
// _apiLoginFlashDetail();
// _apiConcernNotificationDetail();
//   }

//   @override
//   void dispose() {
//     //  textEditingController1!.dispose();
// AltSmsAutofill().unregisterListener();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 50, left: 15.0, right: 15, bottom: 80),
//           child: Column(children: [
//             Text(
//               "Enter the 4-digit code sent to your phone ${widget.phonenumber}",
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
// PinCodeTextField(
//   appContext: context,
//   pastedTextStyle: TextStyle(
//     color: Colors.green.shade600,
//     fontWeight: FontWeight.bold,
//   ),
//   length: 4,
//   obscureText: false,
//   animationType: AnimationType.fade,
//   pinTheme: PinTheme(
//       shape: PinCodeFieldShape.box,
//       borderRadius: BorderRadius.circular(10),
//       fieldHeight: 50,
//       fieldWidth: 50,
//       inactiveFillColor: Colors.white,
//       inactiveColor: Colors.grey,
//       selectedColor: Colors.green.shade600,
//       selectedFillColor: Colors.white,
//       activeFillColor: Colors.white,
//       activeColor: Colors.red),
//   cursorColor: Colors.black,
//   animationDuration: const Duration(milliseconds: 300),
//   enableActiveFill: true,
//   controller: textEditingController1,
//   keyboardType: TextInputType.number,
//   boxShadows: const [
//     BoxShadow(
//       offset: Offset(0, 1),
//       color: Colors.black12,
//       blurRadius: 10,
//     )
//   ],
//   onCompleted: (v) {
//     //do something or move to next screen when code complete
//   },
//   onChanged: (value) {
//     log(value);
//     setState(() {
//       log(value);
//     });
//   },
// ),
//             //const SizedBox(height: 20),

//             // Resend OTP Function

//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "Resend OTP",
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue),
//                 ),
//               ),
//             ),

//             // I didn't get the code

//             // InkWell(
//             //   onTap: () {
//             //     _getPrizeBreakUpBottomSheet(context);
//             //   },
//             //   child: const MaterialButton1(
//             //     height1: 45,
//             //     color1: Colors.grey,
//             //     txt1: "I didn't get the code",
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//             InkWell(
//               onTap: () async {
//   if (concernNotificationModel?.status == 'true') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const ConcernNotification()),
//     );

//     // await getLoc();
//     // log(
//     //   "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
//     // );
//   } else if (loginFlashModel?.status == 'true') {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               const login_flash_detail.LoginFlashScreen()),
//     );
//   } else {
//     Navigator.push(
//       context,
//     MaterialPageRoute(builder: (context) => const HomePage2()),
//     );
//   }
// },
//               child: const MaterialButton1(
//                 height1: 56,
//                 txt1: "Login",
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

// }
