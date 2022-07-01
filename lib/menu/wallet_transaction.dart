import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';

import '../widget/appbar_widget.dart';

class WalletTransaction extends StatelessWidget {
  const WalletTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30, left: 15.0, right: 15, bottom: 80),
            child: Column(
              children: [
                const AppBarWidget(
                  title: 'Wallet Transactions',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.26,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImgConstants.ONBOARDING1,
                        height: 120,
                        width: 120,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Whoops!',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorConstant.COLOR_ORIGINAL_GREY,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'No Transactions Currently',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w400,
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
