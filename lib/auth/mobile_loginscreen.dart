import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../utils/utils.dart';
import 'otp_screen.dart';

class MobileLoginScreen extends StatefulWidget {
  final double? latitude1;
  final double? longitude1;
  const MobileLoginScreen({Key? key, this.latitude1, this.longitude1})
      : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  final TextEditingController _phoneController = TextEditingController();
  bool isOnline = false;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    super.initState();
    checkInternet();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 60),
          child: loginUI(context),
        ),
      ),
    ));
  }

  Column loginUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Center(
        //   child: SvgPicture.asset(
        //     ImgConstants.WYSTLEARRIVESMARTER,
        //     // height: 210,
        //     width: 250,

        //     // fit: BoxFit.cover,
        //   ),
        // ),
        Center(
          child: Image.asset(
            ImgConstants.WYSTLEARRIVESMARTER,
            // height: 160,
            width: 230,

            // color: Colors.red,
          ),
        ),

        // const SizedBox(
        //   height: 20,
        // ),

        const Text(
          "Enter your mobile number",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Drop Down

        IntlPhoneField(
          initialCountryCode: 'uk',
          initialValue: "44",
          controller: _phoneController,
          cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
          decoration: const InputDecoration(
            hintText: 'Enter your mobile number',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.COLOR_LIGHT_BLACK)),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          onChanged: (phone) {
            log(phone.completeNumber);
          },
          onCountryChanged: (country) {
            log('Country changed to: ' + country.name);
          },
        ),

        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       padding: const EdgeInsets.only(left: 5, right: 5),
        //       decoration: BoxDecoration(
        //           border: Border.all(
        //         color: Colors.black,
        //       )),
        //       width: 90,
        //       child: DropdownButton(
        //         underline: const SizedBox(),
        //         // Initial Value
        //         value: dropdownvalue,

        //         // Down Arrow Icon
        //         icon: const Icon(Icons.arrow_drop_down),

        //         // Array list of items
        //         items: items.map((String items) {
        //           return DropdownMenuItem(
        //             value: items,
        //             child: Text(items),
        //           );
        //         }).toList(),
        //         // After selecting the desired option,it will
        //         // change button value to selected value
        //         onChanged: (String? newValue) {
        //           setState(() {
        //             dropdownvalue = newValue!;
        //           });
        //         },
        //       ),
        //     ),

        //     const SizedBox(
        //       width: 10,
        //     ),

        //     // TextField

        //     Expanded(
        //       child: Container(
        //         decoration: BoxDecoration(
        //             border: Border.all(
        //           color: Colors.black,
        //         )),
        //         child: TextFormField(
        //           cursorColor: Colors.black,
        //           validator: (value) {
        //             if (value!.isEmpty) {
        //               return 'Please enter some text';
        //             }
        //           },
        //           keyboardType: TextInputType.number,
        //           decoration: const InputDecoration(
        //             contentPadding: EdgeInsets.all(12.0),
        //             focusColor: Colors.black,
        //             hoverColor: Colors.black,
        //             border: InputBorder.none,

        //             fillColor: Colors.white,
        //             prefix: Text("+91 "),
        //             //  prefixIcon: "+91",
        //             hintText: 'Mobile Number',
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        const SizedBox(
          height: 20,
        ),

        // Button

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPScreen(
                        latitude1: widget.latitude1,
                        longitude1: widget.longitude1,
                        phonenumber: _phoneController.text.toString(),
                      )),
            );
          },
          child: const MaterialButton1(
            txt1: "Next",
            height1: 56,
            width1: double.infinity,
            //  icon1: Icon(Icons.arrow_forward),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Row(
        //   children: [
        //     Expanded(
        //       child: Container(
        //         height: 1,
        //         color: Colors.grey,
        //       ),
        //     ),
        //     const Text(
        //       " or ",
        //       style: TextStyle(fontSize: 14, color: Colors.grey),
        //     ),
        //     Expanded(
        //       child: Container(
        //         height: 1,
        //         color: Colors.grey,
        //       ),
        //     ),
        //   ],
        // ),

        // const SizedBox(
        //   height: 20,
        // ),

        // Button

        // Container(
        //   height: 55.0,
        //   width: double.infinity,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //     color: ColorConstant.COLOR_LIGHT_BLACK,
        //   ),
        //   child: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Image.asset(
        //           ImgConstants.GOOGLE_LOGO,
        //           height: 30,
        //           width: 30,
        //         ),
        //         const Center(
        //           child: Text(
        //             "  Sign in with Google",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 16.0,
        //                 letterSpacing: 1.1),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        // const SizedBox(
        //   height: 20,
        // ),

        // Button

        // Container(
        //   height: 55.0,
        //   width: double.infinity,
        //   decoration: const BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
        //     color: ColorConstant.COLOR_LIGHT_BLACK,
        //   ),
        //   child: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: const [
        //         Icon(
        //           Icons.facebook,
        //           color: Colors.blue,
        //           size: 28,
        //         ),
        //         Center(
        //           child: Text(
        //             "  Sign in with Facebook",
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 16.0,
        //                 letterSpacing: 1.1),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        const SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            ImgConstants.WYSTLEAPPICON2,
            height: 150,
            // width: 300,

            color: Colors.red,
          ),
        ),

        const Text(
          "By signing up, you agree to our Terms of Service and Privacy Policy, By signing up, you agree to our Terms of Service and Privacy Policy",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
