import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../../constant/color_constant.dart';
import '../../widget/reusubility_button.dart';
import '../../widget/toast_widget.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController controller = TextEditingController();

  var expiryDateController = MaskedTextController(mask: '00/00');
  var cvvController = MaskedTextController(mask: '000');

  @override
  void dispose() {
    try {
      expiryDateController.dispose();
      cvvController.dispose();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

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
        title: Text('Add Card',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Card holder name',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
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
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
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
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant.COLOR_BLACK)),
                            child: TextFormField(
                              controller: expiryDateController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.none,
                                  ),
                              cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                hintText: 'MM/YY',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_ORIGINAL_GREY,
                                      fontWeight: FontWeight.w400,
                                    ),
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                if (value.length == 2) {
                                  expiryDateController.text += "/";
                                  expiryDateController.text = value;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CVV',
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFieldWithOnlyPlaceHolder(
                              controller1: cvvController,
                              text1: 'CVV',
                              keyboardType1: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Save Button

                const SizedBox(
                  height: 30,
                ),

                InkWell(
                  onTap: () {
                    toastshowDefaultSnackbar(
                        context, 'Card Added Successfully');
                  },
                  child: const MaterialButton1(
                    height1: 48,
                    txt1: 'SAVE',
                    color1: ColorConstant.COLOR_LIGHT_BLACK,
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
