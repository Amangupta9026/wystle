import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'constant/routepath.dart' as routepath;
import 'constant/themes.dart';
import 'firebase_options.dart';
import 'module/sharedpreference/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'wystle',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // PushNotificationService.initialize();
  await SharedPreference.init();
  // runApp(DevicePreview(
  // enabled: !kReleaseMode, builder: (context) => const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
    )

        // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent.withOpacity(0.7),
        //   statusBarIconBrightness:
        //       AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
        // statusBarBrightness:
        //     AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
        // systemNavigationBarColor:
        //     AppTheme.isLightTheme ? Colors.white : Colors.black,
        // systemNavigationBarDividerColor: Colors.grey,
        // systemNavigationBarIconBrightness:
        //     AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
        // )
        );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wystle',
       theme: AppTheme.getTheme(),
      initialRoute: routepath.RoutePath.initRoutePath,
      onGenerateRoute: routepath.generateRoute,
      builder: EasyLoading.init(),
    );
  }
}
