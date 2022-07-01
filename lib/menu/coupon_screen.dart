import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';

import '../widget/appbar_widget.dart';
import '../widget/reusubility_button.dart';
import '../widget/toast_widget.dart';

class CouponScreen extends StatelessWidget {
  CouponScreen({Key? key}) : super(key: key);
  final TextEditingController? subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWidget(
                  text1: 'Coupons',
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
                        showDefaultSnackbar(context, 'Promo Coupon Applied');
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
