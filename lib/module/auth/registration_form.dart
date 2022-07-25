import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../model/verify_registry_model.dart';
import '../../service/api_services.dart';
import '../../widget/toast_widget.dart';
import 'email_otp.dart';

// User Form Fill First Name, Last Name, Email

class RegistrationForm extends StatefulWidget {
  final String? mobileNumber;
  const RegistrationForm({Key? key, this.mobileNumber}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _form = GlobalKey<FormState>();
  bool isProgressRunning = false;
  VerifyRegisterModel? verifyRegisterModel;

 @override
  void dispose() {
    try {
      firstNameController.dispose();
      lastNameController.dispose();
      emailController.dispose();
    } catch (e) {
      log(e.toString(), name: 'RegistrationForm');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.BACKGROUND_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
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
                    padding: const EdgeInsets.fromLTRB(25.0, 240, 25, 60),
                    child: Container(
                      decoration: const BoxDecoration(
                       
                        color: ColorConstant.COLOR_WHITE,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                child: Text(
                                  "Tell us about yourself",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Text(
                                "Let us know about you so we can personalize your experience.",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),

                              // TextField for first name

                              const SizedBox(
                                height: 20,
                              ),

                              TextFieldWithOnlyPlaceHolder(
                                text1: 'Enter first name',
                                controller1: firstNameController,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              TextFieldWithOnlyPlaceHolder(
                                text1: 'Enter last name',
                                controller1: lastNameController,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              TextFieldWithOnlyPlaceHolder(
                                text1: 'Enter email id',
                                controller1: emailController,
                              ),

                              InkWell(
                                onTap: () async {
                                  if (firstNameController.text.isEmpty &&
                                      lastNameController.text.isEmpty &&
                                      emailController.text.isEmpty) {
                                    toastshowDefaultSnackbar(
                                        context, 'Please fill all the fields');
                                  } else if (firstNameController.text.isEmpty) {
                                    toastshowDefaultSnackbar(
                                        context, 'Please enter first name');
                                  } else if (lastNameController.text.isEmpty) {
                                    toastshowDefaultSnackbar(
                                        context, 'Please enter last name');
                                  } else if (emailController.text.isEmpty) {
                                    toastshowDefaultSnackbar(
                                        context, 'Please enter email id');
                                  } else if (firstNameController
                                          .text.isNotEmpty &&
                                      lastNameController.text.isNotEmpty &&
                                      emailController.text.isNotEmpty) {
                                    EasyLoading.show(status: 'loading...');
                                    VerifyRegisterModel verifyRegisterModel =
                                        await APIServices.getVerifyRegisterAPI(
                                      emailController.text,
                                      firstNameController.text,
                                      lastNameController.text,
                                    );
                                    if (verifyRegisterModel.status == 'true') {
                                      EasyLoading.dismiss();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmailOTPScreen(
                                                  verifyRegisterModel:
                                                      verifyRegisterModel,
                                                  emailid: emailController.text,
                                                  firstName:
                                                      firstNameController.text,
                                                  lastName:
                                                      lastNameController.text,
                                                  message: verifyRegisterModel
                                                          .message ??
                                                      'Please check your email and verify your account',
                                                  mobile: widget.mobileNumber,
                                                )),
                                      );
                                    } else {
                                      EasyLoading.dismiss();
                                      toastshowDefaultSnackbar(
                                          context, verifyRegisterModel.message);
                                    }
                                  }
                                },
                                // onTap: () async {

                                //   VerifyRegisterModel verifyRegisterModel =
                                //       await APIServices.getVerifyRegisterAPI(
                                //     emailController.text,
                                //     firstNameController.text,
                                //     lastNameController.text,
                                //   );

                                //   if (verifyRegisterModel.status == 'true') {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               EmailOTPScreen(
                                // verifyRegisterModel:
                                //     verifyRegisterModel,
                                // emailid: emailController.text,
                                // firstName:
                                //     firstNameController.text,
                                // lastName:
                                //     lastNameController.text,
                                // message: verifyRegisterModel
                                //         .message ??
                                //     'Please check your email and verify your account',
                                // mobile: widget.mobileNumber,
                                //               )),
                                //     );
                                //   } else {
                                //     showAlertDialog(context,
                                //         verifyRegisterModel.message!);
                                //   }

                                // },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 0.0, right: 0),
                                  child: MaterialButton1(
                                    txt1: "NEXT",
                                    height1: 56,
                                    width1: double.infinity,
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 35,
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
