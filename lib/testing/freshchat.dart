import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freshchat_sdk/freshchat_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshchat_sdk/freshchat_user.dart';

void handleFreshchatNotification(Map<String, dynamic> message) async {
  if (await Freshchat.isFreshchatNotification(message)) {
    print("is Freshchat notification");
    Freshchat.handlePushNotification(message);
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print("Inside background handler");
  await Firebase.initializeApp();
  handleFreshchatNotification(message.data);
}

class FreshChatDemo extends StatefulWidget {
  const FreshChatDemo({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  _FreshChatDemoState createState() => _FreshChatDemoState();
}

class _FreshChatDemoState extends State<FreshChatDemo> {
  static const MethodChannel _channel = MethodChannel('freshchat_sdk');

  final int _counter = 0;
  final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();

  void registerFcmToken() async {
    if (Platform.isAndroid) {
      String? token = await FirebaseMessaging.instance.getToken();
      print("FCM Token is generated $token");
      Freshchat.setPushRegistrationToken(token!);
    }
  }

  void restoreUser(BuildContext context) {
    var externalId, restoreId, obtainedRestoreId;
    var alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: const Text(
        "Identify/Restore User",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontFamily: 'OpenSans-Regular'),
      ),
      content: Form(
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "External ID",
                ),
                onChanged: (val) {
                  setState(() {
                    externalId = val;
                  });
                }),
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Restore ID",
                ),
                onChanged: (val) {
                  setState(() {
                    restoreId = val;
                  });
                }),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Identify/Restore",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(
                  () {
                    Freshchat.identifyUser(
                        externalId: externalId, restoreId: restoreId);
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                );
              },
            ),
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Cancel",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).pop(context);
                });
              },
            ),
          ],
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void notifyRestoreId(var event) async {
    FreshchatUser user = await Freshchat.getUser;
    String? restoreId = user.getRestoreId();
    if (restoreId != null) {
      Clipboard.setData(ClipboardData(text: restoreId));
    }
    _scaffoldKey!.currentState!
        .showSnackBar(SnackBar(content: Text("Restore ID copied: $restoreId")));
  }

  void getUserProps(BuildContext context) {
    final _userInfoKey = GlobalKey<FormState>();
    String? key, value;
    var alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: const Text(
        "Custom User Properties:",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontFamily: 'OpenSans-Regular'),
      ),
      content: Form(
        key: _userInfoKey,
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Key",
                ),
                onChanged: (val) {
                  setState(() {
                    key = val;
                  });
                }),
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Value",
                ),
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                }),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Add Properties",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(() {
                  Map map = {key: value};
                  Freshchat.setUserProperties(map);
                });
              },
            ),
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Cancel",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).pop(context);
                });
              },
            ),
          ],
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void sendMessageApi(BuildContext context) {
    final _userInfoKey = GlobalKey<FormState>();
    String? conversationTag, message;
    var alert = AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: const Text(
        "Send Message API",
        textDirection: TextDirection.ltr,
        style: TextStyle(fontFamily: 'OpenSans-Regular'),
      ),
      content: Form(
        key: _userInfoKey,
        child: Column(
          children: [
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Conversation Tag",
                ),
                onChanged: (val) {
                  setState(() {
                    conversationTag = val;
                  });
                }),
            TextFormField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Message",
                ),
                onChanged: (val) {
                  setState(() {
                    message = val;
                  });
                }),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Send Message",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(
                  () {
                    Freshchat.sendMessage(conversationTag!, message!);
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                );
              },
            ),
            MaterialButton(
              elevation: 10.0,
              child: const Text(
                "Cancel",
                textDirection: TextDirection.ltr,
              ),
              onPressed: () {
                setState(() {
                  Navigator.of(context, rootNavigator: true).pop(context);
                });
              },
            ),
          ],
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  static const String APP_ID = "63b13cc4-cee3-488f-9937-e35d9598c8cd",
      APP_KEY = "07b0c543-3c83-48ad-bd53-cd69fe316921",
      DOMAIN = "msdk.in.freshchat.com";
  @override
  void initState() {
    super.initState();
    Freshchat.init(APP_ID, APP_KEY, DOMAIN,
        userEventsTrackingEnabled: true,
        teamMemberInfoVisible: true,
        showNotificationBanneriOS: true);
    /**
     * This is the Firebase push notification server key for this sample app.
     * Please save this in your Freshchat account to test push notifications in Sample app.
     *
     * Server key: Please refer support documentation for the server key of this sample app.
     *
     * Note: This is the push notification server key for sample app. You need to use your own server key for testing in your application
     */
    var restoreStream = Freshchat.onRestoreIdGenerated;
    var restoreStreamSubsctiption = restoreStream.listen((event) {
      print("Restore ID Generated: $event");
      notifyRestoreId(event);
    });

    var unreadCountStream = Freshchat.onMessageCountUpdate;
    unreadCountStream.listen((event) {
      print("Have unread messages: $event");
    });

    var userInteractionStream = Freshchat.onUserInteraction;
    userInteractionStream.listen((event) {
      print("User interaction for Freshchat SDK");
    });

    if (Platform.isAndroid) {
      registerFcmToken();
      FirebaseMessaging.instance.onTokenRefresh
          .listen(Freshchat.setPushRegistrationToken);

      Freshchat.setNotificationConfig(notificationInterceptionEnabled: true);
      var notificationInterceptStream = Freshchat.onNotificationIntercept;
      notificationInterceptStream.listen((event) {
        print("Freshchat Notification Intercept detected");
        Freshchat.openFreshchatDeeplink(event["url"]);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        var data = message.data;
        handleFreshchatNotification(data);
        print("Notification Content: $data");
      });
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  }

  void _incrementCounter() {
    setState(() {
      Freshchat.showConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Freshchat Flutter Demo'),
        ),
        body: Builder(
          builder: (context) => GridView.count(
            crossAxisCount: 2,
            children: List.generate(6, (index) {
              switch (index) {
                case 0:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "FAQs",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        Freshchat.showFAQ(
                            showContactUsOnFaqScreens: true,
                            showContactUsOnAppBar: true,
                            showFaqCategoriesAsGrid: true,
                            showContactUsOnFaqNotHelpful: true);
                      });
                  break;
                case 1:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Unread Count",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () async {
                        var unreadCountStatus =
                            await Freshchat.getUnreadCountAsync;
                        int count = unreadCountStatus['count'];
                        String status = unreadCountStatus['status'];
                        final snackBar = SnackBar(
                          content: Text(
                              "Unread Message Count: $count  Status: $status"),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      });
                  break;
                case 2:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Reset User",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () async {
                        Freshchat.resetUser();

                        //
                        // var user = await Freshchat. ;

                        // String tokenStatus = await _channel.invokeMethod(
                        //   'getUserIdTokenStatus',
                        // );
                        // log(tokenStatus);
                        // final String userAlias =
                        //     await _channel.invokeMethod('getFreshchatUserId');
                        // log(userAlias);

                        // resetUser();
                      });
                  break;
                case 3:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Restore User",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        restoreUser(context);
                      });
                  break;
                case 4:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Set User Properties",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        getUserProps(context);
                      });
                  break;
                case 5:
                  return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                            child: Text(
                              "Send Message",
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            )),
                      ),
                      onTap: () {
                        sendMessageApi(context);
                      });
                  break;
                default:
                  return Center(
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  );
                  break;
              }
            }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Chat',
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:freshchat_sdk/freshchat_sdk.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:freshchat_sdk/freshchat_user.dart';
// import 'package:wystle/module/sharedpreference/userdata.dart';

