import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../../constant/color_constant.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
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
        title: Text('Feedback',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 20, 15, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("What's the primary reason for your rating?",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w300)),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("My issue was different",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("Instructions were too complicated",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("I don't like the policy",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("The instructions didn't work",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("My issue was only partially resolved",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text("Other",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w300))),
                const Divider(
                    thickness: 0.7, color: ColorConstant.COLOR_ORIGINAL_GREY),
                const SizedBox(height: 10),
                const SizedBox(height: 40),
                const MaterialButton1(
                  txt1: 'Submit',
                  height1: 44,
                  width1: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
