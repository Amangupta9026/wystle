// ignore_for_file: equal_elements_in_set

import 'package:flutter/material.dart';
import '../constant/color_constant.dart';

class AppBarWidget extends StatelessWidget {
  final String? text1;
  final String? title;
  const AppBarWidget({Key? key, this.text1, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 16,
                color: ColorConstant.COLOR_BLACK,
              ),
            ),
            if (title != null) ...{
              const Spacer(),
              Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Spacer(),
            }
          ],
        ),
        text1 != null
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    text1.toString(),
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
