// ignore_for_file: unused_local_variable, equal_elements_in_set, deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_s3_client/flutter_aws_s3_client.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/color_constant.dart';
import '../../constant/image_constant.dart';
import '../../model/concern_notification.dart';
import '../../model/login_flash_model.dart';
import '../../service/api_services.dart';
import '../../widget/location_custom.dart';
import '../../utils/utils.dart';
import '../../widget/pdfviewer.dart';
import '../../widget/reusubility_button.dart';
import '../../widget/shimmer_effect_line.dart';

import '../homepage/homepage.dart';
import 'login_flash_detail.dart';

class ConcernNotification extends StatefulWidget {
  final ConcernNotificationModel? concernNotificationModel;
  const ConcernNotification({Key? key, this.concernNotificationModel})
      : super(key: key);

  @override
  _ConcernNotificationState createState() => _ConcernNotificationState();
}

class _ConcernNotificationState extends State<ConcernNotification> {
  bool isProgressRunning = false;

  var location = Location();

  bool agree = false;

  Map<String, Uint8List> pdfFiles = {};
  bool enabled = false;
  bool isInternetCheck = false;

  // GPS check

  Future<void> enableLocation() async {
    location = Location();
    enabled = await location.serviceEnabled();
  }

  @override
  void initState() {
    super.initState();
    enableLocation();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.concernNotificationModel?.status == "true"
          ? widget.concernNotificationModel?.concernNotifDetail![0]
                      .conNotifBgColor !=
                  null
              ? Color(int?.tryParse(
                  "0xFF${widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.substring(1, widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.length)}")!)
              : const Color(0xFFF5F5F5)
          : const Color(0xFFF5F5F5),
      bottomSheet: widget.concernNotificationModel?.concernNotifDetail?[0]
                  .conNotifLabel !=
              null
          ? Container(
              color: widget.concernNotificationModel?.status == "true"
                  ? widget.concernNotificationModel?.concernNotifDetail![0]
                              .conNotifBgColor !=
                          null
                      ? Color(int?.tryParse(
                          "0xFF${widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.substring(1, widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.length)}")!)
                      : const Color(0xFFF5F5F5)
                  : const Color(0xFFF5F5F5),
              height: MediaQuery.of(context).size.height * 0.15,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, right: 15, bottom: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            activeColor: ColorConstant.COLOR_LIGHT_BLACK,
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'I have read and accept ',
                                style: const TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'terms and conditions',
                                      style: const TextStyle(
                                          color: ColorConstant.THEME_COLOR_RED,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _launchURL();
                                          log('Tap Here onTap');
                                        }),
                                ],
                              ),
                            ),
                          ), // const Text(
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: agree ? declineDoSomething : null,
                              child: MaterialButton1(
                                  color1: agree
                                      ? ColorConstant.COLOR_LIGHT_BLACK
                                      : ColorConstant.COLOR_LIGHT_BLACK
                                          .withOpacity(0.4),
                                  height1: 44,
                                  txt1: 'Decline'),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: agree ? _agreeDoSomething : null,
                              child: MaterialButton1(
                                  color1: agree
                                      ? ColorConstant.COLOR_LIGHT_BLACK
                                      : ColorConstant.COLOR_LIGHT_BLACK
                                          .withOpacity(0.4),
                                  height1: 44,
                                  txt1: 'Agree'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              color: widget.concernNotificationModel?.status == "true"
                  ? widget.concernNotificationModel?.concernNotifDetail![0]
                              .conNotifBgColor !=
                          null
                      ? Color(int?.tryParse(
                          "0xFF${widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.substring(1, widget.concernNotificationModel?.concernNotifDetail![0].conNotifBgColor?.length)}")!)
                      : const Color(0xFFF5F5F5)
                  : const Color(0xFFF5F5F5),
              height: MediaQuery.of(context).size.height * 0.12,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      // enabled: isProgressRunning,
                      child: Container(
                        height: 17,
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
                    //
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        Expanded(
                          child: ShimmerEffectLineByLine(
                            // width1: MediaQuery.of(context).size.width * 0.15,
                            height1: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ShimmerEffectLineByLine(
                            // width1: MediaQuery.of(context).size.width * 0.1,
                            height1: 44.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 55, 12, 150),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                if (widget.concernNotificationModel?.status == "true" ||
                    isProgressRunning) ...{
                  if (widget.concernNotificationModel?.concernNotifDetail?[0]
                          .conNotifLabel !=
                      null)
                    Image.asset(
                      ImgConstants.CONTRACT_ICON,
                      height: MediaQuery.of(context).size.height * 0.20,
                    )
                  else ...{
                    Center(
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
                  },

                  const SizedBox(
                    height: 30,
                  ),

                  if (widget.concernNotificationModel?.concernNotifDetail?[0]
                          .conNotifLabel !=
                      null) ...{
                    Center(
                      child: Text(
                        widget.concernNotificationModel?.concernNotifDetail?[0]
                                .conNotifLabel ??
                            '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Sofia",
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF424242),
                        ),
                      ),
                    )
                  } else ...{
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 0),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        // enabled: boardingModel?.status == "true",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.56,
                                height: 22.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  },

                  const SizedBox(
                    height: 25,
                  ),

                  // Content Show
                  if (widget.concernNotificationModel?.status == "true") ...{
                    Text(
                      widget.concernNotificationModel?.concernNotifDetail?[0]
                              .conNotifContent ??
                          '',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF424242),
                      ),
                    ),
                  } else ...{
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
                  },

                  const SizedBox(
                    height: 60,
                  ),

                  if (widget.concernNotificationModel?.concernNotifDetail?[0]
                          .conNotifLabel !=
                      null) ...{
                    InkWell(
                      onTap: () async {
                        var pdfViewer = await fetchAWS3PDF(widget
                            .concernNotificationModel?.concernNotifDetail?[0].conNotifPdf ?? '');
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                actionsPadding: const EdgeInsets.all(0),
                                buttonPadding: const EdgeInsets.all(0),
                                insetPadding: const EdgeInsets.all(0),
                                titlePadding: const EdgeInsets.all(0),
                                contentPadding: const EdgeInsets.all(0),
                                content: SizedBox(
                                  height: 200,
                                  child: pdfViewer,
                                )));
                      },
                      child: const MaterialButton1(
                        height1: 56,
                        txt1: 'View PDF',
                      ),
                    ),
                  } else ...{
                    const ShimmerEffectLineByLine(
                      width1: double.infinity,
                      height1: 56.0,
                    ),
                  }
                }
                //
                //

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
                      color: ColorConstant.COLOR_TEXT,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),
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
                      height1: 55,
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

  Future<PdfViewer> fetchAWS3PDF(String pdfFileLink) async {
    const region = "eu-west-2";
    const bucketId = "wystle";
    final AwsS3Client s3client = AwsS3Client(
        region: region,
        host: "s3.eu-west-2.amazonaws.com",
        bucketId: bucketId,
        accessKey: "AKIAQ4UXMACGEPN4A7EK",
        secretKey: "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");
    final listBucketResult = await s3client.listObjects(
       prefix: "Wystle/Admin/rider-app/on-boarding/concern-notification",
        // prefix:
            // "Wystle/Admin/rider-app/on-boarding/concern-notification/JCYqueAOCqonCiMQ/JCYqueAOCqonCiMQ_sp_data_export_1645446777275.pdf",
        delimiter: "/");

     final response = await s3client.getObject(pdfFileLink);

    // Example for fetching PDF
    // final response = await s3client.getObject(
    //     "Wystle/Admin/rider-app/on-boarding/concern-notification/JCYqueAOCqonCiMQ/JCYqueAOCqonCiMQ_sp_data_export_1645446777275.pdf");

    // https://s3.eu-west-2.amazonaws.com/wystle/Wystle/Admin/rider-app/on-boarding/concern-notification/JCYqueAOCqonCiMQ/JCYqueAOCqonCiMQ_sp_data_export_1645446777275.pdf
    log(response.body);
    log(response.bodyBytes.toString());
    log(response.statusCode.toString());
    setState(() {
      pdfFiles["concern-notification"] = response.bodyBytes;
    });

    // String? dir = (await getDownloadsDirectory())?.path;
    String dir = (await getApplicationDocumentsDirectory()).path;
    log(dir);
    File file = File('$dir/terms&conditions.pdf');
    File downloadFile = await file.writeAsBytes(response.bodyBytes);
    log(downloadFile.path);
    return PdfViewer(path: downloadFile.path);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => PdfViewer(path: downloadFile.path)));
  }

  // This function is triggered when the button is clicked
  void _agreeDoSomething() async {
    // Do something
    EasyLoading.show(status: 'loading...');

    var location = Location();
    bool enabled = await location.serviceEnabled();

    if (!enabled) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const LocationCustom(
            screenname: ConcernNotification(),
          ),
        ),
        (route) => false,
      );
    } else {
      LoginFlashModel? loginFlashModel = await APIServices.getLoginFlashAPI();
      if (loginFlashModel.status == 'true' || enabled) {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginFlashScreen(
                    loginFlashModel: loginFlashModel,
                  )),
        );
      } else {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage2()),
        );
      }

      log("agree click");
    }
  }

  void declineDoSomething() {
    // Do something
    log("decline click");
  }

  // URL LAUNCHER

  _launchURL() async {
    var url =
        '${widget.concernNotificationModel?.concernNotifDetail?[0].conNotifUrl}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Internet Check
  Future<void> checkInternet() async {
    isInternetCheck = await InternetUtils.internetCheck();
    if (isInternetCheck) {
      // log("Internet is connected");
    } else {
      InternetUtils.networkErrorDialog(context);
      // log("Internet is not connected");
    }
  }
}
