import 'package:flutter/material.dart';
import 'package:wystle/module/menu/account_setting/ride_check.dart';

import '../../../constant/color_constant.dart';

class SafetySetting extends StatelessWidget {
  const SafetySetting({Key? key}) : super(key: key);

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
            child: const Icon(Icons.arrow_back,
                color: ColorConstant.COLOR_WHITE, size: 25)),
        title: Text('Safety',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              splashColor: ColorConstant.COLOR_LIGHT_GREY,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RideCheck(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Text("RideCheck",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Text("Manage your RideCheck notifications",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstant.COLOR_ORIGINAL_GREY,
                    fontWeight: FontWeight.w300)),
          ]),
        ),
      ),
    );
  }
}
