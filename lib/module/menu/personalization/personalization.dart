import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../../../constant/color_constant.dart';

class Personalization extends StatefulWidget {
  const Personalization({Key? key}) : super(key: key);

  @override
  State<Personalization> createState() => _PersonalizationState();
}

class _PersonalizationState extends State<Personalization> {
  double lvalue = 0.0;
  double uvalue = 10.0;
  RangeValues values = const RangeValues(16.0, 25.0);

  double count = 4.0; // Slider 1

  bool isSwitched = false;

  var textValue = 'OFF';
  String? _dropDownValue;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'ON';
      });
      log('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'OFF';
      });
      log('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_BLACK,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: ColorConstant.COLOR_WHITE,
            size: 25,
          ),
        ),
        title: Text('Personalization',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: ColorConstant.COLOR_WHITE, fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Personalization',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w600)),
                      Transform.scale(
                          scale: 1,
                          child: Switch(
                              onChanged: toggleSwitch,
                              value: isSwitched,
                              activeColor: ColorConstant.COLOR_TEXT,
                              activeTrackColor: ColorConstant
                                  .COLOR_ORIGINAL_GREY
                                  .withOpacity(0.5),
                              inactiveThumbColor: ColorConstant.COLOR_TEXT,
                              inactiveTrackColor:
                                  ColorConstant.COLOR_LIGHT_GREY2)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Visibility(
                    visible: isSwitched,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                          child: Text('Music Confort',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10, left: 20, right: 20),
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstant.COLOR_BLACK)),
                            child: DropdownButton(
                              underline: const SizedBox(),
                              hint: _dropDownValue == null
                                  ? Text(
                                      'Select Music',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                            color: ColorConstant
                                                .COLOR_ORIGINAL_GREY,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    )
                                  : Text(
                                      _dropDownValue.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                            color: ColorConstant.COLOR_TEXT,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                  ),
                              items: [
                                'Popular Music',
                                'POP',
                                'Jazz',
                                'Hip hop',
                                'Classical',
                                'Rock'
                              ].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = val.toString();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                          child: Text('Car Temperature',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SliderTheme(
                              data: const SliderThemeData(
                                trackHeight: 23.0,
                                thumbShape: CustomSliderThumbCircle(
                                  thumbRadius: 45 * .45,
                                  // min: 16,
                                  // max: 25,
                                  choice: Colors.purple,
                                ),
                              ),
                              child: Slider(
                                divisions: 10,
                                activeColor: Colors.purple,
                                inactiveColor: Colors.grey[350],
                                min: lvalue,
                                max: uvalue,
                                value: count,
                                onChanged: (value) {
                                  setState(() {
                                    count = value;
                                  });
                                },
                                onChangeEnd: (value) {
                                  log(value.toString());
                                  setState(() {
                                    count = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: MaterialButton1(
                            width1: MediaQuery.of(context).size.width * 0.6,
                            txt1: 'Save',
                            height1: 40,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double? thumbRadius;
  final int min;
  final int max;
  final Color? choice;

  const CustomSliderThumbCircle({
    this.thumbRadius,
    this.min = 16,
    this.max = 25,
    this.choice,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius!);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      // ..color = Colors.purple //Thumb Background Color
      ..color = choice!
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius! * .8,
        fontWeight: FontWeight.w700,
        //Text Color of Value on Thumb
        color: Colors.white,
      ),
      text: getValue(value!),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius! * .6, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }
}
