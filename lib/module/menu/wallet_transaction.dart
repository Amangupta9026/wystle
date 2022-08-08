import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/constant/image_constant.dart';

class WalletTransaction extends StatelessWidget {
  const WalletTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_WHITE,
            size: 25,
          ),
        ),
        title: Text('Wallet Transaction',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 15.0, right: 15, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  ImgConstants.ONBOARDING1,
                  height: 120,
                  width: 120,
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
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
