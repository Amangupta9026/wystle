// ignore_for_file: unused_local_variable, equal_elements_in_set

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/model/concern_notification.dart';
import 'package:wystle/model/login_flash_model.dart';
import 'package:wystle/module/homepage/homepage.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../module/sharedpreference/userdata.dart';
import '../service/api_services.dart';
import '../service/aws_service.dart';
import '../testing/location_custom.dart';
import '../utils/utils.dart';
import '../widget/shimmer_effect_line.dart';

class LoginFlashScreen extends StatefulWidget {
  const LoginFlashScreen({Key? key}) : super(key: key);

  @override
  _LoginFlashScreenState createState() => _LoginFlashScreenState();
}

class _LoginFlashScreenState extends State<LoginFlashScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var _base64;
  bool isProgressRunning = false;
  LoginFlashModel? loginFlashModel;
  ConcernNotificationModel? concernNotificationModel;
  var location = Location();
  // LocationData? _currentPosition;
  // LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  // String? _address, _dateTime;
  // var latitude1;
  // var longitude1;
  bool enabled = false;
  bool isInternetCheck = false;

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
        "district": "Greater London",
        "city": "London"
      };
      loginFlashModel = await APIServices.getLoginFlashAPI(_body);
      fetchAWS3Image(
          loginFlashModel?.loginFlashDetail?[0].loginFlashImage ?? '');
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<Uint8List?> fetchAWS3Image(String posterImage) async {
    const region = awsRegion;
    const bucketId = awsBucketId;
    final AwsS3Client s3client = awsS3client;
    // AwsS3Client(
    //     region: region,
    //     host: "s3.eu-west-2.amazonaws.com",
    //     bucketId: bucketId,
    //     accessKey: "AKIAQ4UXMACGEPN4A7EK",
    //     secretKey: "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");
    final listBucketResult = await s3client.listObjects(
        prefix: "Wystle/Admin/rider-app/on-boarding/login-flash",
        delimiter: "/");
    final response = await s3client.getObject(posterImage);

    setState(() {
      _base64 = response.bodyBytes;
    });
    return _base64;
  }

  // GPS check

  Future<void> enableLocation() async {
    location = Location();
    enabled = await location.serviceEnabled();
  }

  // Internet Check
  Future<void> checkInternet() async {
    isInternetCheck = await InternetUtils.internetCheck();
    if (isInternetCheck) {
    } else {
      InternetUtils.networkErrorDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    enableLocation();
    _apiLoginFlashDetail().then((value) => {
          checkInternet(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginFlashModel?.status == "true"
          ? loginFlashModel?.loginFlashDetail![0].loginFlashBgColor != null
              ? Color(int?.tryParse(
                  "0xFF${loginFlashModel?.loginFlashDetail?[0].loginFlashBgColor?.substring(1, loginFlashModel?.loginFlashDetail?[0].loginFlashBgColor?.length)}")!)
              : const Color(0xFFF5F5F5)
          : const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 45, 12, 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (loginFlashModel?.status == "true" || isProgressRunning) ...{
                  if (_base64 != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        loginFlashModel?.loginFlashDetail?[0].loginFlashLabel ??
                            "On Ride",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 27,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF424242),
                        ),
                      ),
                    )
                  else ...{
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      // enabled: isProgressRunning,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 27.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                  const SizedBox(
                    height: 80.0,
                  ),
                  if (_base64 != null) ...[
                    Image.memory(
                      _base64,
                      height: 200,
                      width: 200,
                    ),
                    // SvgPicture.memory(
                    //   _base64,
                    //   height: MediaQuery.of(context).size.height * 0.4,
                    //   width: MediaQuery.of(context).size.width * 0.2,
                    // ),
                  ] else ...{
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          // enabled: isProgressRunning,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            height: MediaQuery.of(context).size.height * 0.20,
                            // padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xffe9e7f1),
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(
                                color: const Color(0xffe9e7f1),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffe9e7f1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  },

                  // Label Show

                  const SizedBox(
                    height: 70,
                  ),

                  if (_base64 != null)
                    Text(
                      loginFlashModel?.loginFlashDetail?[0].loginFlashContent ??
                          "",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.5,
                      ),
                    )
                  else ...{
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const ShimmerEffectLineByLine(
                          width1: double.infinity,
                          height1: 17.0,
                        ),
                        const SizedBox(height: 10),
                        const ShimmerEffectLineByLine(
                          width1: double.infinity,
                          height1: 17.0,
                        ),
                        const SizedBox(height: 10),
                        const ShimmerEffectLineByLine(
                            width1: double.infinity, height1: 17.0),
                        const SizedBox(height: 10),
                        const ShimmerEffectLineByLine(
                          width1: double.infinity,
                          height1: 17.0,
                        ),
                        const SizedBox(height: 10),
                        const ShimmerEffectLineByLine(
                          width1: double.infinity,
                          height1: 17.0,
                        ),
                        const SizedBox(height: 10),
                        ShimmerEffectLineByLine(
                          width1: MediaQuery.of(context).size.width * 0.3,
                          height1: 17.0,
                        ),
                      ],
                    )
                  },
                  // const Spacer(),

                  const SizedBox(
                    height: 50,
                  ),
                  if (_base64 != null) ...{
                    InkWell(
                      onTap: () async {
                        var location = Location();
                        bool enabled = await location.serviceEnabled();

                        if (!enabled) {
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) =>
                                  const LocationCustom(
                                screenname: LoginFlashScreen(),
                              ),
                            ),
                            (route) => false,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage2(
                                  screencolor1: loginFlashModel
                                      ?.loginFlashDetail?[0].loginFlashBgColor
                                      ?.substring(
                                1,
                                loginFlashModel?.loginFlashDetail?[0]
                                    .loginFlashBgColor?.length,
                              )),
                            ),
                          );
                        }
                      },
                      child: const MaterialButton1(
                        txt1: "OK",
                        height1: 56,
                        width1: double.infinity,
                      ),
                    ),
                  } else ...{
                    ShimmerEffectLineByLine(
                      width1: MediaQuery.of(context).size.width,
                      height1: 56.0,
                    ),
                  }
                }

                //
                // else for Static UI
                //

                else ...{
                  const Text(
                    "Secure Your Ride",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF424242),
                    ),
                  ),

                  const SizedBox(
                    height: 65.0,
                  ),

                  SvgPicture.asset(
                    ImgConstants.ONBOARDING3,
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),

                  // Label Show

                  const SizedBox(
                    height: 70,
                  ),

                  const Text(
                    "Safety Riding is first and foremost a way to save lives",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Sofia",
                      fontSize: 16,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),

                  // const Spacer(),

                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage2()),
                      );
                    },
                    child: const MaterialButton1(
                      txt1: "OK",
                      height1: 56,
                      width1: double.infinity,
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
