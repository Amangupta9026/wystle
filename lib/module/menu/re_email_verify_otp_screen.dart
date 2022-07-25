import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../constant/color_constant.dart';
import '../../model/email_verify_success_model.dart';
import '../../model/verify_registry_model.dart';
import '../../service/api_constants.dart';
import '../../service/api_services.dart';
import '../../widget/reusubility_button.dart';
import '../../widget/toast_widget.dart';
import '../homepage/homepage.dart';
import '../sharedpreference/shared_preference.dart';
import '../sharedpreference/userdata.dart';

class ReEmailVerifyOTPScreen extends StatefulWidget {
  final VerifyRegisterModel? verifyRegisterModel;
  const ReEmailVerifyOTPScreen({Key? key, this.verifyRegisterModel})
      : super(key: key);

  @override
  State<ReEmailVerifyOTPScreen> createState() => _ReEmailVerifyOTPScreenState();
}

class _ReEmailVerifyOTPScreenState extends State<ReEmailVerifyOTPScreen> {
  var userdata = UserData.geUserData();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter the 4-digit code sent to you at ${userdata.email}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_ORIGINAL_GREY,
                        fontWeight: FontWeight.w500,
                      )),
              const SizedBox(
                height: 20,
              ),
              TextFieldWithOnlyPlaceHolder(
                text1: 'Enter OTP',
                controller1: otpController,
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (otpController.text.isEmpty) {
                    toastshowDefaultSnackbar(context, 'Please enter OTP');
                  } else if (otpController.text ==
                      widget.verifyRegisterModel?.verificationCode) {
                    EasyLoading.show(status: 'loading...');

                    EmailVerifiedSuccessModel emailVerifiedSuccessModel =
                        await APIServices.getVerifiedEmailSuccessAPI(
                            userdata.userid!);
                    if (emailVerifiedSuccessModel.status == 'true') {
                      EasyLoading.dismiss();
                      SharedPreference.setValue(
                          PrefConstants.USER_EMAIL_VERIFY_TAG, 'done');
                      toastshowDefaultSnackbar(context, 'Email verified');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage2()),
                      );
                    } else {
                      EasyLoading.dismiss();
                      toastshowDefaultSnackbar(context, 'Please enter OTP');
                    }
                  } else {
                    toastshowDefaultSnackbar(
                        context, 'Please enter correct OTP');
                  }
                },
                child: const MaterialButton1(
                  txt1: 'Submit',
                  height1: 46,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  bottomSheetModalDown();
                },
                child: Text(
                  "I'm having trouble",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: ColorConstant.COLOR_BLUE.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomSheetModalDown() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.38,
            decoration: const BoxDecoration(color: ColorConstant.COLOR_WHITE),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Can't find code?",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "If you dont't see the email, check your spam folder or resend the email. If you are still having trouble, contact support.",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                  const SizedBox(height: 20),
                  const MaterialButton1(
                    height1: 46,
                    txt1: 'Resend email',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.COLOR_BLACK),
                    ),
                    child: Text(
                      'Contact support',
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
