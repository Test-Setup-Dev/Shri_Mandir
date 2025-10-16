import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/result.dart';
import 'package:mandir/model/user.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/notification_helper.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';
import 'dart:async';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/dialogs/alert_dialog.dart';

class LoginController extends GetxController {
  final Rx<Result> loginResult = Result().obs;
  ScrollController scrollController = ScrollController();
  final emailFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  var fcmToken = '';
  var obscurePassword = true.obs;
  final RxString status = Status.NORMAL.obs;
  final RxString dataResponse = 'Unknown'.obs;
  final RxString phoneCode = '91'.obs;
  bool gmailAdded = false;

  @override
  void onInit() {
    // super.onInit();
    init();
  }

  Future<void> init() async {
    // FirebaseMessaging.instance.getToken().then((token) {
    //   fcmToken = token ?? 'TOKEN ONT EXISTS';
    //   print('qwtoken: ${fcmToken}');
    // });

    // fcmToken.value = await NotificationHelper.getFcmToken().toString();

    if (Helper.isTester) {
      emailCtrl.text = 'testsetup.dev@gmail.com';
      passCtrl.text = '123456';
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login(String email, String password) async {
    if (Helper.isEmpty(email)) {
      Toasty.info('Please enter email!');
      return;
    }

    if (Helper.isEmpty(password)) {
      Toasty.info('pleaseEnterPassword'.t);
      return;
    }

    status.value = Status.PROGRESS;

    try {
      final fcmToken = await NotifHelper.getFcmToken();
      Repository.instance.login(email, password, fcmToken).then(loginSuccess);
    } catch (e) {
      Logger.ex(
        baseName: runtimeType,
        tag: 'LOGIN EXC',
        value: e,
        sendToServer: true,
      );
      status.value = Status.COMPLETED;
    } finally {
      status.value = Status.COMPLETED;
    }
  }

  void onEmailChange(String value) {
    if (!gmailAdded && value.isNotEmpty && value.endsWith("@")) {
      emailCtrl.clear();
      emailCtrl.text = '${value}gmail.com';
      emailCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: emailCtrl.text.length),
      );
      gmailAdded = true;
      emailFocusNode.requestFocus();
      passFocusNode.requestFocus();
    }
  }

  void loginSuccess(var json) async {
    Logger.r(tag: 'Logger ajay', value: json);
    try {
      if (json != null && json['status'] == true) {
        User user = User.fromJson(json['user']);
        Preference.setUser(user);
        // if (user.isActive != '1') {
        //   MyAlertDialog()
        //       .setDialogCancelable(false)
        //       .setTitle(Strings.get('login'))
        //       .setMessage(Strings.get('yourAccountIsDeactivated'.t))
        //       .setPositiveButton(Strings.get('ok'), Get.back)
        //       .show();
        // } else {
        Preference.setLogin(true);
        Toasty.success('${'welcome'.t} ${user.name.nullSafe.inCaps}');
        Get.offAll(() => Dashboard());
        status.value = Status.COMPLETED;
        // }
      } else {
        MyAlertDialog()
            .setTitle('Login Error')
            .setMessage(json['message'] ?? 'somethingWentWrong'.t)
            .setTextSelectable()
            .setPositiveButton('OK', null)
            .show();
        status.value = Status.COMPLETED;
      }
    } catch (e) {
      Logger.e(tag: "LOGIN ERROR", value: e, sendToServer: true);
      Toasty.failed(json['message'] ?? 'somethingWentWrong'.t);
      status.value = Status.COMPLETED;
    }
  }
}
