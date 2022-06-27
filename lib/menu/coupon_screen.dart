import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';

import '../widget/reusubility_button.dart';

class CouponScreen extends StatelessWidget {
  CouponScreen({Key? key}) : super(key: key);
  final TextEditingController? subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20, 0, 0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: ColorConstant.COLOR_BLACK,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coupons',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFieldWithOnlyPlaceHolder(
                          controller1: subjectController,
                          text1: 'Subject',
                          keyboardType1: TextInputType.text,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        log('fff');
                        // Fluttertoast.showToast(
                        //   msg: 'GeeksforGeeks',
                        //   backgroundColor: Colors.grey,
                        // );

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Promo Code Applied")));
                      },
                      child: MaterialButton1(
                        height1: MediaQuery.of(context).size.height * 0.063,
                        width1: MediaQuery.of(context).size.width * 0.2,
                        txt1: 'Apply',
                        color1: ColorConstant.COLOR_BLACK,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Center(
                  child: Image.asset(
                    ImgConstants.PROMO_CODE2,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.height * 0.4,
                    
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'No Coupon Available',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: ColorConstant.COLOR_BLACK,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
