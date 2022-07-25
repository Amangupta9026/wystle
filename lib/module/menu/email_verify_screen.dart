import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wystle/module/menu/re_email_verify_otp_screen.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../constant/color_constant.dart';
import '../../model/verify_registry_model.dart';
import '../../service/api_services.dart';
import '../../widget/toast_widget.dart';
import '../sharedpreference/userdata.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  var userdata = UserData.geUserData();
  TextEditingController emailController = TextEditingController();
  VerifyRegisterModel? verifyRegisterModel;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: userdata.email ?? '');
  }

  @override
  void dispose() {
    try {
      emailController.dispose();
    } catch (e) {
      log(e.toString(), name: 'Profile');
    }
    super.dispose();
  }

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15.0, right: 15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Confirm your email address',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_ORIGINAL_GREY,
                        fontWeight: FontWeight.w500,
                      )),
              TextFormField(
                cursorColor: ColorConstant.COLOR_BLACK,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: '',
                  focusColor: ColorConstant.COLOR_BLACK,
                  hoverColor: ColorConstant.COLOR_BLACK,

                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.COLOR_BLACK),
                  ),

                  // errorText: _errorText,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (emailController.text.isEmpty) {
                    toastshowDefaultSnackbar(context, 'Please enter email id');
                  } else {
                    EasyLoading.show(status: 'loading...');

                    verifyRegisterModel =
                        await APIServices.getVerifyEmailRiderAPI(
                            userdata.userid!);
                    if (verifyRegisterModel?.status == 'true') {
                      EasyLoading.dismiss();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReEmailVerifyOTPScreen(
                                  verifyRegisterModel: verifyRegisterModel,
                                )),
                      );
                    }
                  }
                },
                child: const MaterialButton1(
                  txt1: 'Update',
                  color1: ColorConstant.COLOR_LIGHT_BLACK,
                  height1: 56,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
