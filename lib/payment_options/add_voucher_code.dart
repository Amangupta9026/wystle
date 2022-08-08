import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';
import 'package:wystle/widget/reusubility_button.dart';

class AddVoucherCode extends StatefulWidget {
  const AddVoucherCode({Key? key}) : super(key: key);

  @override
  State<AddVoucherCode> createState() => _AddVoucherCodeState();
}

class _AddVoucherCodeState extends State<AddVoucherCode> {
  TextEditingController? voucherController = TextEditingController();

  @override
  void dispose() {
    try {
      voucherController?.dispose();
    } catch (e) {
      log(e.toString());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_WHITE,
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 15),
        child: MaterialButton1(
          txt1: 'Continue',
          height1: 44,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15, 15.0, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Voucher Code',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 5),
                TextFormField(
                    controller: voucherController,
                    decoration: InputDecoration(
                        hintText: 'Voucher Code',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorConstant.COLOR_BLACK),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: ColorConstant.COLOR_BLACK),
                        ),
                        suffixIcon: InkWell(
                          onTap: voucherController?.clear,
                          child: const Icon(Icons.close,
                              color: ColorConstant.COLOR_BLACK),
                        ))),
                const SizedBox(height: 20),
                Text('Enter the code in order to claim and use your voucher',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
