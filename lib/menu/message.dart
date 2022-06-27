import 'package:flutter/material.dart';
import 'package:wystle/constant/color_constant.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.THEME_COLOR_RED,
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
        title: const Text(
          'Offers',
          style: TextStyle(
            color: ColorConstant.COLOR_WHITE,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_DARK_GREY,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstant.THEME_COLOR_RED),
                            height: 45,
                            width: 45,
                            child: const Icon(Icons.redeem),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            "50% off on First Ride",
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_BLACK,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          const Text(
                            "Get 50% cb up to Rs 75 on your first order. Use code: First50",
                            textAlign: TextAlign.center,
                            style:  TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          ////ElevatedButton(onPressed: (), child: child)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.THEME_COLOR_RED),
                      height: 45,
                      width: 45,
                      child: const Icon(Icons.currency_rupee),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  const [
                           Text(
                            "50% off with Amazon Pay",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_BLACK,
                            ),
                          ),
                           SizedBox(
                            height: 10,
                          ),
                           Text(
                            "Get 50% cb up to Rs 75 on your first order. Use code: Amz50",
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.COLOR_ORIGINAL_GREY,
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
