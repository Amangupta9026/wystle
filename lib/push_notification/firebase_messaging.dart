import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:wystle/push_notification/push_notification.dart';

class Messaging {
  static void showMessage() {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    // firebaseMessaging.getToken().then((value) => storeToken(value));
    // // print('fcm token ${fcm_token}');
    // // storeToken(fcm_token);

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data['route'];
        log("$routeFromMessage");
        // Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    /// forground work
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      if (message != null) {
        PushNotificationService.display(message);
        log("${message.notification!.body}");
        log("${message.notification!.title}");
      }
    });

    // When the app is in background but open and user taps
    // on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['route'];
      log(routeFromMessage);
      // Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
}
