import 'package:flutter/material.dart';

import '../constant/color_constant.dart';

class MaterialButton1 extends StatelessWidget {
  final String? txt1;
  final double? height1;
  final double? width1;
  final Icon? icon1;
  final Color? color1;
  final Color? textColor1;

  const MaterialButton1(
      {Key? key,
      this.txt1,
      this.height1,
      this.width1,
      this.icon1,
      this.color1,
      this.textColor1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height1,
      width: width1,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        color: color1 ?? ColorConstant.COLOR_LIGHT_BLACK,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon1 != null) ...{
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: SizedBox(),
              ),
            },
            Text(
              txt1.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: textColor1 ?? ColorConstant.COLOR_WHITE,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            if (icon1 != null) ...{
              const Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      icon1?.icon,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              )
            },
          ],
        ),
      ),
    );
  }
}

// Button with text and icon and border only

class MaterialButtonWithIcon extends StatelessWidget {
  final String? txt1;
  final Icon? icon1;
  const MaterialButtonWithIcon({Key? key, this.txt1, this.icon1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration:
          BoxDecoration(border: Border.all(color: ColorConstant.COLOR_BLACK)),
      child: Row(
        children: [
          Icon(
            icon1!.icon,
            color: Colors.blue,
          ),
          const Spacer(),
          Center(
            child: Text(
              txt1.toString(),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class TextFieldWithPlaceholder extends StatelessWidget {
  final String? text1;
  final String? text2;
  final bool? obscuretext;
  const TextFieldWithPlaceholder(
      {Key? key, this.text1, this.text2, this.obscuretext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
          obscureText: obscuretext ?? false,
          cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
          // keyboardType: TextInputType.,
          decoration: InputDecoration(
            labelText: text1.toString(),
            labelStyle: const TextStyle(
              color: ColorConstant.COLOR_LIGHT_BLACK,
              fontWeight: FontWeight.w600,
            ),
            hintText: text2.toString(),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.COLOR_LIGHT_BLACK)),
            border: const OutlineInputBorder(borderSide: BorderSide()),
          )),
    );
  }
}

class TextFieldWithLabel extends StatelessWidget {
  final String? text1;
  const TextFieldWithLabel({Key? key, this.text1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: TextFormField(
          cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: text1.toString(),
            labelStyle: const TextStyle(
              color: ColorConstant.COLOR_LIGHT_BLACK,
              fontWeight: FontWeight.w600,
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstant.COLOR_LIGHT_BLACK)),
            border: const OutlineInputBorder(borderSide: BorderSide()),
          )),
    );
  }
}

// TextField only hint

class TextFieldWithOnlyPlaceHolder extends StatelessWidget {
  final String? text1;
  final TextInputType? keyboardType1;
  final TextEditingController? controller1;
  final bool? enabledTextField;
  final int? minlines;
  final int? maxlines;
  const TextFieldWithOnlyPlaceHolder(
      {Key? key,
      this.text1,
      this.controller1,
      this.keyboardType1,
      this.enabledTextField,
      this.minlines,
      this.maxlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: ColorConstant.COLOR_BLACK)),
      child: TextFormField(
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: ColorConstant.COLOR_TEXT,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
        controller: controller1,
        cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
        minLines: minlines ?? 1,
        maxLines: maxlines ?? 1,
        keyboardType: keyboardType1 ?? TextInputType.name,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          // isDense: true,
          enabled: enabledTextField ?? true,
          hintText: text1.toString(),
          hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: ColorConstant.COLOR_ORIGINAL_GREY,
                fontWeight: FontWeight.w400,
              ),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
