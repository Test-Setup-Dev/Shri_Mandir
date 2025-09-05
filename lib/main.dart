import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/screen/splash/splash.dart';
import 'package:mandir/utils/helper.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
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

