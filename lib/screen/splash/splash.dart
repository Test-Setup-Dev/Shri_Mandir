import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mandir/screen/auth/login/login_screen.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/widget/widgets.dart';
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
          Get.off(() => HomeScreen());
        } else {
          // Get.off(() => HomeScreen());
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              assetImage(
                'assets/icons/logo.png',
                width: 60.w,
                fit: BoxFit.fitWidth,
              ),
              // 12.vs,
              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Text(
              //       'Powered By',
              //       style: MyTextStyle(
              //         color: Colors.white,
              //         fontSize: fontSizeExtraLarge,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     6.hs,
              //     assetImage('assets/icons/twilio_white.png', width: 25.w, fit: BoxFit.fitWidth),
              //   ],
              // ),
              // 15.h.vs,
            ],
          ),
        ),
      ),
    );
  }
}
