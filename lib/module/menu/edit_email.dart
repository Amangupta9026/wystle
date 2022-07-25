import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../widget/reusubility_button.dart';

class EditEmail extends StatefulWidget {
  const EditEmail({Key? key}) : super(key: key);

  @override
  State<EditEmail> createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFf9d915),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_BLACK,
            size: 28,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Row(
              children: [
                const Icon(
                  Icons.help,
                  color: ColorConstant.COLOR_BLACK,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "Support",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              bottom: 20,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Email",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFieldWithPlaceholder(
              text1: "Email",
              text2: "Enter your Email",
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorConstant.THEME_COLOR_RED),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 10, 25, 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.done,
                        color: ColorConstant.COLOR_WHITE,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