// class FreshChatDemo extends StatelessWidget {
//   const FreshChatDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Freshchat Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(title: 'Freshchat Flutter Demo'),
//     );
//   }
// }

// void handleFreshchatNotification(Map<String, dynamic> message) async {
//   if (await Freshchat.isFreshchatNotification(message)) {
//     log("is Freshchat notification");
//     Freshchat.handlePushNotification(message);
//   }
// }

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   log("Inside background handler");
//   await Firebase.initializeApp();
//   handleFreshchatNotification(message.data);
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, this.title}) : super(key: key);

//   final String? title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var userdata = UserData.geUserData();
//   final GlobalKey<ScaffoldState>? _scaffoldKey = GlobalKey<ScaffoldState>();
//   static const MethodChannel _channel = MethodChannel('freshchat_sdk');

//   static void setUserWithIdToken(String token) async {
//     await _channel.invokeMethod(
//       'setUserWithIdToken',
//       <String, dynamic>{
//         'token': token,
//       },
//     );
//     log(token);
//   }

//   void registerFcmToken() async {
//     if (Platform.isAndroid) {
//       String? token = await FirebaseMessaging.instance.getToken();
//       log("FCM Token is generated $token");
//       Freshchat.setPushRegistrationToken(token!);
//     }
//   }

//   void notifyRestoreId(var event) async {
//     FreshchatUser user = await Freshchat.getUser;
//     String? restoreId = user.getRestoreId();
//     if (restoreId != null) {
//       Clipboard.setData(ClipboardData(text: restoreId));
//     }
//     _scaffoldKey!.currentState!
//         .showSnackBar(SnackBar(content: Text("Restore ID copied: $restoreId")));
//   }

