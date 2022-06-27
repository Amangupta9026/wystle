import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/auth/email_otp.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../model/verify_registry_model.dart';
import '../service/api_services.dart';

// User Form Fill First Name, Last Name, Email

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

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

  // bool _isValid = false;

  // void _saveForm() {
  //   if (_form.currentState!.validate()) {
  //     setState(() {
  //       _isValid = _form.currentState!.validate();
  //       // showAlertDialog(context);
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => EmailSent()),
  // );
  //     });
  //   }
  // }

  // Future<void> _apiRegistration(
  //     String emailId, String firstName, String lastName) async {
  //   try {
  //     setState(() {
  //       isProgressRunning = true;
  //     });
  //     Map _body = {
  //       "email": emailId,
  //       "firstname": firstName,
  //       "lastname": lastName
  //     };
  //     verifyRegisterModel =
  //         await APIServices.getVerifyEmailOTPRegisterAPI(_body);
  //     if (verifyRegisterModel?.status == "true") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => EmailOTPScreen(
  //                   emailid: emailId,
  //                   verificationCode: verifyRegisterModel?.verificationCode,
  //                   message: verifyRegisterModel?.message,
  //                   firstName: firstNameController.text,
  //                   lastName: lastNameController.text,
  //                 )),
  //       );
  //     } else {
  //       showAlertDialog(context, verifyRegisterModel!.message.toString());
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
  void initState() {
    super.initState();
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
                    // child: Image.asset(
                    //   ImgConstants.BACKGROUNG_IMAGE,
                    //   height: MediaQuery.of(context).size.height * 0.6,
                    //   width: double.infinity,
                    //   fit: BoxFit.fitWidth,
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25.0, 240, 25, 60),
                    child: Container(
                      decoration: const BoxDecoration(
                        // border: Border.all(
                        //     color: ColorConstant.COLOR_ORIGINAL_GREY),
                        // borderRadius: BorderRadius.only(
                        //   topRight: Radius.circular(15),
                        //   topLeft: Radius.circular(15),
                        // ),
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
                                        color: ColorConstant.COLOR_BLACK,
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
                                height: 10,
                              ),

                              TextFieldWithOnlyPlaceHolder(
                                text1: 'Enter first name',
                                controller1: firstNameController,
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              TextFieldWithOnlyPlaceHolder(
                                text1: 'Enter last name',
                                controller1: lastNameController,
                              ),

                              // TextFieldWithOnlyPlaceHolder(
                              //   text1: 'Enter email id',
                              //   controller1: emailController,
                              // ),

                              const SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                // autofocus: true,
                                // autovalidateMode: AutovalidateMode.always,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                controller: emailController,

                                cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
                                decoration: InputDecoration(
                                  // suffixIcon: TextButton(
                                  //     onPressed: () {
                                  //       _saveForm();
                                  //     },
                                  //     child: const Text('Validate')),
                                  hintText: 'Enter your email id',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
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
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: ColorConstant.COLOR_LIGHT_BLACK,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                // validator: (value) {
                                //   // Check if this field is empty
                                //   if (value == null || value.isEmpty) {
                                //     return 'This field is required';
                                //   }

                                //   // using regular expression
                                //   if (!RegExp(r'\S+@\S+\.\S+')
                                //       .hasMatch(value)) {
                                //     return "Please enter a valid email address";
                                //   }

                                //   // the email is valid
                                //   return null;
                                // },
                                onChanged: (value) {
                                  log(value);
                                  setState(() {
                                    log(value);
                                  });
                                },
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              if (firstNameController.text.isNotEmpty &&
                                  lastNameController.text.isNotEmpty &&
                                  emailController.text.isNotEmpty) ...{
                                InkWell(
                                  onTap: () async {
                                    VerifyRegisterModel verifyRegisterModel =
                                        await APIServices.getVerifyRegisterAPI(
                                      emailController.text,
                                      firstNameController.text,
                                      lastNameController.text,
                                    );

                                    if (verifyRegisterModel.status == 'true') {
                                      
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmailOTPScreen(
                                                  emailid: emailController.text,
                                                  verificationCode:
                                                      verifyRegisterModel
                                                          .verificationCode,
                                                  firstName: firstNameController.text,
                                                  lastName: lastNameController.text,
                                                  message: verifyRegisterModel.message ?? 'Please check your email and verify your account',
                                                
                                                )),
                                      );
                                    } else {
                                      showAlertDialog(context,
                                          verifyRegisterModel.message!);
                                    }

                                    // _saveForm();

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => const HomePage2(
                                    //           // mobileNumber: phoneController!.text,
                                    //           )),
                                    // );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 0.0, right: 0),
                                    child: MaterialButton1(
                                      txt1: "NEXT",
                                      height1: 56,
                                      width1: double.infinity,
                                      // color1: ColorConstant.COLOR_LIGHT_BLACK,
                                    ),
                                  ),
                                )
                              } else ...{
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 0.0, right: 0),
                                  child: MaterialButton1(
                                    txt1: "NEXT",
                                    height1: 56,
                                    width1: double.infinity,
                                    color1: ColorConstant.COLOR_ORIGINAL_GREY,
                                  ),
                                ),
                              },

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
