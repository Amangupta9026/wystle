// ignore_for_file: unused_field

import 'dart:developer';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wystle/model/login_flash_model.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../model/concern_notification.dart';
import '../module/homepage/homepage.dart';
import '../service/api_services.dart';
import 'concern_notification.dart';
import 'login_flash_detail.dart' as login_flash_detail;

class OTPScreen extends StatefulWidget {
  final double? latitude1;
  final double? longitude1;
  final String? phonenumber;
  const OTPScreen({Key? key, this.phonenumber, this.latitude1, this.longitude1})
      : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  LocationData? _currentPosition;
  Location location = Location();
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  String? _address, _dateTime;
  bool isProgressRunning = false;
  LoginFlashModel? loginFlashModel;

  TextEditingController? textEditingController1 = TextEditingController();

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

      Map _body = {
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

      Map _body = {
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
    textEditingController1 = TextEditingController();
    initSmsListener();
    _apiLoginFlashDetail();
    _apiConcernNotificationDetail();
  }

  @override
  void dispose() {
    //  textEditingController1!.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15.0, right: 15, bottom: 80),
          child: Column(children: [
            Text(
              "Enter the 4-digit code sent to your phone ${widget.phonenumber}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
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
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  inactiveFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  selectedColor: Colors.green.shade600,
                  selectedFillColor: Colors.white,
                  activeFillColor: Colors.white,
                  activeColor: Colors.red),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: textEditingController1,
              keyboardType: TextInputType.number,
              boxShadows: const [
                BoxShadow(
                  offset: Offset(0, 1),
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
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
            //const SizedBox(height: 20),

            // Resend OTP Function

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Resend OTP",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue),
                ),
              ),
            ),

            // I didn't get the code

            // InkWell(
            //   onTap: () {
            //     _getPrizeBreakUpBottomSheet(context);
            //   },
            //   child: const MaterialButton1(
            //     height1: 45,
            //     color1: Colors.grey,
            //     txt1: "I didn't get the code",
            //   ),
            // ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                if (concernNotificationModel?.status == 'true') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConcernNotification()),
                  );

                  // await getLoc();
                  // log(
                  //   "Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}",
                  // );
                } else if (loginFlashModel?.status == 'true') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const login_flash_detail.LoginFlashScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => const HomePage2()),
                  );
                }
              },
              child: const MaterialButton1(
                height1: 56,
                txt1: "Login",
              ),
            ),
          ]),
        ),
      ),
    );
  }
  
}
