import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/screen/splash/splash.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/notification_helper.dart';
import 'package:mandir/utils/preference.dart';


Future<void> main() async {
  FlutterError.onError = Repository.instance.onFlutterError;

  WidgetsFlutterBinding.ensureInitialized();
  // final binding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: binding);

  try {
    PlatformType.platformType = Platform.operatingSystem;
  } catch (e) {
    PlatformType.platformType = kIsWeb ? 'web' : 'unknown';
  }

  if (PlatformType.isAndroid || PlatformType.isIOS) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCTG5LeUFOI6cprH5Jd_ewZp71cA6FgFjQ",
        appId: '1:579064117187:android:15605f210d673b2d306f76',
        messagingSenderId: "579064117187",
        projectId: "mindir-8838c",
      ),
    );
  }

  await Preference.init();
  await NotifHelper.init();
  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth: Const.webWidth,
    app: MyApp(),
  );
  // Helper.getFCMToken();
  runApp(runnableApp);

  // await Future.delayed(const Duration(milliseconds: 500));
  // FlutterNativeSplash.remove();
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(width: webAppWidth, child: app),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sri Mandir Services',
      theme: ThemeData(
        primarySwatch: ThemeColors.primaryColor,
        primaryColor: ThemeColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ThemeColors.primaryColor,
          accentColor: ThemeColors.accentColor,
        ),
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: ThemeColors.primary2,
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.primary2,
          foregroundColor: ThemeColors.white,
          elevation: 0,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

