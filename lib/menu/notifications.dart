import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  void _instanceId() async {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.sendMessage();
    var token = await FirebaseMessaging.instance.getToken();
    log("Print Instance Token ID: " + token!);
  }

  @override
  void initState() {
    super.initState();
    _instanceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In App Messaging'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('In-App Messaging'),
          onPressed: () {
            FirebaseInAppMessaging.instance.triggerEvent("");

            FirebaseMessaging.instance.sendMessage();

            FirebaseMessaging.instance.getInitialMessage();
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// import '../constant/color_constant.dart';

// class Notifications extends StatefulWidget {
//   const Notifications({Key? key}) : super(key: key);

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color(0xFFf9d915),
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back,
//             color: ColorConstant.COLOR_BLACK,
//             size: 28,
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(100),
//           child: Padding(
//             padding: const EdgeInsets.only(
//               left: 40.0,
//               bottom: 20,
//             ),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Notifications",
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context).textTheme.headline4?.copyWith(
//                             color: ColorConstant.COLOR_BLACK,
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 60),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: ColorConstant.COLOR_WHITE,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: ColorConstant.COLOR_BLACK.withOpacity(0.1),
//                     blurRadius: 10,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 10),
//                 child: Row(
//                   children: [
//                     Column(children: [
//                       Container(
//                           height: 35,
//                           width: 35,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFFfeb283),

//                             // color: ColorConstant.COLOR_ORIGINAL_GREY,
//                           ),
//                           child: const Icon(
//                             Icons.notifications,
//                             color: ColorConstant.COLOR_WHITE,
//                           )),
//                     ]),
//                     const SizedBox(
//                       width: 13,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Refer your freinds',
//                             style:
//                                 Theme.of(context).textTheme.headline6?.copyWith(
//                                       color: ColorConstant.COLOR_BLACK,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                           ),
//                           const SizedBox(
//                             height: 2,
//                           ),
//                           Text(
//                             'Dear user, you can refer your friends to earn more money',
//                             style:
//                                 Theme.of(context).textTheme.subtitle2?.copyWith(
//                                       color: ColorConstant.COLOR_BLACK,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