//   void sendMessageApi(BuildContext context) {
//     final _userInfoKey = GlobalKey<FormState>();
//     String? conversationTag, message;
//     var alert = AlertDialog(
//       scrollable: true,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       title: const Text(
//         "Send Message API",
//         textDirection: TextDirection.ltr,
//         style: TextStyle(fontFamily: 'OpenSans-Regular'),
//       ),
//       content: Form(
//         key: _userInfoKey,
//         child: Column(
//           children: [
//             TextFormField(
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: "Conversation Tag",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     conversationTag = val;
//                   });
//                 }),
//             TextFormField(
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: "Message",
//                 ),
//                 onChanged: (val) {
//                   setState(() {
//                     message = val;
//                   });
//                 }),
//           ],
//         ),
//       ),
//       actions: <Widget>[
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             MaterialButton(
//               elevation: 10.0,
//               child: const Text(
//                 "Send Message",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(
//                   () {
//                     Freshchat.sendMessage(conversationTag!, message!);
//                     Navigator.of(context, rootNavigator: true).pop(context);
//                   },
//                 );
//               },
//             ),
//             MaterialButton(
//               elevation: 10.0,
//               child: const Text(
//                 "Cancel",
//                 textDirection: TextDirection.ltr,
//               ),
//               onPressed: () {
//                 setState(() {
//                   Navigator.of(context, rootNavigator: true).pop(context);
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//     showDialog(
//         context: context,
//         builder: (context) {
//           return alert;
//         });
//   }

// static const String appId = "63b13cc4-cee3-488f-9937-e35d9598c8cd",
//     appKEY = "07b0c543-3c83-48ad-bd53-cd69fe316921",
//     dOMAIN = "msdk.in.freshchat.com";
//   @override
//   void initState() {
//     super.initState();
//     Freshchat.init(appId, appKEY, dOMAIN);
//     Freshchat.setUserProperties({"name": userdata.firstname});
//     setUserWithIdToken("ddd");
//     Freshchat.getFreshchatUserId.then((value) {
//       log("Freshchat User Id is $value");
//     });
//     Freshchat.getUserIdTokenStatus.then((value) {
//       log("Freshchat User Id Token Status is $value");
//     });
//     Freshchat.setUserWithIdToken("");
//     Freshchat.getFreshchatUserId.then((value) {
//       log("Freshchat User Id is $value");
//     });
//     Freshchat.onUserInteraction.listen((event) {
//       log("User Interaction is $event");
//     });
//     Freshchat.setUserWithIdToken("aaa");

//     var restoreStream = Freshchat.onRestoreIdGenerated;
//     var restoreStreamSubsctiption = restoreStream.listen((event) {
//       log("Restore ID Generated: $event");
//       notifyRestoreId(event);
//     });

//     var unreadCountStream = Freshchat.onMessageCountUpdate;
//     unreadCountStream.listen((event) {
//       log("Have unread messages: $event");
//     });

//     var userInteractionStream = Freshchat.onUserInteraction;
//     userInteractionStream.listen((event) {
//       log("User interaction for Freshchat SDK");
//     });

//     if (Platform.isAndroid) {
//       registerFcmToken();
//       FirebaseMessaging.instance.onTokenRefresh
//           .listen(Freshchat.setPushRegistrationToken);

//       Freshchat.setNotificationConfig(notificationInterceptionEnabled: true);
//       var notificationInterceptStream = Freshchat.onNotificationIntercept;
//       notificationInterceptStream.listen((event) {
//         log("Freshchat Notification Intercept detected");
//         Freshchat.openFreshchatDeeplink(event["url"]);
//       });

//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         var data = message.data;
//         handleFreshchatNotification(data);
//         log("Notification Content: $data");
//       });
//       FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//     }
//   }

//   void _incrementCounter() {
//     setState(() {
//       Freshchat.showConversations();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: const Text('Freshchat'),
//         ),
//         body: Builder(
//           builder: (context) => ListView.builder(
//               itemCount: 5,
//               itemBuilder: (BuildContext context, int index) {
//                 switch (index) {
//                   case 0:
//                     return Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           GestureDetector(
//                               child: Text(
//                                 "FAQs",
//                                 style: Theme.of(context).textTheme.headline5,
//                                 textAlign: TextAlign.start,
//                               ),
//                               onTap: () {
//                                 Freshchat.showFAQ(
//                                     showContactUsOnFaqScreens: true,
//                                     showContactUsOnAppBar: true,
//                                     showFaqCategoriesAsGrid: true,
//                                     showContactUsOnFaqNotHelpful: true);
//                               }),
//                           const SizedBox(height: 20),
//                           GestureDetector(
//                               child: Text(
//                                 "Unread Count",
//                                 style: Theme.of(context).textTheme.headline5,
//                                 textAlign: TextAlign.start,
//                               ),
//                               onTap: () async {
//                                 var unreadCountStatus =
//                                     await Freshchat.getUnreadCountAsync;
//                                 int count = unreadCountStatus['count'];
//                                 String status = unreadCountStatus['status'];
//                                 final snackBar = SnackBar(
//                                   content: Text(
//                                       "Unread Message Count: $count  Status: $status"),
//                                 );
//                                 Scaffold.of(context).showSnackBar(snackBar);
//                               })
//                         ],
//                       ),
//                     );

//                     break;
//                   default:
//                     return Text(
//                       '',
//                       // 'Item $index',
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context).textTheme.headline5,
//                     );
//                 }
//               }),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _incrementCounter,
//           tooltip: 'Chat',
//           child: const Icon(Icons.chat),
//         ),
//       ),
//     );
//   }
// }
