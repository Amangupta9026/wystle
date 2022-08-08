import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../../constant/color_constant.dart';

class Receipt extends StatelessWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Receipt',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const MaterialButton1(
            height1: 48,
            txt1: 'Close',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning,
                  size: MediaQuery.of(context).size.width * 0.17),
              const SizedBox(height: 15),
              Center(
                child: Text('No receipt available',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w600)),
              ),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 40, right: 40),
                  child: Text(
                      "You'll get your receipt when we process your payment, or within 24 hours if you have already paid. Please, check back later.",
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
