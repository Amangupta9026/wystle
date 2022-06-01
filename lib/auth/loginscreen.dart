import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wystle/widget/reusubility_button.dart';

import '../testing/geolocator.dart';
import 'onboarding.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // auth.User? googleLoginUser;
  // final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  bool isProgressRunning = false;

  // SignIn With Google
  // Future<String?> _signInWithGoogle() async {
  //   setState(() {
  //     isProgressRunning = true;
  //   });
  //   try {
  //     if (_auth.currentUser != null) {
  //       _signOutGoogle();
  //     }
  //     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final auth.AuthCredential credential =
  //           auth.GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //       // ignore: unnecessary_null_comparison
  //       if (credential != null) {
  //         final auth.UserCredential authResult =
  //             await _auth.signInWithCredential(credential);
  //         googleLoginUser = authResult.user;
  //         if (googleLoginUser != null) {
  //           assert(!googleLoginUser!.isAnonymous);
  //           // ignore: unnecessary_null_comparison
  //           assert(await googleLoginUser!.getIdToken() != null);
  //           final auth.User? currentUser = _auth.currentUser;
  //           assert(googleLoginUser!.uid == currentUser!.uid);

  //           currentUser!.getIdToken().then((value) {
  //             log("currentUserToken ::$value");
  //           });
  //           log("login email ${googleLoginUser!.email}");
  //           log("name ${googleLoginUser!.displayName}");
  //           log("id ${googleLoginUser!.uid}");
  //           log("photo ${googleLoginUser!.photoURL}");
  //           final idToken = await googleLoginUser!.getIdToken();
  //           log("idToken :: $idToken");
  //         }
  //         setState(() {
  //           isProgressRunning = false;
  //         });
  //         if (googleLoginUser != null) {
  //           // log(googleLoginUser.email);
  //           // log(googleLoginUser.displayName);
  //         }
  //         return '$googleLoginUser';
  //       }
  //     } else {
  //       setState(() {
  //         isProgressRunning = false;
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       isProgressRunning = false;
  //     });
  //     //  Fluttertoast.showToast(msg: error);
  //     log("google login error che  $error");
  //   }
  //   return null;
  // }

  // Future<void> _signOutGoogle() async {
  //   try {
  //     await googleSignIn.signOut();
  //     //await googleSignIn.disconnect();
  //   } catch (e) {
  //     log("error in _signOutGoogle $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF909595),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 70,
          ),
          _topheader(),
          Expanded(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 32),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.grey[50],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  //  _labelText('Email:'),

                  const TextFieldWithPlaceholder(
                    text1: 'Email',
                    text2: 'Enter your Email id',
                  ),

                  const SizedBox(height: 16),
                  // _labelText('Password:'),
                  //    _inputTextField('******', true),
                  const TextFieldWithPlaceholder(
                    text1: 'Password',
                    text2: 'Enter your Password',
                    obscuretext: true,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password ?',
                          style: TextStyle(
                              color: Colors.blue[900], fontFamily: "Sofia"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  const MyLocation()),
                      );

                      log("print login");
                    },
                    child: const MaterialButton1(
                      txt1: 'Login',
                      height1: 55,
                      width1: 600,
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     'OR',
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       fontFamily: "Sofia",
                  //       fontWeight: FontWeight.w700,
                  //       color: Colors.black54,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 18),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     _loginSocialMediaBtn(
                  //         FontAwesomeIcons.facebookF, facebookColor, () {}),
                  //     const SizedBox(width: 16),
                  //     _loginSocialMediaBtn(FontAwesomeIcons.google, googleColor,
                  //         () async {
                  //       // var resp = await _signInWithGoogle();

                  //       // if (resp != null &&
                  //       //     googleLoginUser?.email != null &&
                  //       //     googleLoginUser!.email!.isNotEmpty &&
                  //       //     googleLoginUser?.displayName != null &&
                  //       //     googleLoginUser!.displayName!.isNotEmpty) {
                  //       //   log("resp ${resp.toString()}");
                  //       //   await Fluttertoast.showToast(
                  //       //     msg: "Google Login Success",
                  //       //   );

                  //         Navigator.pushAndRemoveUntil<dynamic>(
                  //           context,
                  //           MaterialPageRoute<dynamic>(
                  //             builder: (BuildContext context) =>
                  //                 const OnBoarding(),
                  //           ),
                  //           (route) => false,
                  //         );

                  //         //  await _apiLogin(LOGIN_TYPE_GMAIL, "");
                  //       }
                  //     }),
                  //   ],
                  // ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  //button to login in using scial media,
  // _loginSocialMediaBtn(IconData icon, Color bgColor, Function onTap) {
  //   return SizedBox.fromSize(
  //     size: const Size(54, 54), //button width and height
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(16),
  //       child: Material(
  //         elevation: 16,
  //         shadowColor: Colors.black,
  //         color: bgColor,
  //         child: InkWell(
  //           splashColor: Colors.white12,
  //           onTap: () => onTap(),
  //           //() {},
  //           child: Center(
  //             child: Icon(
  //               icon,
  //               color: Colors.white,
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // _inputTextField(hintText, bool obscuretext) {
  //   return Container(
  //     height: 56,
  //     padding: const EdgeInsets.fromLTRB(16, 3, 16, 6),
  //     margin: const EdgeInsets.all(8),
  //     decoration: raisedDecoration,
  //     child: Center(
  //       child: TextField(
  //         obscureText: obscuretext,
  //         decoration: InputDecoration(
  //             border: InputBorder.none,
  //             hintText: hintText,
  //             hintStyle: const TextStyle(
  //               fontFamily: "Sofia",
  //               color: Colors.black38,
  //             )),
  //       ),
  //     ),
  //   );
  // }

  // ignore: unused_element
  _labelText(title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: "Sofia",
          fontSize: 16,
        ),
      ),
    );
  }

  _topheader() {
    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Login',
            style: TextStyle(
              fontFamily: "Sofia",
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 29,
            ),
          ),
          Image.asset(
            'assets/images/board2.png',
            height: MediaQuery.of(context).size.width / 2.4,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}

var raisedDecoration = BoxDecoration(
  color: Colors.white,
  // borderRadius: BorderRadius.circular(16),
  border: Border.all(
    color: Colors.grey[50]!,
  ),
  // boxShadow: const [
  //   BoxShadow(
  //     color: Colors.black26,
  //     offset: Offset(5, 2),
  //     blurRadius: 3.0,
  //     spreadRadius: 0.0,
  //   ),
  //   BoxShadow(
  //     color: Colors.white,
  //     offset: Offset(-5, -2),
  //     blurRadius: 3.0,
  //     spreadRadius: 0.0,
  //   ),
  // ]);
);

Color facebookColor = const Color(0xFF416BC1);
Color googleColor = const Color(0xFFCF4333);
