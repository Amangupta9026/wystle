
import 'package:dio/dio.dart';

Dio dio = Dio(BaseOptions(
  connectTimeout: 500000,
  receiveTimeout: 500000,
));


// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// import 'api_constants.dart';
// import 'color_constant.dart';

// class DioClient {
//   static Dio? _dioClient;
//   static FirebaseMessaging? _firebaseMessaging;

//   static Dio getMyDioClient() {
//     if (_dioClient == null) {
//       initClient();
//     }
//     return _dioClient!;
//   }

//   // static Future<void> _getTokenIfNotExists() async {
//   //   if (SharedPreference.getValue(PrefConstants.FIREBASE_TOKEN) == null &&
//   //       SharedPreference.getValue(PrefConstants.FIREBASE_TOKEN)
//   //           .toString()
//   //           .isEmpty) {
//   //     _firebaseMessaging = FirebaseMessaging.instance;
//   //     String? firebaseToken = await _firebaseMessaging!.getToken();
//   //     log("$firebaseToken", name: "My Firebase Token From Dio");
//   //     SharedPreference.setValue(
//   //         PrefConstants.FIREBASE_TOKEN, firebaseToken ?? "");
//   //   }
//   // }

//   static Dio? initClient() {
//     _dioClient = Dio(
//       BaseOptions(
//           baseUrl: APIConstants.API_CALL_URL,
//           connectTimeout: APIConstants.CONNECTION_TIMEOUT,
//           receiveTimeout: APIConstants.RECEIVE_TIMEOUT,
//           headers: {
//             // "Authorization":
//             //     "xFVZGW8aB7VOg6X6lSI5cbyv9hygKqAohuDygS7w7t03fFyqpBZ3c78MNSuI5Jij",
//             // "Max-Forwards": 2062,
//             // "If-Match": 1178330,

//             // "Access-Control_Allow_Origin": "*",
//             // "Access-Control-Allow-Credentials":
//             //     true, // Required for cookies, authorization headers with HTTPS
//             // "Access-Control-Allow-Headers":
//             //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
//             // "Access-Control-Allow-Methods": "POST, GET, OPTIONS",
//           },
//           validateStatus: (status) {
//             return status! <= 500 && status != 401;
//           }),
//     );
//     // var cookieJar = CookieJar();
//     // _dioClient.interceptors.add(CookieManager(cookieJar));
//     log("API URL IS :: ${_dioClient!.options.baseUrl}");

//     _dioClient?.interceptors
//         .add(InterceptorsWrapper(onRequest: (options, handler) {
//       //    _getTokenIfNotExists();
//       // options.headers.putIfAbsent(PrefConstants.ACCESS_TOKEN,
//       //     () => SharedPreference.getValue(PrefConstants.ACCESS_TOKEN));
//       // options.headers.putIfAbsent(PrefConstants.REFRESH_TOKEN,
//       //     () => SharedPreference.getValue(PrefConstants.REFRESH_TOKEN));
//       // log("${SharedPreference.getValue(PrefConstants.USER_ID) ?? "No UserID"}",
//       //     name: "userID");
//       // log("${SharedPreference.getValue(PrefConstants.MATCH_ID) ?? "No match ID"}",
//       //     name: "matchId");
//       return handler.next(options); //continue
//     }, onResponse: (response, handler) {
//       // if (response.headers.value(PrefConstants.ACCESS_TOKEN) != null) {
//       //   globals.accessToken =
//       //       response.headers.value(PrefConstants.ACCESS_TOKEN);
//       //   // SharedPreference.setValue(PrefConstants.ACCESS_TOKEN,
//       //   //     response.headers.value(PrefConstants.ACCESS_TOKEN));
//       //   // log("${SharedPreference.getValue(PrefConstants.ACCESS_TOKEN)}",
//       //   //     name: "AccessToken");
//       // }
//       // if (response.headers.value(PrefConstants.REFRESH_TOKEN) != null) {
//       //   globals.refreshToken =
//       //       response.headers.value(PrefConstants.REFRESH_TOKEN);
//       //   // SharedPreference.setValue(PrefConstants.REFRESH_TOKEN,
//       //   //     response.headers.value(PrefConstants.REFRESH_TOKEN));
//       //   // log("${SharedPreference.getValue(PrefConstants.REFRESH_TOKEN)}",
//       //   //     name: "RefreshToken");
//       // }
//       return handler.next(response); // continue
//     }, onError: (DioError e, handler) {
//       log("${e.message}", name: "onError of dio");
//       return handler.next(e); //continue
//     }));
//     return _dioClient;
//   }
// }

// dynamic validateError(Response response) {
//   if (response.statusCode == 400) {
//     return response.data ?? response.statusMessage;
//   } else if (response.statusCode == 500) {
//     return (response.data.toString());
//     //?? response.statusMessage;
//   } else {
//     try {
//       return (response.data as String);
//       //   ?? response.statusMessage;
//     } catch (e) {
//       return "Something went wrong";
//     }
//   }
// }

// void showErrorDialog(BuildContext context, dynamic errorResponse,
//     {Function? onOKPressed,
//     bool isPlatformIOS = false,
//     bool? dismissableDialog}) {
//   String errorTitle = "", errorMsg = "", buttonText = "OK";
//   bool dismissable = true;
//   if (errorResponse is Response) {
//     errorTitle = errorResponse.statusMessage!;
//     errorMsg = validateError(errorResponse);
//     if (errorResponse.statusCode == 401) {
//       dismissable = false;
//       buttonText = "Login again";
//     }
//   } else if (errorResponse is DioError) {
//     if (errorResponse.message.contains("SocketException")) {
//       errorTitle = "Network Problem";
//       errorMsg =
//           "There is some issue with your internet connection,please check your internet connection settings and try again";
//       if (dismissableDialog != null && !dismissableDialog) {
//         dismissable = dismissableDialog;
//       }
//     } else if (errorResponse.response != null) {
//       errorTitle = errorResponse.response!.statusMessage!;
//       errorMsg = errorResponse.response!.data.toString();
//     } else {
//       errorTitle = "API Problem Found";
//       errorMsg = errorResponse.message;
//       //  ??
//       //     "There was some problem while connecting to the server";
//     }
//   } else {
//     errorTitle = "Error";
//     errorMsg = errorResponse.toString();
//   }
//   showDialog(
//       context: context,
//       barrierDismissible: dismissable,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () {
//             return Future.value(dismissable);
//           },
//           child: AlertDialog(
//             title: Text(errorTitle),
//             content: Text(errorMsg),
//             //  content: Text("Server Down not Reachable"),

//             actions: <Widget>[
//               !isPlatformIOS
//                   ? ElevatedButton(
//                       onPressed: (() {
//                         Navigator.of(context).pop();
//                         if (onOKPressed != null) {
//                           onOKPressed();
//                         }
//                       }),
//                       child: Text(buttonText),
//                     )
//                   : Container(),
//             ],
//           ),
//         );
//       });
// }

// void showCommonMessageDialog(BuildContext context, String message) {
//   showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () {
//             return Future.value(true);
//           },
//           child: AlertDialog(
//             content: Text(message
//                 //?? ""
//                 ),
//             actions: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: ColorConstant.COLOR_BLACK, // background
//                 ),
//                 onPressed: (() {
//                   Navigator.of(context).pop();
//                   // if (onOKPressed != null) {
//                   //   onOKPressed();
//                   // }
//                 }),
//                 child: const Padding(
//                   padding: EdgeInsets.all(6.0),
//                   child: Text(
//                     "OK",
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       });
// }
