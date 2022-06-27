import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constant/color_constant.dart';
import '../widget/reusubility_button.dart';

class AddCard extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  AddCard({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.fromLTRB(35.0, 20, 35, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Card',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Card holder name',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFieldWithOnlyPlaceHolder(
                  // controller1: subjectController,
                  text1: 'Card holder name',
                  keyboardType1: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Card number',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFieldWithOnlyPlaceHolder(
                  // controller1: subjectController,
                  text1: 'Card number',
                  keyboardType1: TextInputType.text,
                ),

                // Expiry Date

                const SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _controller, //<-- Add controller here
                            onChanged: (value) {
                              //   if (value.length == 2)
                              //     _controller.text +=
                              //         "/"; //<-- Automatically show a '/' after dd
                              //   //  donation.date = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry Date',
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 40,
                            child: TextFieldWithOnlyPlaceHolder(
                              // controller1: subjectController,
                              text1: 'Subject',
                              keyboardType1: TextInputType.text,
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
