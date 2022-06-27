import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class UtilsFlushBar {
  static void showDefaultSnackbar(BuildContext context, content) {
    // ignore: avoid_single_cascade_in_expression_statements
    Flushbar(
      message: content,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: ColorConstant.THEME_COLOR_RED,
      //  backgroundColor: Colors.purple,
      duration: const Duration(seconds: 2),
    )..show(context);
  }
}
