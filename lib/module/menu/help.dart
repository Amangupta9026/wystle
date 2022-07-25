import 'package:flutter/material.dart';

import '../../constant/color_constant.dart';
import '../../widget/reusubility_button.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({Key? key}) : super(key: key);
  final TextEditingController? subjectController = TextEditingController();
  final TextEditingController? writeMessageController = TextEditingController();

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
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: ColorConstant.COLOR_BLACK,
            ),
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            'Help',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 40, 25, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send us a mail',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 6,
                ),
                TextFieldWithOnlyPlaceHolder(
                  controller1: subjectController,
                  text1: 'Subject',
                  keyboardType1: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWithOnlyPlaceHolder(
                  controller1: writeMessageController,
                  text1: 'Write your message',
                  keyboardType1: TextInputType.multiline,
                  minlines: 5,
                  maxlines: 5,
                ),
                const SizedBox(
                  height: 30,
                ),
                const MaterialButton1(
                  height1: 50,
                  txt1: 'Send',
                  color1: ColorConstant.COLOR_LIGHT_BLACK,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // launchUrl(("tel://21213123123"));
                      },
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.COLOR_ORIGINAL_GREY
                                  .withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 3.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_in_talk,
                              size: MediaQuery.of(context).size.width * 0.12,
                              color: ColorConstant.THEME_COLOR_RED,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Call',
                              style:
                                  Theme.of(context).textTheme.subtitle2?.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w300,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: ColorConstant.COLOR_WHITE,
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstant.COLOR_ORIGINAL_GREY
                                .withOpacity(0.3),
                            offset: const Offset(0, 0),
                            blurRadius: 3.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            size: MediaQuery.of(context).size.width * 0.12,
                            color: ColorConstant.THEME_COLOR_RED,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Chat',
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
