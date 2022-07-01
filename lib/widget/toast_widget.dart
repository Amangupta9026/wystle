import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wystle/constant/color_constant.dart';

void showDefaultSnackbar(BuildContext context, content) {
  Fluttertoast.showToast(
      msg: content,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorConstant.COLOR_BLACK,
      textColor: Colors.white,
      fontSize: 14.0);
}
