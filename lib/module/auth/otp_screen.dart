import 'dart:async';
import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:location/location.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/module/auth/registration_form.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../model/concern_notification.dart';
import '../../model/login_flash_model.dart';
import '../../model/login_model.dart';
import '../../model/otpverify_model.dart';
import '../../service/api_constants.dart';
import '../../service/api_services.dart';
import '../../utils/utils.dart';
import '../../widget/toast_widget.dart';
import '../sharedpreference/shared_preference.dart';
import 'concern_notification.dart';
import 'login_flash_detail.dart';

class OTPScreen extends StatefulWidget {
  final double? latitude1;
  final double? longitude1;
  final OTPVerifyModel? sendOTPVerifyModel;
  final String? mobileNumber;
  const OTPScreen(
      {Key? key,
      this.latitude1,
      this.longitude1,
      this.mobileNumber,
      this.sendOTPVerifyModel})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // Initial Selected Value

  bool isOnline = false;
  late Timer _timer;
  int _start = 60;
  Location location = Location();

  bool isProgressRunning = false;
  LoginFlashModel? loginFlashModel;

  TextEditingController textEditingController1 = TextEditingController();
  OTPVerifyModel? otpVerify;

  String _comingSms = 'Unknown';
  ConcernNotificationModel? concernNotificationModel;

  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } catch (e) {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms!;
      String aStr = _comingSms.replaceAll(RegExp(r'[^0-9]'), '');

      log("====>Message: $_comingSms");
      log(_comingSms[32]);
      String otp = aStr.substring(0, 4);
      textEditingController1.text = otp;
    });
  }

  @override
  void initState() {
    super.initState();
    initSmsListener();
    // _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    checkInternet();
    startTimer();
  }

  Future<void> checkInternet() async {
    isOnline = await InternetUtils.internetCheck();
    if (isOnline) {
    } else {
      InternetUtils.networkErrorDialog(context);
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
    try {
      textEditingController1.dispose();
      _timer.cancel();
      AltSmsAutofill().unregisterListener();
    } catch (e) {
      log(e.toString(), name: 'OTPScreen');
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
                                widget.sendOTPVerifyModel?.message != null
                                    ? widget.sendOTPVerifyModel?.message ?? ''
                                    : 'OTP Sent to your mobile number',
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
                              height: 8,
                            ),

                            PinCodeTextField(
                              autoFocus: true,
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
                                  activeColor: ColorConstant.COLOR_TEXT),
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
                                                  context,
                                                  widget.sendOTPVerifyModel
                                                          ?.message ??
                                                      '');
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
                                  textEditingController1.text.length == 4
                                      ? InkWell(
                                          onTap: () async {
                                            if (textEditingController1
                                                .text.isEmpty) {
                                              toastshowDefaultSnackbar(
                                                  context, 'Please enter OTP');
                                            } else if (textEditingController1
                                                    .text ==
                                                widget.sendOTPVerifyModel
                                                    ?.otpNumber
                                                    .toString()) {
                                              //

                                              if (widget.sendOTPVerifyModel
                                                      ?.registerFlag ==
                                                  'false') {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RegistrationForm(
                                                            mobileNumber: widget
                                                                    .mobileNumber ??
                                                                '',
                                                          )),
                                                );
                                              } else if (widget
                                                      .sendOTPVerifyModel
                                                      ?.registerFlag ==
                                                  'true') {
                                                EasyLoading.show(
                                                    status: 'loading...');
                                                LoginModel loginDriverModel =
                                                    await APIServices
                                                        .getLoginDriverAPI(
                                                  widget.mobileNumber ?? '',
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

                                                    if (loginFlashModel
                                                            .status ==
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
                                                }

                                                SharedPreference.setValue(
                                                    PrefConstants.IS_LOGIN,
                                                    true);
                                              }
                                            } else {
                                              toastshowDefaultSnackbar(context,
                                                  'Please enter correct OTP');
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
