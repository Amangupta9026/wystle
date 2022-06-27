import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wystle/push_notification/push_notification.dart';

import 'constant/routepath.dart' as routepath;
import 'firebase_options.dart';
import 'module/sharedpreference/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'wystle',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationService.initialize();
  await SharedPreference.init();
  // _instanceId();

  runApp(const MyApp());
}

// void _instanceId() async {
//   await Firebase.initializeApp();
//   FirebaseMessaging.instance.getInitialMessage();
//   FirebaseMessaging.instance.sendMessage();
//   var token = await FirebaseMessaging.instance.getToken();
//   log("Print Instance Token ID: " + token!);
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wystle',
      theme: ThemeData(
        primaryColor: Colors.black,
        //primarySwatch: Colors.red,
      ),
      initialRoute: routepath.RoutePath.initRoutePath,
      onGenerateRoute: routepath.generateRoute,
    );
  }
}



// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:wystle/module/splash_screen.dart';

// import 'constant/apptheme.dart';
// import 'constant/theme_option.dart';
// import 'constant/routepath.dart' as routepath;
// import 'module/sharedpreference/shared_preference.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   await SharedPreference.init();
//   //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()));
//   const themeOption = ThemeOption.system;
//   runApp(MyApp(themeOption: themeOption));
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key, required ThemeOption themeOption})
//       : _themeNotifier = ValueNotifier(themeOption),
//         super(key: key);

//   final ValueNotifier<ThemeOption> _themeNotifier;

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeOption>(
//       valueListenable: _themeNotifier,
//       child: const SplashPage(),
//       builder: (context, themeOption, child) {
//         return MaterialApp(
//           title: 'Theming Tutorial',
//           debugShowCheckedModeBanner: false,
//           theme: AppTheme.light,
//           darkTheme: themeOption == ThemeOption.trueBlack
//               ? AppTheme.trueBlack
//               : AppTheme.dark,
//           themeMode: themeOption.themeMode,
//           home: child,
//           //  initialRoute: routepath.RoutePath.initRoutePath,
//           //   onGenerateRoute: routepath.generateRoute,
//         );
//       },
//     );
//   }

//   void onThemeUpdate(ThemeOption themeOption) {
//     _themeNotifier.value = themeOption;
//   }
// }

