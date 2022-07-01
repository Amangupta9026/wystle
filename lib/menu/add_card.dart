import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../constant/color_constant.dart';
import '../widget/appbar_widget.dart';
import '../widget/reusubility_button.dart';
import '../widget/toast_widget.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController controller = TextEditingController();

  // TextEditingController expiryDateController = TextEditingController();
  var expiryDateController = MaskedTextController(mask: '00/00');
  var cvvController = MaskedTextController(mask: '000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35.0, 30, 35, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarWidget(
                  text1: 'Add Card',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Card holder name',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
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
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ColorConstant.COLOR_BLACK,
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
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // const SizedBox(
                          // height: 50,
                          //   child: TextFieldWithOnlyPlaceHolder(
                          //     // controller1: subjectController,
                          //     text1: 'Expiry Date',
                          //     keyboardType1: TextInputType.number,
                          //   ),
                          // ),

                          SizedBox(
                            height: 50,
                            child: Material(
                              elevation: 2.0,
                              shadowColor: ColorConstant.COLOR_ORIGINAL_GREY,

                              //  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: TextFormField(
                                controller: expiryDateController,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
                                minLines: 1,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabled: true,
                                  hintText: 'MM/YY',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(
                                        color:
                                            ColorConstant.COLOR_ORIGINAL_GREY,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3,
                                        color: ColorConstant.COLOR_LIGHT_BLACK),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.length == 2) {
                                    expiryDateController.text += "/";
                                    expiryDateController.text = value;
                                  }
                                },
                              ),
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
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: ColorConstant.COLOR_BLACK,
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
                    showDefaultSnackbar(context, 'Card Added Successfully');
                  },
                  child: const MaterialButton1(
                    height1: 48,
                    txt1: 'SAVE',
                    color1: ColorConstant.THEME_COLOR_RED,
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
