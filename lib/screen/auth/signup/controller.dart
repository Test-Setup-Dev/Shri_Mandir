import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/model/result.dart';
import 'package:mandir/model/user.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/utils/const.dart';
import 'package:mandir/utils/logger.dart';
import 'package:mandir/utils/preference.dart';
import 'package:mandir/utils/toasty.dart';
import 'dart:async';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/dialogs/alert_dialog.dart';

class SignupController extends GetxController {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final Rx<Result> loginResult = Result().obs;
  ScrollController scrollController = ScrollController();
  final emailFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  var fcmToken = '';
  var obscurePassword = true.obs;
  final RxString status = Status.NORMAL.obs;
  final RxString dataResponse = 'Unknown'.obs;
  final RxString phoneCode = '91'.obs;
  bool gmailAdded = false;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  //
  // void signup() {
  //   String name = nameCtrl.text.trim();
  //   String email = emailCtrl.text.trim();
  //   String phone = phoneCtrl.text.trim();
  //   String password = passwordCtrl.text.trim();
  //
  //   if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
  //     Toasty.failed('Please fill all fields');
  //     return;
  //   }
  //   Toasty.success('Account created for $name');
  //   Get.offAll(() => Dashboard());
  // }

  void signup() async {
    if (Helper.isEmpty(emailCtrl.text)) {
      Toasty.info('Please enter email!');
      return;
    }

    if (Helper.isEmpty(passwordCtrl.text)) {
      Toasty.info('pleaseEnterPassword'.t);
      return;
    }

    status.value = Status.PROGRESS;

    try {
      Repository.instance
          .signup(
            nameCtrl.text,
            emailCtrl.text,
            phoneCtrl.text,
            passwordCtrl.text,
          )
          .then(signupSuccess);
    } catch (e) {
      Logger.ex(
        baseName: runtimeType,
        tag: 'SIGNUP EXC',
        value: e,
        sendToServer: true,
      );
      status.value = Status.COMPLETED;
    } finally {
      status.value = Status.COMPLETED;
    }
  }

  void signupSuccess(var json) async {
    Logger.r(tag: 'Signup Logger', value: json);
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
            .setTitle('Signup Error')
            .setMessage(json['message'] ?? 'somethingWentWrong'.t)
            .setTextSelectable()
            .setPositiveButton('OK', null)
            .show();
        status.value = Status.COMPLETED;
      }
    } catch (e) {
      Logger.e(tag: "SIGNUP ERROR", value: e, sendToServer: true);
      Toasty.failed(json['message'] ?? 'somethingWentWrong'.t);
      status.value = Status.COMPLETED;
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
