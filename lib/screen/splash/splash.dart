import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mandir/screen/auth/login/login_screen.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/preference.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Helper.init();
    init();
    super.initState();
  }

  void init() {
    Future.delayed(const Duration(seconds: 1), () {
      Preference.init().whenComplete(() {
        if (Preference.isLogin) {
          Get.off(() => Dashboard());
        } else {
          Get.off(() => LoginScreen());
        }
      });
    });

    if (PlatformType.isAndroid) {
      DeviceInfoPlugin().androidInfo.then((info) async {
        if (info.version.sdkInt >= 33) {
          PermissionStatus status = await Permission.notification.status;
          if (status != PermissionStatus.granted) {
            Permission.notification.request();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.initWithContext(context);
    return Scaffold(
      backgroundColor: ThemeColors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('assets/icons/logo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
