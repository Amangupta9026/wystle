import 'package:flutter/material.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../constant/color_constant.dart';

class LoginWithPassword extends StatefulWidget {
  final String? phonenumber;
  const LoginWithPassword({Key? key, this.phonenumber}) : super(key: key);

  @override
  State<LoginWithPassword> createState() => _LoginWithPasswordState();
}

class _LoginWithPasswordState extends State<LoginWithPassword> {
  TextEditingController? textEditingController1;
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    textEditingController1?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15.0, right: 15, bottom: 80),
          child: Column(children: [
            const Text(
              "Welcome back",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: !_passwordVisible,
                cursorColor: ColorConstant.COLOR_LIGHT_BLACK,
                // keyboardType: TextInputType.,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: ColorConstant.COLOR_LIGHT_BLACK,
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: "Enter your password",
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorConstant.COLOR_LIGHT_BLACK)),
                  border: const OutlineInputBorder(borderSide: BorderSide()),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorConstant.COLOR_BLACK,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // I didn't get the code

            InkWell(
              onTap: () {
                //  _getPrizeBreakUpBottomSheet(context);
              },
              child: const MaterialButton1(
                height1: 45,
                color1: Colors.grey,
                txt1: "I forgot my password",
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const MaterialButton1(
                height1: 45,
                color1: Colors.grey,
                txt1: "I can't sign in",
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.095,
                  width: MediaQuery.of(context).size.width * 0.095,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),

                // Next

                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10, top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  // void _getPrizeBreakUpBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: false,
  //       backgroundColor: Colors.transparent,
  //       builder: (ctx) {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               // height: MediaQuery.of(context).size.height * 0.5,
  //               padding: const EdgeInsets.all(14.0),
  //               color: Colors.white,
  //               child: Column(
  //                 children: const [
  //                   SizedBox(height: 10),
  //                   MaterialButton1(
  //                     color1: ColorConstant.COLOR_LIGHT_GREY,
  //                     txt1: "Login with Google",
  //                     textColor1: ColorConstant.COLOR_BLACK,
  //                     height1: 55,
  //                   ),
  //                   SizedBox(height: 20),

  //                   MaterialButton1(
  //                     color1: ColorConstant.COLOR_LIGHT_GREY,
  //                     textColor1: ColorConstant.COLOR_BLACK,
  //                     txt1: "Call me with code",
  //                     height1: 55,
  //                   ),

  //                   SizedBox(height: 20),

  //                   MaterialButton1(
  //                     color1: ColorConstant.COLOR_LIGHT_GREY,
  //                     textColor1: ColorConstant.COLOR_BLACK,
  //                     txt1: "Resend code via SMS",
  //                     height1: 55,
  //                   ),

  //                   SizedBox(height: 20),

  //                   MaterialButton1(
  //                     color1: ColorConstant.COLOR_BLACK,
  //                     txt1: "Cancel",
  //                     height1: 55,
  //                   ),

  //                   // TimePicker(),
  //                   // RadioButton1(),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       });
 // }
}
